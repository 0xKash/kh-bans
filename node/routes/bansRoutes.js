const { Router } = require("express");

const bansRouter = Router();

bansRouter.get("/", (req, res) => res.send("ok"));

module.exports = bansRouter;
