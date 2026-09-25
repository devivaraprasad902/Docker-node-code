# Node.js Multi-Stage Docker App

A basic Node.js application for practicing a 3-stage Docker build.

## Stages

1. `dependencies` - installs dependencies including the build-time dependency.
2. `build` - runs `npm run build` and creates `dist/server.js`.
3. `prod` - installs only production dependencies, copies `dist`, and runs as the non-root `node` user.

## Run locally

```bash
npm install
npm run build
npm start
```

Open http://localhost:3000

Health endpoint: http://localhost:3000/health

## Docker

```bash
docker build -t node-multistage .
docker run -d --name node-app -p 3000:3000 node-multistage
```

Open http://localhost:3000
