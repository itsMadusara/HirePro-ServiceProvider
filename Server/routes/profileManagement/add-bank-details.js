import exprees from 'express';
import pool from '../../dbcon.js';
import { authTocken } from '../../middleware/authentication.js';

const router = exprees.Router();

router.post('/', authTocken, async (req, res) => {
    try {
        const query = {
            text: 'UPDATE public."ServiceProvider" set account_no=$1, card_holder_name=$2, bank_name=$3, branch_name=$4 where id=$5;',
            values : [req.body.account_no,req.body.card_holder_name,req.body.bank_name,req.body.branch_name,req.user.user_id]
        };
        const accountDetails = await pool.query(query);
        res.json({message: 'bank details added updated successfully'});
      } catch (error) {
        res.status(500).json({error: error.message});
      }
});

export default router;