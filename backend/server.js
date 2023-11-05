import express from "express"
import log from "./utils/logger/logger.js"
import userRoutes from "./modules/user/index.js"
import messagesRoutes from "./modules/chat/index.js"
import errorHandler from "./utils/errors/errorHandler.js"
import env from "./config/env.js"
import http from "http"
import cors from "cors"

import dbConnection from "./config/database.js"
import { Server } from "socket.io"
import { initializeChat } from "./modules/chat/controllers/chatController.js"


const app = express()
const server = http.createServer(app)

app.use(express.json())
errorHandler()
app.use(cors())
app.use("/api/users", userRoutes)
app.use("/api/messages", messagesRoutes)


initializeChat(server)
server.listen(env.port, (error) => {
    if (error || !env.port) {
        log.error(`No port defined for server startup, ${error}`)
    } else {
        log.info(`Started server on port: ${env.port}`)
    }
})