FROM node:24-alpine as dependencies
WORKDIR /myapp
COPY package*.json ./
RUN npm ci

FROM node:24-alpine as build
WORKDIR /myapp
COPY --from=dependencies /myapp/node_modules ./node_modules
COPY . .
RUN npm run build

FROM node:24-alpine as prod
WORKDIR /myapp
COPY package*.json ./
RUN npm ci --omit=dev
COPY --from=build /myapp/dist ./dist
RUN chown -R node:node /myapp
USER node
EXPOSE 3000
CMD ["node", "dist/server.js"]
