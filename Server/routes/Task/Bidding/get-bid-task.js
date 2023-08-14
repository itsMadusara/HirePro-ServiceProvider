import exprees from 'express';
import pool from '../../../dbcon.js';
import { authTocken } from '../../../middleware/authentication.js';

const router = exprees.Router();

router.get('/', authTocken, async (req, res) => {
    try {
        const query = {
            text: 'SELECT * FROM public."Service";'
        }
        const tasks = await pool.query(query);
        res.json(tasks.rows);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

export default router;