exports.checkBanExpiration = (ban) =>
  !(ban.expiresAt && ban.expiresAt <= new Date());
