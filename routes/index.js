const router = require("express").Router();
const responseHandler = require("../helpers/responseHandler");
const auth = require("./auth");
const party = require("./party");
const presidental = require("./presidental");
const vicePresidental = require("./vice_presidental");
const pair_number = require("./candidate_pair_number");

router.get("/", (req, res) => {
  return responseHandler.succes(res, "Test Route");
});

router.use("/auth", auth);
router.use("/party", party);
router.use("/presidental", presidental);
router.use("/vice-presidental", vicePresidental);
router.use("/pair-number", pair_number);

module.exports = router;
