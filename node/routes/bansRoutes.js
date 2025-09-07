const { Router } = require("express");
const {
  createBan,
  getBanById,
  getBanByIdentifier,
} = require("../controllers/banController");

const bansRouter = Router();

bansRouter.post("/", createBan);

bansRouter.get("/id/:banId", getBanById);

bansRouter.post("/identifiers", getBanByIdentifier);

module.exports = bansRouter;
