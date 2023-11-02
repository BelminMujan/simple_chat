import { autoLogin, login, register } from "./controllers/userController.js"
import { Router } from "express"
import { validateLogin, validateRegister } from "./middlewares/validation.js"
import { authenticate } from "./middlewares/authorize.js"
import User from "./models/user.js"  //to run automigrations

const routes = Router()

routes.post("/login", validateLogin, login)
routes.post("/register", validateRegister, register)
routes.get("/auto_login", authenticate, autoLogin)

export default routes