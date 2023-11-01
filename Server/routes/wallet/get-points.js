import express from 'express';
import pool from '../../dbcon.js';
import { authTocken } from '../../middleware/authentication.js';

const router = express.Router();

router.get('/', authTocken, async (req, res) => {
    try {
        const query = {
            text: 'SELECT points FROM public."ServiceProviderPoints" WHERE "ServiceProviderPoints"."serviceProviderId"=$1;',
            values : [req.user.user_id]
        };
        const totalPoints = await pool.query(query);
        const points = totalPoints.rows[0].points;

        res.json({points: points});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

export default router;