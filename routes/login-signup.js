const express = require("express");
const { signin, signup } = require("../controllers/auth.controller");

const router = express.Router();

router.get("/", async (req, res) => {
  const isSignUp = !!req.query.signup;

  // render the login/sign up page and pass the isSignUp parameter to determine if the template should display the login form or Sign Up form
  res.render("login-signup", {
    title: isSignUp ? "Sign Up" : " Login",
    layout: false,
    isSignUp,
  });
});

// Sign in and Sign up route's use the auth controller to fulfil the actions
router.post("/login", signin);
router.post("/signup", signup);

// Sign out will clear the JWT token and redirect to the reader home page
router.get("/signout", async (req, res) => {
  res.clearCookie("token").redirect("/reader");
});

module.exports = router;
