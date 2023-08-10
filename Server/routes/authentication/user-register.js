import express from 'express';
import pool from '../../dbcon.js';
import bcrypt from 'bcrypt';

const router = express.Router();

router.post('/', async (req, res) => {
    try {
      const password = req.body.password;
      const hashedPassword = await bcrypt.hash(password, 10);
      const query = {
        text: 'INSERT INTO public."ServiceProvider" (contact, name, email, nic, password_hash) VALUES ($1, $2, $3, $4, $5)',
        values: [req.body.contact, req.body.name, req.body.email, req.body.nic, hashedPassword]
      }
      const newUser = await pool.query(query);
      res.json({status : "True" , newUser});
    } catch (error) {
      res.status(500).json({error: error.message});
    }
});

export default router;