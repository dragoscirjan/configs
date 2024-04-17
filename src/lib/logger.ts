import * as winston from 'winston';

export const logger = winston.createLogger({
  level: process.env.LOG_LEVEL ?? 'info',
  transports: [
    new winston.transports.Console({
      format: winston.format.combine(winston.format.colorize({all: true}), winston.format.simple()),
    }),
  ],
});
