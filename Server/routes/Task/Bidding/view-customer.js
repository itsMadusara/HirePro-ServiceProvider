import exprees from 'express';
import pool from '../../../dbcon.js';
import { authTocken } from '../../../middleware/authentication.js';

const router = exprees.Router();

router.get('/', authTocken, async (req, res) => {
    try {

        const query1 = {
            text: 'SELECT name FROM public."Customer" WHERE id = $1;',
            values : [req.body.customerid]
        };
        const taskBid = await pool.query(query1);
        const name = taskBid.rows[0].name;

        res.json({name: name});

    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

export default router;