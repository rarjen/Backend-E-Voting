const { PrismaClient } = require("@prisma/client");
const ApiError = require("../../helpers/errorHandler");
const { supporting_party, political_party, candidate_pair_number } =
  new PrismaClient();

const checkPartyId = async (parties) => {
  for (const dataParty of parties) {
    const partyExist = await political_party.findFirst({
      where: {
        id: dataParty,
      },
    });

    if (!partyExist) {
      throw ApiError.notFound("Data partai tidak ditemukan!");
    }
  }
};

const create = async (req) => {
  const { candidateNumber, partiesId } = req.body;
  let finalResult = [];

  await checkPartyId(partiesId);
  const checkCandidateNumber = await candidate_pair_number.findFirst({
    where: { id: candidateNumber },
  });

  if (!checkCandidateNumber) {
    throw ApiError.notFound("Data nomor kandidat tidak ditemukan!");
  }

  for (const dataPartyId of partiesId) {
    const result = await supporting_party.create({
      data: {
        candidate_pair_number_id: candidateNumber,
        political_party_id: dataPartyId,
      },
    });
    finalResult.push(result);
  }

  return finalResult;
};

const getOne = async (req) => {
  const result = await supporting_party.findFirst({
    where: { id: req.params.id },
    include: { political_party: true, candidate_pair_number: true },
  });

  if (!result) {
    throw ApiError.notFound("Data tidak ada!");
  }

  return result;
};

const getAll = async (req) => {
  let whereQuery = {};

  if (req.query.candidate_pair_number_id) {
    whereQuery = {
      candidate_pair_number_id: req.query.candidate_pair_number_id,
    };
  }

  if (req.query.political_party_id) {
    whereQuery = {
      political_party_id: req.query.political_party_id,
    };
  }

  const result = await supporting_party.findMany({
    where: whereQuery,
    include: { political_party: true, candidate_pair_number: true },
  });

  return result;
};

const update = async (req) => {
  const { candidateNumber, partiesId } = req.body;
  await getOne(req);

  const checkCandidateNumber = await candidate_pair_number.findFirst({
    where: { id: candidateNumber },
  });

  if (!checkCandidateNumber) {
    throw ApiError.notFound("Data nomor kandidat tidak ditemukan!");
  }

  const checkParty = await political_party.findFirst({
    where: { id: partiesId },
  });

  if (!checkParty) {
    throw ApiError.notFound("Data partai politik tidak ditemukan!");
  }

  const result = await supporting_party({
    data: {
      candidate_pair_number: candidateNumber,
      political_party_id: partiesId,
    },
    where: {
      id: req.params.id,
    },
  });

  return result;
};

const destroy = async (req) => {
  await getOne(req);

  const result = await supporting_party.delete({
    where: { id: req.params.id },
  });

  return result;
};

module.exports = { create, getOne, update, getAll, destroy };
