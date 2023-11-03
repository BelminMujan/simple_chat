import { autoLogin, login, register, listUsers } from "./controllers/userController.js"
import { Router } from "express"
import { validateLogin, validateRegister } from "./middlewares/validation.js"
import { authenticate } from "./middlewares/authorize.js"
import User from "./models/user.js"  //to run automigrations

const routes = Router()

routes.post("/login", validateLogin, login)
routes.post("/register", validateRegister, register)
routes.get("/auto_login", authenticate, autoLogin)
routes.get("/list_users", authenticate, listUsers)

export default routes