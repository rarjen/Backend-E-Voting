const { PrismaClient } = require("@prisma/client");
const ApiError = require("../../helpers/errorHandler");
const {
  presidental_candidate,
  vice_presidental_candidate,
  candidate_pair_number,
} = new PrismaClient();

const create = async (req) => {
  const presidentalExist = await presidental_candidate.findFirst({
    where: { id: req.body.presidental_candidate_id },
  });

  if (!presidentalExist) {
    throw ApiError.notFound("Data presiden tidak ada!");
  }

  const vicePresidentalExist = await vice_presidental_candidate.findFirst({
    where: { id: req.body.vice_presidental_candidate_id },
  });

  if (!vicePresidentalExist) {
    throw ApiError.notFound("Data vice presiden tidak ada!");
  }

  const result = await candidate_pair_number.create({ data: req.body });

  return result;
};

const getOne = async (req) => {
  const result = await candidate_pair_number.findFirst({
    where: { id: req.params.id },
    include: { presidental_candidate: true, vice_presidental_candidate: true },
  });

  if (!result) {
    throw ApiError.notFound("Data tidak ada!");
  }

  return result;
};

const getAll = async (req) => {
  const result = await candidate_pair_number.findMany({
    include: { presidental_candidate: true, vice_presidental_candidate: true },
  });

  return result;
};

const update = async (req) => {
  await getOne(req);

  const checkPresidentalExist = await presidental_candidate.findFirst({
    where: { id: req.body.presidental_candidate_id },
  });

  if (!checkPresidentalExist) {
    throw ApiError.notFound("Presidental not found!");
  }

  const checkVicePresidentalExist = await presidental_candidate.findFirst({
    where: { id: req.body.presidental_candidate_id },
  });

  if (!checkVicePresidentalExist) {
    throw ApiError.notFound("Vice presidental not found!");
  }

  const result = await candidate_pair_number.update({
    where: {
      id: req.params.id,
    },
    data: req.body,
  });

  return result;
};

const destroy = async (req) => {
  await getOne(req);

  const result = await candidate_pair_number.delete({
    where: { id: req.params.id },
  });

  return result;
};

module.exports = { create, getOne, update, getAll, destroy };
