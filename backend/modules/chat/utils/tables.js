import log from "../../../utils/logger/logger";

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
        [createMessagesTableQuery, createUsersTableQuery].forEach(async (qq) => {
            await client.execute(qq)
                .then(() => {
                    log.info('Table created or already exists');
                })
                .then(() => {
                    log.info('Index created or already exists');
                })
                .catch(error => {
                    log.error("Error creating cassandra tables: ", error)
                });
        })
    } catch (error) {
        log.error("Error creating cassandra tables: ", error)
    }
}


export default createTables