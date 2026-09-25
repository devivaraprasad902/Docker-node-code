const fs = require("fs");
const path = require("path");
const getMessage = require("app-message");

const dist = path.join(__dirname, "dist");
const source = path.join(__dirname, "src", "server.js");
const destination = path.join(dist, "server.js");

fs.rmSync(dist, { recursive: true, force: true });
fs.mkdirSync(dist, { recursive: true });

let server = fs.readFileSync(source, "utf8");
server = server.replace(
  'process.env.APP_MESSAGE || "Hello from Node.js!"',
  JSON.stringify(getMessage())
);

fs.writeFileSync(destination, server);
console.log("Build completed: dist/server.js");
