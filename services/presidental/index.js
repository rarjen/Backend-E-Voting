const { PrismaClient } = require("@prisma/client");
const ApiError = require("../../helpers/errorHandler");
const { presidental_candidate, political_party } = new PrismaClient();

const create = async (req) => {
  const partyExist = await political_party.findFirst({
    where: { id: req.body.political_party_id },
  });

  if (!partyExist) {
    throw ApiError.notFound("Data tidak ada!");
  }

  const result = await presidental_candidate.create({ data: req.body });

  return result;
};

const getOne = async (req) => {
  const result = await presidental_candidate.findFirst({
    where: { id: req.params.id },
    include: { political_party: true },
  });

  if (!result) {
    throw ApiError.notFound("Data tidak ada!");
  }

  return result;
};

const getAll = async (req) => {
  const result = await presidental_candidate.findMany({
    include: { political_party: true },
  });

  return result;
};

const update = async (req) => {
  await getOne(req);

  const result = await presidental_candidate.update({
    where: {
      id: req.params.id,
    },
    data: req.body,
  });

  return result;
};

const destroy = async (req) => {
  await getOne(req);

  const result = await presidental_candidate.delete({
    where: { id: req.params.id },
  });

  return result;
};

module.exports = { create, getOne, update, getAll, destroy };
