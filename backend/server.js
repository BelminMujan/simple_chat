import express from "express"
import log from "./utils/logger/logger.js"
import userRoutes from "./modules/user/index.js"
import errorHandler from "./utils/errors/errorHandler.js"
import env from "./config/env.js"
const app = express()

app.use(express.json())
errorHandler()

app.use("/api/users", userRoutes)

app.listen(env.PORT, (error) => {
    if (error || !env.PORT) {
        log.error(`No port defined for server startup, ${error}`)
    } else {
        log.info(`Started server on port: ${env.PORT}`)
    }
})