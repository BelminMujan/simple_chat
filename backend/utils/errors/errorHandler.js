import log from "../logger/logger.js"

const errorHandler = (req, res, next) => {
    process.on("uncaughtException", (err) => {
        log.error(err)
    })
    process.on("unhandledRejection", (err) => {
        log.error(err)
    })
}

export default errorHandler