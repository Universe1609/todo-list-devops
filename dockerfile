FROM node:18.9.0-alpine as builder
WORKDIR /build-stage
COPY package*.json .
RUN npm install

FROM node:18.9.0-alpine
WORKDIR /app
USER root
RUN apk add bash
RUN mkdir -p /etc/todos && chown node:node /etc/todos
COPY . ./
RUN chmod +x ./wait-for-it.sh ./docker-entrypoint.sh
USER node
COPY --from=builder /build-stage/node_modules ./node_modules
EXPOSE 3000
#COPY --from=builder /build-stage/dist ./dist
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD [ "npm", "start" ]
