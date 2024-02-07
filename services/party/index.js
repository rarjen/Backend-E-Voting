const { PrismaClient } = require("@prisma/client");
const ApiError = require("../../helpers/errorHandler");
const { political_party } = new PrismaClient();

const create = async (req) => {
  const result = await political_party.create({ data: req.body });

  return result;
};

const getOne = async (req) => {
  const result = await political_party.findFirst({
    where: { id: req.params.id },
  });

  if (!result) {
    throw ApiError.notFound("Data tidak ada!");
  }

  return result;
};

const getAll = async (req) => {
  const result = await political_party.findMany({});

  return result;
};

const update = async (req) => {
  getOne(req);

  const result = await political_party.update({
    where: {
      id: req.params.id,
    },
    data: req.body,
  });

  return result;
};

const destroy = async (req) => {
  getOne(req);

  const result = await political_party.delete({ where: { id: req.params.id } });

  return result;
};

module.exports = { create, getOne, update, getAll, destroy };
