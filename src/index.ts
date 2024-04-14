import express from "express";

const app = express();
app.use(express.json({ limit: "50mb" }));

app.listen(4000);
