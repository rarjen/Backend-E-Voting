const { PrismaClient } = require("@prisma/client");
const { user } = new PrismaClient();
const ApiError = require("../../helpers/errorHandler");
const { getHash, checkHash } = require("../../helpers/passwordHash");
const Validator = require("fastest-validator");
const v = new Validator();
const jwt = require("jsonwebtoken");
const { JWT_SECRET_KEY } = process.env;

const register = async (req) => {
  const { nik, email, password } = req.body;

  const schemaNik = {
    nik: { type: "string", min: 16 },
  };

  const schemaEmail = {
    email: { type: "email", label: "Email Address" },
  };

  const schemaPassword = {
    password: { type: "string", min: 6 },
  };

  const checkEmail = await v.compile(schemaEmail);
  const checkPassword = await v.compile(schemaPassword);
  const checkNik = await v.compile(schemaNik);

  const validateEmail = checkEmail({
    email: `${email}`,
  });

  const validatePassword = checkPassword({
    password: `${password}`,
  });

  const validateNik = checkNik({
    nik: `${nik}`,
  });

  // Email Validation
  if (validateEmail.length > 0) {
    throw ApiError.badRequest("Email tidak valid");
  }

  // Password Validation
  if (validatePassword.length > 0) {
    throw ApiError.badRequest("Password minimal 6 karakter");
  }

  // Nik Validation
  if (validateNik.length > 0) {
    throw ApiError.badRequest("Nik minimal 16 karakter");
  }

  const userExist = await user.findFirst({
    where: {
      OR: [{ nik: nik }, { email: email }],
    },
  });

  if (userExist) {
    throw ApiError.badRequest("NIK or Email already exist!");
  }

  const passwordHashed = getHash(password);
  req.body.password = passwordHashed;
  req.body.isVoted = false;

  const result = await user.create({
    data: req.body,
  });

  const resultWithoutPassword = { ...result, password: undefined };

  return resultWithoutPassword;
};

const login = async (req) => {
  const { nik, email, password } = req.body;

  const schemaNik = {
    nik: { type: "string", min: 16 },
  };

  const schemaEmail = {
    email: { type: "email", label: "Email Address" },
  };

  const schemaPassword = {
    password: { type: "string", min: 6 },
  };

  const checkEmail = await v.compile(schemaEmail);
  const checkPassword = await v.compile(schemaPassword);
  const checkNik = await v.compile(schemaNik);

  const validateEmail = checkEmail({
    email: `${email}`,
  });

  const validatePassword = checkPassword({
    password: `${password}`,
  });

  const validateNik = checkNik({
    nik: `${nik}`,
  });

  // Email Validation
  if (validateEmail.length > 0) {
    throw ApiError.badRequest("Email tidak valid");
  }

  // Password Validation
  if (validatePassword.length > 0) {
    throw ApiError.badRequest("Password minimal 6 karakter");
  }

  // Nik Validation
  if (validateNik.length > 0) {
    throw ApiError.badRequest("Nik minimal 16 karakter");
  }

  const user = await user.findFirst({
    where: {
      OR: [{ email: email }, { nik: nik }],
    },
  });

  const match = checkHash(password, user.password);
  if (!match) {
    throw ApiError.badRequest("Email/NIK/password salah");
  }

  let payload = {
    id: user.id,
    name: user.name,
    email: user.email,
    nik: user.nik,
  };

  const token = jwt.sign(payload, JWT_SECRET_KEY);

  return { token };
};

const whoami = async (req) => {
  const user = req.user;

  const result = await user.findFirst({
    where: { nik: user.nik },
  });

  const resultWithoutPassword = { ...result, password: undefined };

  return resultWithoutPassword;
};

module.exports = { register, login, whoami };
