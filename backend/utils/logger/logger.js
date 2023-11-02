import winston, { format } from 'winston'
const { combine, timestamp, printf, json } = format;


const logFormat = printf(({ level, name, message, timestamp }) => {
    let msg = typeof message === "string" ? message : JSON.stringify(message, null, 2)
    return `${timestamp} [${level.toUpperCase()}] ${name ? name + ":" : ""} ${msg}`;
});

const log = winston.createLogger({
    level: 'info',
    format: combine(
        timestamp({
            format: 'YYYY-MM-DD HH:mm:ss',
        }),
        logFormat,
    ),
    transports: [
        new winston.transports.Console(),
        new winston.transports.File({
            filename: './storage/logs/server.log',
        }),],
});

export default log