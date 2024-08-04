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
COPY --from=builder /usr/src/app/dist .

EXPOSE 4000
CMD ["node", "dist/main.js"]