import exprees from 'express';
import pool from '../../dbcon.js';
import { authTocken } from '../../middleware/authentication.js';

const router = exprees.Router();

router.get('/', authTocken, async (req, res) => {
    try {
        const query = {
            text: 'SELECT id, name, email, intro, contact, points, category, verify_image FROM public."ServiceProvider" WHERE id = $1',
            values: [req.user.user_id]
        }
        const user = await pool.query(query);
        res.json(user.rows[0]);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

export default router;