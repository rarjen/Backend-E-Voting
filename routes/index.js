const router = require("express").Router();
const responseHandler = require("../helpers/responseHandler");
const auth = require("./auth");
const party = require("./party");
const presidental = require("./presidental");
const vicePresidental = require("./vice_presidental");

router.get("/", (req, res) => {
  return responseHandler.succes(res, "Test Route");
});

router.use("/auth", auth);
router.use("/party", party);
router.use("/presidental", presidental);
router.use("/vice-presidental", vicePresidental);

module.exports = router;
