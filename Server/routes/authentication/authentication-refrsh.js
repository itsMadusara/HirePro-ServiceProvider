import jwt from 'jsonwebtoken';
import { jwtTokens } from '../../utils/jwt-helpers.js';
import exprees from 'express';

const router = exprees.Router();

router.get('/', async (req, res) => {
    const token = req.headers['authorization'];
    if (token == null) {
        return res.status(401).json({error: 'Access denied. Null Refresh token.'});
    }

    try {
        jwt.verify(token, process.env.REFRESH_TOKEN_SECRET, (err, user) => {
            if (err) {
                return res.status(403).json({error: 'Invalid token.'});
            }
            const userLoginAttri = { user_id: user.user_id, user_name: user.user_name, user_email: user.user_email};
            const tokens = jwtTokens(userLoginAttri);
            // res.cookie('refresh_token', tokens.refreshToken, {httpOnly: true});
            // res.cookie('access_token', tokens.accessToken, {httpOnly: true});
            res.json({tokens})
            req.user = user;
        });
    } catch (error) {
        res.status(400).json({error: 'Invalid token'});
    }
});

export default router;

// function authRefresh(req, res, next) {
//     const token = req.headers['authorization'];
//     if (token == null) {
//         return res.status(401).json({error: 'Access denied. Null Refresh token.'});
//     }

//     try {
//         jwt.verify(token, process.env.REFRESH_TOKEN_SECRET, (err, user) => {
//             if (err) {
//                 return res.status(403).json({error: 'Invalid token.'});
//             }
//             const userLoginAttri = { user_id: user.user_id, user_name: user.user_name, user_email: user.user_email};
//             const tokens = jwtTokens(userLoginAttri);
//             // res.cookie('refresh_token', tokens.refreshToken, {httpOnly: true});
//             // res.cookie('access_token', tokens.accessToken, {httpOnly: true});
//             res.json({newToken: tokens})
//             req.user = user;
//             next();
//         });
//     } catch (error) {
//         res.status(400).json({error: 'Invalid token'});
//     }
// }