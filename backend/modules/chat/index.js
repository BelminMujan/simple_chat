import { Router } from "express"
import { authenticate } from "../user/middlewares/authorize"
import { loadMessagesPerChat, sendMessage } from "./controllers/chatController"


const routes = Router()

routes.post("/send", authenticate, sendMessage)
routes.get("/load_per_chat/:room_id", authenticate, loadMessagesPerChat)

export default routes