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

        if (!(categories.includes(newCategory))){
            categories.push(newCategory);
        }

        console.log(categories);
        let newValue = "{";

        for ( let i=0 ; i<categories.length ; i++ ){
            newValue += categories[i];
            if ( i !== categories.length-1 ){
                newValue += ",";
            }
        }

        newValue += "}";

        console.log(newValue);

        const query2 = {
            text: 'UPDATE public."ServiceProvider" set category=$1 where id=$2;',
            values : [newValue, req.user.user_id]
        };

        const taskUpdate = await pool.query(query2);
        console.log(taskUpdate);

    } catch (error) {
        res.status(500).json({error: error.message});
    }
});


export default router;