const { PrismaClient } = require("@prisma/client");
const ApiError = require("../../helpers/errorHandler");
const { presidental_candidate, political_party, vice_presidental_candidate } =
  new PrismaClient();

const create = async (req) => {
  const partyExist = await political_party.findFirst({
    where: { id: req.body.political_party_id },
  });

  if (!partyExist) {
    throw ApiError.notFound("Data partai tidak ada!");
  }

  const presidentalExist = await presidental_candidate.findFirst({
    where: { id: req.body.presidental_partner_id },
  });

  if (!presidentalExist) {
    throw ApiError.notFound("Data presiden tidak ada!");
  }

  const result = await vice_presidental_candidate.create({ data: req.body });

  return result;
};

const getOne = async (req) => {
  const result = await vice_presidental_candidate.findFirst({
    where: { id: req.params.id },
    include: { political_party: true, presidental_partner: true },
  });

  if (!result) {
    throw ApiError.notFound("Data tidak ada!");
  }

  return result;
};

const getAll = async (req) => {
  const result = await vice_presidental_candidate.findMany({
    include: { political_party: true, presidental_partner: true },
  });

  return result;
};

const update = async (req) => {
  await getOne(req);

  const result = await vice_presidental_candidate.update({
    where: {
      id: req.params.id,
    },
    data: req.body,
  });

  return result;
};

const destroy = async (req) => {
  await getOne(req);

  const result = await vice_presidental_candidate.delete({
    where: { id: req.params.id },
  });

  return result;
};

module.exports = { create, getOne, update, getAll, destroy };
