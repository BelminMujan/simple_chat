import cassandra from "cassandra-driver"
import env from "../../../config/env.js"

let authProvider = new cassandra.auth.PlainTextAuthProvider(env.cassandrUser, env.cassandrPass)
const contactPoints = ["127.0.0.1:9042"]

const localDataCenter = "datacenter1"

const keyspace = "simple_chat"

const client = new cassandra.Client({
    contactPoints: contactPoints,
    authProvider: authProvider,
    localDataCenter: localDataCenter,
    keyspace: keyspace,

})

export default client