import log from "../../../utils/logger/logger.js";

const createMessagesTableQuery = `CREATE TABLE IF NOT EXISTS simple_chat.messages (
    message_id UUID,
    room_id TEXT,
    from_user INT,
    message TEXT,
    status TEXT,
    created_at timeuuid,
    PRIMARY KEY (room_id, created_at)
) WITH CLUSTERING ORDER BY (created_at ASC);`;

const createUsersTableQuery = `CREATE TABLE IF NOT EXISTS simple_chat.rooms (
  room_id TEXT,
  user1 INT,
  user2 INT,
  PRIMARY KEY (room_id)
);`;


const createTables = async (client) => {
    try {
        log.info("Migrating cassandra tables!")
        client.execute(createMessagesTableQuery).then(res => {
            log.info("Cassandra messages table created")
        }).catch(e => {
            log.error("Error creating messages table in cassandra: ", e)
        })
        client.execute(createUsersTableQuery).then(res => {
            log.info("Cassandra rooms table created")
        }).catch(e => {
            log.error("Error creating messages table in cassandra: ", e)
        })

    } catch (error) {
        log.error("Cassandra createTables error: ", error)
    }
}


export default createTables