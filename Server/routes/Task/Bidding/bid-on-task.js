import exprees from 'express';
import pool from '../../../dbcon.js';
import { authTocken } from '../../../middleware/authentication.js';

const router = exprees.Router();

router.post('/', authTocken, async (req, res) => {
    try {

        const query1 = {
            text: 'INSERT INTO public."Bid" ("timestamp", "additionalInfo", amount, "serviceId", "serviceProviderId") VALUES (NOW(), $1, $2, $3, $4);',
            values : [req.body.additionalInfo, req.body.bidAmount, req.body.taskid, req.user.user_id]
        };
        const taskBid = await pool.query(query1);

        const query2 = {
            text: 'UPDATE public."Service" set status=\'Pending\' where id=$1;',
            values : [req.body.taskid]
        };
        const taskStatus = await pool.query(query2);

        res.json({message: 'Bid added successfully'});

    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

export default router;