import dotenv from "dotenv"

dotenv.config()

export default {
    port: process.env?.PORT,
    database: process.env.DATABASE,
    databaseUser: process.env.DB_USER,
    databasePassword: process.env.DB_PASS,
    databaseHost: process.env.DB_HOST,
    jwtKey: process.env.JWT_KEY,
    cassandrUser: process.env.CASSANDRA_USER,
    cassandrPass: process.env.CASSANDRA_PASS
}