const http = require("http");

const PORT = 3000;

const server = http.createServer((req, res) => {
  if (req.url === "/health") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ status: "UP" }));
    return;
  }

  res.writeHead(200, { "Content-Type": "text/plain" });
  res.end(process.env.APP_MESSAGE || "Hello from Node.js!");
});

server.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${PORT}`);
});
