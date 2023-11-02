import { Sequelize } from "sequelize";
import env from "./env.js";
import log from "../utils/logger/logger.js";

const connection = new Sequelize(env.database, env.databaseUser, env.databasePassword, {
    host: env.databaseHost,
    dialect: "mysql",
})

connection.authenticate().then(() => {
    log.info("Connecting to database...");
    connection.sync({ force: false }).then(() => {
        log.info("Database connected and synced")
    }).catch((err) => {
        log.error(err)
    })
}).catch(err => {
    log.error(err)
})

export default connection