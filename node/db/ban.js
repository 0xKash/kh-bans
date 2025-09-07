const { PrismaClient, Prisma } = require("@prisma/client");

const prisma = new PrismaClient();

exports.createBan = async (reason, expiresAt, identifiers = {}) => {
  try {
    return await prisma.ban.create({
      data: {
        reason,
        expiresAt,
        ...identifiers,
      },
    });
  } catch (err) {
    console.error("Error creating ban: ", err);
    throw err;
  }
};

exports.getBanByid = async (id) => {
  try {
    return await prisma.ban.findUnique({
      where: {
        id,
      },
    });
  } catch (err) {
    console.error("Error getting ban byt id: ", err);
    throw err;
  }
};

exports.getBanByIdentifier = async (identifiers = {}) => {
  const orArray = Object.entries(identifiers).map(([key, value]) => ({
    [key]: value,
  }));

  if (orArray.length === 0) return null;

  try {
    return await prisma.ban.findFirst({
      where: {
        OR: orArray,
      },
    });
  } catch (err) {
    console.error("Error getting ban by identifier: ", err);
    throw err;
  }
};

exports.deleteBan = async (id) => {
  try {
    return await prisma.ban.delete({
      where: {
        id,
      },
    });
  } catch (err) {
    console.error("Error deleting ban: ", err);
    throw err;
  }
};
