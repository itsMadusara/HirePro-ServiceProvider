import exprees from 'express';
import pool from '../../dbcon.js';
import { authTocken } from '../../middleware/authentication.js';

const router = exprees.Router();

router.post('/', authTocken, async (req, res) => {
    try {
        const query1 = {
            text: 'SELECT category FROM public."ServiceProvider" where id=$1;',
            values : [req.user.user_id]
        };
        const taskCategories = await pool.query(query1);
        const categories = taskCategories.rows[0].category ?? [];

        const newCategory = req.body.category;
        let requestCategories;

        if (!(categories.includes(newCategory))){
            const query2 = {
                text: 'INSERT INTO public."categoryReview" (providerid, category) VALUES ($1, $2);',
                values : [req.user.user_id, newCategory]
            };
            requestCategories = await pool.query(query2);
        }

        const query3 = {
            text: 'SELECT id FROM public."categoryReview" WHERE providerid=$1 AND category=$2;',
            values : [req.user.user_id, newCategory]
        };
        const newCategoryId = await pool.query(query3);

        res.json({message: 'Category Request Successful', requestId: newCategoryId.rows[0].id});

    } catch (error) {
        res.status(500).json({error: error.message});
    }
});


export default router;