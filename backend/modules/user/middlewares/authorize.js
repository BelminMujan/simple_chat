import jwt from "jsonwebtoken"
import log from "../../../utils/logger/logger.js"
import env from "../../../config/env.js"
import User from "../models/user.js"

export const authenticate = async (req, res, next) => {
    try {
        const authHeader = req.headers['authorization']
        const token = authHeader.split(" ")[1]
        if (!token) {
            return res.status(401).json({ error: 'Authentication required' });
        }
        jwt.verify(token, env.jwtKey, async (err, user) => {
            if (err) {
                log.error(err)
                return res.status(403).json({ error: 'Token is not valid' });
            }
            let uu = await User.findOne({ where: { email: user.email } })
            req.user = uu;
            next();
        });
    } catch (error) {
        log.error(error)
        return res.status(500).json({ error: "Server error! " })
    }

}