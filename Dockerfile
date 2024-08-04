# Stage 1

FROM node:18-alpine AS builder
WORKDIR /usr/src/app
COPY package*.json .
RUN npm i
COPY . .
RUN npm run build

# Stage 2

FROM node:18-alpine
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/dist ./
COPY --from=builder /usr/src/app/node_modules ./node_modules

EXPOSE 4000
CMD ["node", "main.js"]