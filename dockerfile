FROM node:18.9.0-alpine as builder
WORKDIR /build-stage
COPY package*.json .
RUN npm install

FROM node:18.9.0-alpine
WORKDIR /app
USER root
RUN mkdir -p /etc/todos && chown node:node /etc/todos
USER node
COPY --from=builder /build-stage/node_modules ./node_modules
COPY . .
#COPY --from=builder /build-stage/dist ./dist
CMD [ "npm", "start" ]
EXPOSE 3000
