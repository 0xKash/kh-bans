const prisma = require("../db/ban");
const {
  CustomBadRequestError,
  CustomNotFoundError,
} = require("../errors/errors");
const { checkBanExpiration } = require("../utils/checkBanExpiration");
const { checkIdentifiers } = require("../utils/checkIdentifiers");

exports.createBan = async (req, res) => {
  checkIdentifiers(req);

  const {
    steam,
    discord,
    license,
    license2,
    xbl,
    fivem,
    ip,
    hardware,
    reason,
    expiresAt,
  } = req.body;

  const identifiers = {
    steam,
    discord,
    license,
    license2,
    xbl,
    fivem,
    ip,
    hardware,
  };

  const ban = await prisma.createBan(reason, expiresAt, identifiers);
  return res.status(201).json(ban);
};

exports.getBanById = async (req, res) => {
  const { banId } = req.params;

  if (!banId)
    throw new CustomBadRequestError(
      "Ban ID is required",
      { id: req.params.id || null },
      "Provide a valid ban ID in the request params",
      req.originalUrl
    );

  const ban = await prisma.getBanByid(banId);

  if (!ban)
    throw new CustomNotFoundError(
      "Ban not found",
      { id: req.params.id || null },
      "Ensure the provided ban ID exists in the database",
      req.originalUrl
    );

  if (!checkBanExpiration(ban)) prisma.deleteBan(ban.id);

  return res.json({ ...ban, isExpired: false });
};

exports.deleteBan = async (req, res) => {
  const { banId } = req.params;

  if (!banId)
    throw new CustomBadRequestError(
      "Ban ID is required",
      { id: req.body.id },
      "Provide a valid ban ID in the request params",
      req.originalUrl
    );

  const ban = await prisma.deleteBan(banId);

  if (!ban)
    throw new CustomNotFoundError(
      "Ban not found",
      { ban },
      "Ensure the provided ban ID exists in the database",
      req.originalUrl
    );

  return res.json(ban);
};

exports.deleteBanByLicense = async (req, res) => {
  const { license } = req.params;

  if (!license)
    throw new CustomBadRequestError(
      "License is required",
      { id: req.body.license },
      "Provide a valid license in the request params",
      req.originalUrl
    );

  const ban = await prisma.deleteBanByLicense(license);

  if (!ban)
    throw new CustomNotFoundError(
      "Ban not found",
      { ban },
      "Ensure the provided ban ID exists in the database",
      req.originalUrl
    );

  return res.json(ban);
};

exports.getBanByIdentifier = async (req, res) => {
  checkIdentifiers(req);

  const { steam, discord, license, license2, xbl, fivem, ip, hardware } =
    req.body;

  const identifiers = {
    steam,
    discord,
    license,
    license2,
    xbl,
    fivem,
    ip,
    hardware,
  };

  const ban = await prisma.getBanByIdentifier(identifiers);

  if (!ban)
    throw new CustomNotFoundError(
      "Ban not found",
      { identifiers },
      "Ensure the provided ban identifiers exists in the database",
      req.originalUrl
    );

  if (!checkBanExpiration(ban)) {
    await prisma.deleteBan(ban.id);
    return res.json({ ...ban, isExpired: true });
  }

  return res.json({ ...ban, isExpired: false });
};
