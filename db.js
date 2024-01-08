const { Database } = require("sqlite3");
const sqlite3 = require("sqlite3").verbose();

/** @type Database */
let connection;

module.exports = {
  /**
   * Returns a connection to the database. Create's a connection if one doesn't exist
   * @returns {Database}
   */
  getOrCreateConnection: function () {
    if (connection) return connection;

    connection = new sqlite3.Database("./database.db", function (err) {
      if (err) {
        console.error(err);
        process.exit(1); //Bail out we can't connect to the DB
      } else {
        connection.run("PRAGMA foreign_keys=ON"); //This tells SQLite to pay attention to foreign key constraints
      }
    });

    return connection;
  },
};
