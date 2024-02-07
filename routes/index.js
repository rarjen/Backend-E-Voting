const router = require("express").Router();
const responseHandler = require("../helpers/responseHandler");
const auth = require("./auth");
const party = require("./party");

router.get("/", (req, res) => {
  return responseHandler.succes(res, "Test Route");
});

router.use("/auth", auth);
router.use("/party", party);

module.exports = router;
