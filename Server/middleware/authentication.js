import jwt from 'jsonwebtoken';
import { jwtTokens } from '../utils/jwt-helpers.js';

function authTocken(req, res, next) {
    const token = req.cookies.access_token;
    if (token == null) {
        return res.status(401).json({error: 'Access denied. Null token.'});
    }

    try {
        jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
            if (err) {
                if (err.name === 'TokenExpiredError') {
                    authRefresh(req, res, next);
                    return;
                }
                return res.status(403).json({error: 'Invalid token.'});
            }
            req.user = user;
            next();
        });
    } catch (error) {
        res.status(400).json({error: 'Invalid token'});
    }
}

function authRefresh(req, res, next) {
    const token = req.cookies.refresh_token;
    if (token == null) {
        return res.status(401).json({error: 'Access denied. Null token.'});
    }

    try {
        jwt.verify(token, process.env.REFRESH_TOKEN_SECRET, (err, user) => {
            if (err) {
                return res.status(403).json({error: 'Invalid token.'});
            }
            const userLoginAttri = { user_name: user.user_name, user_email: user.user_email};
            const tokens = jwtTokens(userLoginAttri);
            res.cookie('refresh_token', tokens.refreshToken, {httpOnly: true});
            res.cookie('access_token', tokens.accessToken, {httpOnly: true});
            req.user = user;
            next();
        });
    } catch (error) {
        res.status(400).json({error: 'Invalid token'});
    }
}

export {authTocken};