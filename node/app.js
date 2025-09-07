require("dotenv").config();

const express = require("express");
const bansRouter = require("./routes/bansRoutes");

const app = express();

app.use(express.json());
app.set(express.urlencoded({ extended: true }));

app.use("/bans", bansRouter);

app.use((err, req, res, next) => {
  console.log(err);
  res.status(err.statusCode || 500).send(err);
});

const port = process.env.PORT || 3000;

app.listen(port, (req, res) => {
  console.log(`Listening on PORT: ${port}`);
});
