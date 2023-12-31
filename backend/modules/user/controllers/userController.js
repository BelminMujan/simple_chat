import { Op } from "sequelize"
import log from "../../../utils/logger/logger.js"
import User from "../models/user.js"
import bcrypt from "bcrypt"
import jwt from "jsonwebtoken"
import env from "../../../config/env.js"
import { UserMessageDto } from "../models/userMessageDto.js"

export const login = async (req, res) => {
    try {
        const { username, password } = req.body


        let user = await User.findOne({
            where: {
                [Op.or]: {
                    email: username,
                    username: username
                }
            }
        })
        if (!user) {
            return res.status(400).json({ error: "Invalid credentials" })
        }

        const passCorrect = await bcrypt.compare(password, user.password)
        user = user.get();
        delete user.password
        delete user.createdAt
        delete user.updatedAt
        if (!passCorrect) {
            return res.status(400).json({ error: "Invalid credentials" })
        }

        const token = await jwt.sign({ email: user.email, username: user.username }, env.jwtKey, { expiresIn: "3h" })

        return res.status(200).json({ success: "Succesfully logged in!", data: { user: user, token: token } })
    } catch (error) {
        log.error(error)
    }
}

export const register = async (req, res) => {
    try {
        const { email, username, password, passwordConfirm } = req.body
        log.info(`Registering new user: ${email}, ${username}`)

        let user = await User.create({ email, username, password, passwordConfirm })
        user = user.get();
        delete user.password
        delete user.createdAt
        delete user.updatedAt
        const token = await jwt.sign({ email: user.email, username: user.username }, env.jwtKey, { expiresIn: "3h" })

        return res.status(201).json({ success: "User registerd", data: { user: user, token: token } })
    } catch (error) {
        log.error(error)
        return res.status(500).json({ error: error })
    }
}

export const autoLogin = (req, res) => {
    try {
        log.info("Authenticated")
    } catch (error) {
        log.error(error)
    }
}

export const listUsers = async (req, res) => {
    try {
        let users = await User.findAll({
            where: {
                id: {
                    [Op.not]: req.user.id,
                },
            },
        });
        let usersDto = users.map(u => new UserMessageDto(u))
        return res.status(200).json({ success: "Users listed!", data: usersDto })
    } catch (error) {
        log.error(error)
        return res.status(500).json({ error: error })

    }
}