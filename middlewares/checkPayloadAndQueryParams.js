import logger from "../logger/logger.js";


// Function to check for any payload or query parameters in the request

const checkPayloadAndQueryParams = (req, res, next) => {
  try {
    if (Object.keys(req.body).length > 0 || parseInt(req.headers['content-length']) > 0) {
      return res
        .status(400)
        .header("Cache-Control", "no-cache, no-store, must-revalidate")
        .header("Pragma", "no-cache")
        .header("X-Content-Type-Options", "nosniff")
        .send();
    }
    if (Object.keys(req.query).length > 0) {
      return res
        .status(400)
        .header("Cache-Control", "no-cache, no-store, must-revalidate")
        .header("Pragma", "no-cache")
        .header("X-Content-Type-Options", "nosniff")
        .send();
    }
    next();
  } catch (error) {
    return res.status(500).send();
  }
};

const handlePayload= (req, res, next) => {
 
  // Check if 'content-length' header is present and greater than 0
  if (req.headers['content-length'] && parseInt(req.headers['content-length']) > 0) {
      return res
          .status(400)
          .set("Cache-Control", "no-cache, no-store, must-revalidate")
          .set("Pragma", "no-cache")
          .set("X-Content-Type-Options", "nosniff")
          .send();
  }

  // Check if req.body is defined and non-empty
  if (req.body && Object.keys(req.body).length > 0) {
      return res
          .status(400)
          .set("Cache-Control", "no-cache, no-store, must-revalidate")
          .set("Pragma", "no-cache")
          .set("X-Content-Type-Options", "nosniff")
          .send();
  }
  next();
};

function validateQueryParams(req, res, next) {
  const { username, token } = req.query;
  if (!username || !token) {
      return res.status(400).json({ message: "Please provide proper query parameters." });

  }
  next();
}


export {checkPayloadAndQueryParams, handlePayload, validateQueryParams} ;