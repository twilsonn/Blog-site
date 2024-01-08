const express = require("express");
const { getOrCreateConnection } = require("../db");
const jwt = require("jsonwebtoken");

const db = getOrCreateConnection();

module.exports = {
  /**
   * @param {express.Request} req
   * @param {express.Response} res
   * @param {express.NextFunction} next
   */
  signup: (req, res) => {
    const { name, username, password, role } = req.body;

    db.run(
      "INSERT INTO users ('name', 'username', 'password', 'role') VALUES( ?, ?, ?, ? );",
      [name, username, password, role],
      function (err) {
        if (err) {
          res.redirect("/");
        } else {
          res.redirect(`/`);
        }
      }
    );
  },

  /**
   * @param {express.Request} req
   * @param {express.Response} res
   * @param {express.NextFunction} next
   */
  signin: (req, res) => {
    const { username, password } = req.body;

    db.get(`select * from users where username = '${username}'`, function (err, row) {
      if (err) {
        return res.redirect("/");
      }

      const passowrdValid = password === row.password;

      if (!passowrdValid) {
        return res.status(401).send({
          message: "invalid password",
        });
      }

      const token = jwt.sign({ ...row }, process.env.JWT_SECRET, {
        expiresIn: 60 * 60 * 24 * 7,
      });

      res
        .status(200)
        .cookie("token", token, { maxAge: 86400 * 1000, httpOnly: true })
        .redirect(`/${row.role}`);
    });
  },
};
