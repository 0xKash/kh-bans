const { CustomBadRequestError } = require("../errors/errors");

exports.checkIdentifiers = (req) => {
  const { steam, discord, license, license2, xbl, fivem, ip, hardware } =
    req.body;

  if (
    !steam &&
    !discord &&
    !license &&
    !license2 &&
    !xbl &&
    !fivem &&
    !ip &&
    !hardware
  )
    throw new CustomBadRequestError(
      "At least one identifier must be provided",
      { identifiers: req.body },
      "Provide at least one valid identifier such as steam, discord, license, ip, etc.",
      req.originalUrl
    );
};
