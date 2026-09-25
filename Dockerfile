FROM node:24-alpine AS dependencies

WORKDIR /myapp

COPY package*.json ./
COPY packages ./packages
RUN npm ci


FROM node:24-alpine AS build

WORKDIR /myapp

COPY --from=dependencies /myapp/node_modules ./node_modules
COPY package*.json ./
COPY build.js ./
COPY src ./src

RUN npm run build


FROM node:24-alpine AS prod

WORKDIR /myapp

COPY package*.json ./
RUN npm ci --omit=dev

COPY --from=build /myapp/dist ./dist

RUN chown -R node:node /myapp

USER node

EXPOSE 3000

CMD ["node", "dist/server.js"]
