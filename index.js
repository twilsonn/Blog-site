const path = require("path");
const express = require("express");
const partials = require("express-partials");
const { getOrCreateConnection } = require("./db");
const cookieParser = require("cookie-parser");
const app = express();
const port = 3000;

require("dotenv").config();

app.use(express.json());

app.use(
  express.urlencoded({
    extended: true,
  })
);

app.use(cookieParser());

getOrCreateConnection();

const homeRoutes = require("./routes/home");
const articleRoutes = require("./routes/article");
const loginSignupRoutes = require("./routes/login-signup");
const ApiRoutes = require("./routes/api/index");

// run live reload if the app is in development mode
if (process.env.NODE_ENV === "development") {
  // =======================================
  var livereload = require("livereload");
  var connectLiveReload = require("connect-livereload");

  const liveReloadServer = livereload.createServer();

  liveReloadServer.server.once("connection", () => {
    setTimeout(() => {
      liveReloadServer.refresh("/");
    }, 100);
  });

  app.use(connectLiveReload());
  // =======================================
}

// load the express-partials middleware
app.use(partials());

app.use(express.static(path.join(__dirname, "public")));

//set the app to use ejs for rendering
app.set("view engine", "ejs");

//this adds all the userRoutes to the app under the path /user
app.use("/", homeRoutes);
app.use("/", articleRoutes);
app.use("/", loginSignupRoutes);
app.use("/api", ApiRoutes);

app.listen(port, () => {
  console.log(`server started on port ${port} 🚀 http://localhost:${port}`);
});
