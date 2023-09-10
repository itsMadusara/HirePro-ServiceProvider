import exprees from 'express';
import pool from '../../dbcon.js';
import bcrypt from 'bcrypt';
import { authTocken } from '../../middleware/authentication.js';
import { jwtTokens } from '../../utils/jwt-helpers.js';

const router = exprees.Router();

router.post('/', authTocken, async (req, res) => {
    try {
        const query = {
            text: 'SELECT * FROM public."ServiceProvider" WHERE email = $1',
            values: [req.user.user_email]
        }
        const user = await pool.query(query);
        if (user.rows.length === 0) {
            return res.status(404).json({error: 'User not found'});
        }
    
        // Check password
        const match = await bcrypt.compare(req.body.oldPassword, user.rows[0].password_hash);
        if (!match) {
            return res.status(401).json({error: 'Incorrect password'});
        }

        const password = req.body.newPassword;
        const hashedPassword = await bcrypt.hash(password, 10);

        const query2 = {
            text: 'UPDATE public."ServiceProvider" set password_hash = $1 WHERE id = $2',
            values: [hashedPassword, req.user.user_id]
        }

        const newUser = await pool.query(query2);

        const userLoginAttri = { user_id: req.user.user_id, user_name: req.body.name, user_email: req.body.email};
        const tokens = jwtTokens(userLoginAttri);
        res.cookie('refresh_token', tokens.refreshToken, {httpOnly: true});
        res.cookie('access_token', tokens.accessToken, {httpOnly: true});
        res.json({message: 'Password updated successfully'});

    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

export default router;