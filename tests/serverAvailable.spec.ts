import fetch from "node-fetch";

test("can reach server", async () => {
  const response = await fetch("http://localhost:4000");
  expect(response.status).toBe(404);
});
