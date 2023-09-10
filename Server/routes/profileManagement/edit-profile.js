import exprees from 'express';
import pool from '../../dbcon.js';
import { authTocken } from '../../middleware/authentication.js';
import { jwtTokens } from '../../utils/jwt-helpers.js';

const router = exprees.Router();

router.post('/', authTocken, async (req, res) => {
    try {
        const query = {
            text: 'UPDATE public."ServiceProvider" set name = $1, email = $2, intro = $3, contact = $4 WHERE id = $5',
            values: [req.body.name, req.body.email, req.body.intro, req.body.contact, req.user.user_id]
        }
        const result = await pool.query(query);
        
        const userLoginAttri = { user_id: req.user.user_id, user_name: req.body.name, user_email: req.body.email};
        const tokens = jwtTokens(userLoginAttri);
        res.cookie('refresh_token', tokens.refreshToken, {httpOnly: true});
        res.cookie('access_token', tokens.accessToken, {httpOnly: true});

        res.json({message: 'Profile updated successfully'});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

export default router;