const router = require("express").Router();
const responseHandler = require("../helpers/responseHandler");
const auth = require("./auth");

router.get("/", (req, res) => {
  return responseHandler.succes(res, "Test Route");
});

router.use("/auth", auth);

module.exports = router;
