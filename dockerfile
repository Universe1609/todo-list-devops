FROM node:18.9.0-alpine as builder
WORKDIR /build-stage
COPY package*.json .
RUN npm install

FROM node:18.9.0-alpine
WORKDIR /app
USER root
RUN apk add --no-cache bash && \
    mkdir -p /etc/todos && chown node:node /etc/todos

COPY --from=builder /build-stage/node_modules ./node_modules
COPY src/ ./src
COPY spec/ ./spec
COPY wait-for-it.sh docker-entrypoint.sh package*.json ./
RUN chmod +x ./wait-for-it.sh ./docker-entrypoint.sh
USER node
EXPOSE 3000
#COPY --from=builder /build-stage/dist ./dist
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD [ "npm", "start" ]
