

// createTables(client)

export default client

import log from "../../../utils/logger/logger.js";
import { v4 as uuidv4 } from 'uuid'
import client from "../services/cassandra.js";

const sendMessage = async (room_id, from, message) => {
    try {
        const timestamp = new Date().getTime();
        const message_id = uuidv4()
        const query = `INSERT INTO jobspot.messages (room_id, message_id, from_user, message, status, created_at) VALUES (?, ?, ?, ?, ?, now()) if not exists;`;
        const params = [room_id, message_id, parseInt(from), message, 'sent'];
        let res = await client.execute(query, params, { prepare: true })
        if (res && res.rows[0]['[applied]']) {
            return {
                room_id,
                message_id,
                from_user: parseInt(from),
                message,
                status: 'sent',
                created_at: timestamp
            };
        } else {
            return null;
        }
    } catch (err) {
        log.error("Error sending message: ", err)
    }
};

const loadMessagesPerChat = async (req, res) => {
    const room_id = req.params.room_id
    const query = `SELECT * FROM jobspot.messages WHERE room_id = ?;`
    let params = [room_id]
    try {
        let res = await client.execute(query, params, { prepare: true })
        return res
    } catch (err) {
        log.error("Error loading messages: ", err)
    }
}
export { sendMessage, loadMessagesPerChat }