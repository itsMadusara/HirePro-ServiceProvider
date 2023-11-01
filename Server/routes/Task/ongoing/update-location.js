import exprees from 'express';
import pool from '../../../dbcon.js';
import { authTocken } from '../../../middleware/authentication.js';

const router = exprees.Router();

router.post('/', authTocken, async (req, res) => {
    try {
        const query = {
            text: 'UPDATE public."providerCurrentLocation" set latitude=$1, longitude=$2 where serviceid=$3;',
            values: [req.body.latitude, req.body.longitude, req.body.serviceid]
        }
        const user = await pool.query(query);
        res.json({message: 'Location Updated'});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

export default router;