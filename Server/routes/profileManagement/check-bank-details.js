import exprees from 'express';
import pool from '../../dbcon.js';
import { authTocken } from '../../middleware/authentication.js';

const router = exprees.Router();

router.get('/', authTocken, async (req, res) => {
    try {
        const query1 = {
            text: `SELECT CASE WHEN account_no IS NULL THEN 'false' ELSE 'true' END
            FROM public."ServiceProvider"
            WHERE id = '23';`,
            // values: [req.user.user_id]
        };
        const isAccountDetailsAdded = await pool.query(query1);
        console.log(isAccountDetailsAdded.rows);

        res.json(isAccountDetailsAdded.rows[0])

        // const query2 = {
        //     text: 'UPDATE public."ServiceProvider" set category=$1 where id=$2;',
        //     values : [newValue, req.user.user_id]
        // };

    } catch (error) {
        res.status(500).json({error: error.message});
    }
});


export default router;