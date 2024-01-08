const jwt = require("jsonwebtoken");
const express = require("express");

module.exports = {
  /**
   * @param {express.Request} req
   * @param {express.Response} res
   * @param {express.NextFunction} next
   */
  authenticate: (req, res, next) => {
    // get the token from the users cookies
    const token = req.cookies["token"];

    // if the token exists, try to verify
    if (token) {
      return jwt.verify(token, process.env.JWT_SECRET, function (error, decode) {
        //
        if (error) {
          req.user = undefined;
          return res.status(403).redirect("/");
        }

        req.user = decode;
        return next();
      });
    }

    return res.status(403).redirect("/");
  },

  /**
   * @param {express.Request} req
   * @param {express.Response} res
   * @param {express.NextFunction} next
   */
  authenticateAllowAll: (req, res, next) => {
    const token = req.cookies["token"];

    if (token) {
      return jwt.verify(token, process.env.JWT_SECRET, function (error, decode) {
        if (error) req.user = undefined;

        req.user = decode;
        next();
      });
    }

    next();
  },
};
