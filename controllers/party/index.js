const {
  create,
  getOne,
  getAll,
  update,
  destroy,
} = require("../../services/party");
const responseHandler = require("../../helpers/responseHandler");

const createParty = async (req, res, next) => {
  try {
    const result = await create(req);

    return responseHandler.created(res, "Success create party!", result);
  } catch (error) {
    next(error);
  }
};

const getParty = async (req, res, next) => {
  try {
    const result = await getOne(req);

    return responseHandler.succes(res, "Success get party!", result);
  } catch (error) {
    next(error);
  }
};

const getParties = async (req, res, next) => {
  try {
    const result = await getAll();

    return responseHandler.succes(res, "Success get parties!", result);
  } catch (error) {
    next(error);
  }
};

const updateParty = async (req, res, next) => {
  try {
    const result = await update(req);

    return responseHandler.succes(res, "Success update party!", result);
  } catch (error) {
    next(error);
  }
};

const destroyParty = async (req, res, next) => {
  try {
    const result = await destroy(req);

    return responseHandler.succes(res, "Success delete party!", result);
  } catch (error) {
    next(error);
  }
};

module.exports = {
  createParty,
  getParty,
  getParties,
  updateParty,
  destroyParty,
};
