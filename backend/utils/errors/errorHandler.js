import log from "../logger/logger.js"

const errorHandler = () => {
    process.on("uncaughtException", (err) => {
        log.error(err)
    })
    process.on("unhandledRejection", (err) => {
        log.error(err)
    })
}

export default errorHandler