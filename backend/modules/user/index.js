import { login } from "./controllers/userController.js"

import { Router } from "express"
const routes = Router()
routes.get("", login)

export default routes