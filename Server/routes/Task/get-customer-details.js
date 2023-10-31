import exprees from 'express';
import pool from '../../dbcon.js';
import { authTocken } from '../../middleware/authentication.js';

const router = exprees.Router();

router.get('/', authTocken, async (req, res) => {
    try {
        const query1 = {
            text: '',
            values : [req.user.user_id]
        }
        const customerDetails = await pool.query(query1);

    } catch (error) {
        res.status(500).json({error: error.message});
    }

});

export default router;