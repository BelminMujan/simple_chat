import { Router } from "express"
import { authenticate } from "../user/middlewares/authorize.js"
import { initializeChat, loadMessagesPerChat, sendMessage } from "./controllers/chatController.js"
import createTables from "./utils/tables.js"
import client from "./services/cassandra.js"

createTables(client)


const routes = Router()

routes.post("/send", authenticate, sendMessage)
routes.get("/load_per_chat/:room_id", authenticate, loadMessagesPerChat)

export default routes