import exprees from 'express';
import pool from '../../dbcon.js';
import { authTocken } from '../../middleware/authentication.js';

const router = exprees.Router();

router.post('/', authTocken, async (req, res) => {
    try {
        const query = {
            text: 'INSERT INTO public."ServiceProviderReport" ("timestamp","content","serviceid","spid") VALUES (NOW(),$1,$2,$3);',
            values : [req.body.content,req.body.serviceid,req.user.user_id]
        };
        const report = await pool.query(query);
        res.json({message: 'complaint details added successfully'});
      } catch (error) {
        res.status(500).json({error: error.message});
      }
});

export default router;