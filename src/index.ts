import express from "express";
import { ApolloServer } from "@apollo/server";
import fs from "fs";
import { expressMiddleware } from "@apollo/server/express4";
import bodyParser from "body-parser";
import cors from "cors";
import { config } from "dotenv";

config();

const app = express();
app.use(
  express.json({
    limit: "5kb",
  }),
);

const schema = fs.readFileSync("map-docs/v1/schema.graphqls", "utf8");

const apollo = new ApolloServer({
  typeDefs: schema,
});
await apollo.start();

app.use(
  "/graphql",
  cors<cors.CorsRequest>(),
  bodyParser.json(),
  expressMiddleware(apollo),
);

app.listen(4000);
