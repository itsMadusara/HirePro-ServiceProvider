import express from 'express';
import pool from '../../dbcon.js';
import bcrypt from 'bcrypt';
import { authTocken } from '../../middleware/authentication.js';

const router = express.Router();

router.get('/', authTocken, async (req, res) => {
    try {
        const query = {
            text: 'SELECT * FROM public."ServiceProvider"',
        };
        const result = await pool.query(query);
        res.json(result.rows);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

export default router;