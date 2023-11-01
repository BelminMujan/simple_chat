import winston, { format } from 'winston'
const { combine, timestamp, printf } = format;


const logFormat = printf(({ level, message, timestamp }) => {
    return `${timestamp} [${level.toUpperCase()}] ${message}`;
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