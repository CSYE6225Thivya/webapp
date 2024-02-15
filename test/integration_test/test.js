import axios from "axios";
import { expect } from "chai";

axios.defaults.baseURL = "http://localhost:8080";

describe("User Endpoint Integration Tests", () => {
  it("should create an account and validate its existence with GET", async () => {
    // Send a POST request to create a new user
    const createUserResponse = await axios.post("/v1/user", {
      first_name: "test",
      last_name: "test",
      username: "test111@example.com",
      password: "test",
    });
    // Expect response status code to be 201
    expect(createUserResponse.status).to.equal(201);
    const userId = createUserResponse.data.id;
    // Authenticate
    const authHeader = `Basic ${Buffer.from(
      "test111@example.com:test"
    ).toString("base64")}`;
    // Send a GET request
    const getUserResponse = await axios.get("/v1/user/self", {
      headers: {
        Authorization: authHeader,
      },
    });
    // Expect the response status code to be 200 (OK)
    expect(getUserResponse.status).to.equal(200);
    expect(getUserResponse.data.id).to.equal(userId);
  });

  it("should update an account and validate the changes with GET", async () => {
    // Authenticate
    const authHeader = `Basic ${Buffer.from(
      "test111@example.com:test"
    ).toString("base64")}`;
    // Send a PUT request
    const updateUserResponse = await axios.put("/v1/user/self", {
      first_name: 'testnew',
      last_name: 'testnew',
      password: 'test'
    }, {
      headers: {
        Authorization: authHeader,
      },
    });
    expect(updateUserResponse.status).to.equal(204);
    // Send a GET request
    const getUserResponse = await axios.get("/v1/user/self", {
      headers: {
        Authorization: authHeader,
      },
    });
    expect(getUserResponse.status).to.equal(200);
    expect(getUserResponse.data.first_name).to.equal("testnew");
  });
});
