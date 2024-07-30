import fetch from "node-fetch";

test("can reach server", async () => {
  const response = await fetch("http://localhost:4000");
  expect(response.status).toBe(404);
});

test("can reach apollo Grahpql endpoint", async () => {
  const response = await fetch("http://localhost:4000/graphql");
  // Just sending an empty query gives an error because we need a query to do something with graphql
  expect(response.status).toBe(400);
});
