

// createTables(client)
import log from "../../../utils/logger/logger.js";
import { v4 as uuidv4 } from 'uuid'
import client from "../services/cassandra.js";
import { Server } from "socket.io"
import User from "../../user/models/user.js";
import jwt from "jsonwebtoken";
import { json } from "sequelize";
import env from "../../../config/env.js";

const sendMessage = async (room_id, from, message) => {
    try {
        const timestamp = new Date().getTime();
        const message_id = uuidv4()
        const query = `INSERT INTO simple_chat.messages (room_id, message_id, from_user, message, status, created_at) VALUES (?, ?, ?, ?, ?, now()) if not exists;`;
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

const loadMessagesPerChat = async (room_id) => {
    const query = `SELECT * FROM simple_chat.messages WHERE room_id = ?;`
    let params = [room_id]
    try {
        let res = await client.execute(query, params, { prepare: true })
        return res
    } catch (err) {
        log.error("Error loading messages: ", err)
    }
}

const loadRooms = async (req, res, next) => {
    try {
        let user = await req.user
        log.info("Loading chat rooms for user: " + user.email)

        let rooms = await loadRoomsForUser(user.id)
        let participantIds = rooms?.map(rr => ([rr.user1, rr.user2]))
        if (participantIds && participantIds.length !== 0) {
            participantIds = participantIds.reduce((a, b) => (a.concat(b)))
            participantIds = participantIds.filter(uid => uid !== user.id)
            let users = await User.findAll({ where: { id: participantIds }, attributes: ["id", "email", "username"] })
            return res.status(200).json(users)
        }
        return res.status(200)

    } catch (err) {
        log.error("Error laading chat rooms: ", err)
    }
}

const getRoom = async (u1, u2) => {
    try {
        let room_id = `room_${u1 > u2 ? u1 : u2}_${u1 < u2 ? u1 : u2}`
        const query = `INSERT INTO simple_chat.rooms (room_id, user1, user2) VALUES (?,?,?) if not exists;`;
        const params = [room_id, parseInt(u1), parseInt(u2)];
        await client.execute(query, params, { prepare: true })
        return {
            room_id: room_id,
            user1: u1,
            user2: u2,
        };
    } catch (err) {
        log.error("Error creating room: " + err)
    }
};

const loadRoomsForUser = async (userId) => {
    try {
        const query1 = `SELECT user1, user2 FROM simple_chat.rooms WHERE user1 = ?  ALLOW FILTERING;`
        const query2 = `SELECT user1, user2 FROM simple_chat.rooms WHERE user2 = ?  ALLOW FILTERING;`
        let rooms1 = await client.execute(query1, [parseInt(userId)], { prepare: true })
        let rooms2 = await client.execute(query2, [parseInt(userId)], { prepare: true })
        return [...rooms1.rows, ...rooms2.rows]
    } catch (error) {
        log.error("Error loading rooms for users: " + err)
    }

}


const initializeChat = (server) => {
    const io = new Server(server, {
        path: "/socket",
    })
    // io.use((socket, next) => {
    //     middleware(socket.request, {}, next)
    // })


    io.on("connection", async (socket) => {
        let userId = null
        let token = socket.handshake.headers.authorization
        let tokenData = jwt.verify(token.split(" ")[1], env.jwtKey)
        let user = await User.findOne({ where: { email: tokenData.email } })
        userId = user["id"]
        log.info("Chat invoked by user: ")
        log.info(user)
        if (userId) {

            socket.on("join_room", async (participant) => {
                log.info("Joining room: " + participant)
                let room = await getRoom(userId, participant)
                socket.join(room.room_id)
                socket.emit("joined_room", room.room_id)
                log.info("Joined room")
                let messages = await loadMessagesPerChat(room.room_id)
                if (messages && messages.rowLength !== 0) {
                    io.to(room.room_id).emit("load_messages", messages.rows)
                }
            })


            socket.on("load_messages", async () => {
                log.info("Loading messages in room: ", roomName);
                let messages = await loadMessagesPerChat(userId, participant)
                if (messages && messages.rowLength !== 0) {
                    io.to(roomName).emit("message", messages.rows)
                }
            })


            socket.on("message", async (data) => {
                log.info("Message received");
                let obj = JSON.parse(data)
                let sentMessage = await sendMessage(obj.room_id, userId, obj.message)
                log.info("Messages sent")
                log.info(sentMessage)
                io.to(obj.room_id).emit("message", sentMessage)
            })

            socket.on('disconnect', () => {
                log.info(`Chat client disconnecting`)
            });
        }
    })
}


export { sendMessage, loadMessagesPerChat, initializeChat }