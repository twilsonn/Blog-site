const express = require("express");
const postsRouter = require("./posts");
const commentsRouter = require("./comments");

const router = express.Router();

// initialize routes on the api router
router.use("/posts", postsRouter);
router.use("/comments", commentsRouter);

module.exports = router;
