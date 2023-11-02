import exprees from 'express';
import pool from '../../dbcon.js';
import { authTocken } from '../../middleware/authentication.js';

const router = exprees.Router();

router.post('/', authTocken, async (req, res) => {
    try {
        const query = {
            text: `UPDATE public."ServiceProviderPoints" SET points = points - $2 WHERE "ServiceProviderPoints"."serviceProviderId"=$1;`,
            // values : [req.body.points,req.user.user_id]
            values : [req.user.user_id,req.body.points]
        };
        const remainingPoints = await pool.query(query);
        res.json({message: 'points converted successfully'});
      } catch (error) {
        res.status(500).json({error: error.message});
      }
});

export default router;