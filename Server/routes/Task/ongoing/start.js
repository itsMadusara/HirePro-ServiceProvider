import exprees from 'express';
import pool from '../../../dbcon.js';
import { authTocken } from '../../../middleware/authentication.js';

const router = exprees.Router();

router.post('/', authTocken, async (req, res) => {
    try {
        const query = {
            text: 'UPDATE public."Service" set status=\'Started\' where id=$1;',
            values: [req.body.serviceid]
        }
        const user = await pool.query(query);

        const query1 = {
            text: 'INSERT INTO public."providerCurrentLocation" (serviceid) VALUES ($1);',
            values: [req.body.serviceid]
        }
        const user1 = await pool.query(query1);

        res.json({message: 'Status Set to Started'});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

export default router;