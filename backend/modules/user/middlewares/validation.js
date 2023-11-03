import log from "../../../utils/logger/logger.js"
const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

export const validateLogin = (req, res, next) => {
    const { username, password } = req.body
    if (!username && !password) {
        return res.status(400).json({ error: "Password and email or username are required!" })
    }

    next()
}
export const validateRegister = (req, res, next) => {
    const { email, username, password, passwordConfirm } = req.body
    if (!emailRegex.test(email)) {
        return res.status(400).json({ error: "Invalid email!" })
    }
    if (!email || !username || !password || !passwordConfirm) {
        return res.status(400).json({ error: "All fields are required!" })
    }
    if (password !== passwordConfirm) {
        return res.status(400).json({ error: "Passwords must match!" })
    }

    next()
}