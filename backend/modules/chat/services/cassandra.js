import cassandra from "cassandra-driver"

let authProvider = new cassandra.auth.PlainTextAuthProvider(process.env.CASSANDRA_USER, process.env.CASSANDRA_PASS)
const contactPoints = ["127.0.0.1:9042"]

const localDataCenter = "datacenter1"

const keyspace = "jobspot"

const client = new cassandra.Client({
    contactPoints: contactPoints,
    authProvider: authProvider,
    localDataCenter: localDataCenter,
    keyspace: keyspace,

})

export default client