const { Router } = require("express");
const {
  createBan,
  getBanById,
  getBanByIdentifier,
  deleteBan,
} = require("../controllers/banController");

const bansRouter = Router();

bansRouter.post("/", createBan);

bansRouter.get("/id/:banId", getBanById);
bansRouter.delete("/id/:banId", deleteBan);

bansRouter.post("/identifiers", getBanByIdentifier);

module.exports = bansRouter;
