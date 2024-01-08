const express = require("express");
const { body, validationResult } = require("express-validator");
const { getOrCreateConnection } = require("../../db");
const { authenticate, authenticateAllowAll } = require("../../middleware/auth");

const router = express.Router();

// get the db connection
const db = getOrCreateConnection();

// like a post by it's id
router.post("/:id/like", authenticateAllowAll, async (req, res) => {
  if (!req.user) {
    return res.status(401).json({
      success: false,
    });
  }

  const postId = req.params.id;

  db.get(`select * from posts where id = ${postId}`, function (error, row) {
    if (error || !row) {
      return res.status(500).json({
        message: error,
      });
    }

    db.serialize(function () {
      // find out if user already likes this post
      db.get(`select * from likes where user_id = ${req.user.id} and post_id = ${postId}`, function (error, row) {
        if (error || row) {
          return res.status(500).json({
            success: false,
            error,
          });
        }
      });

      // insert the like into the likes table
      db.run("insert into likes ('user_id', 'post_id') values (? , ?)", [req.user.id, postId], function (error) {
        if (error) {
          return res.status(500).json({
            success: false,
            error,
          });
        }

        return res.status(200).json({
          success: true,
        });
      });
    });
  });
});

// unlike a post by it's id
router.post("/:id/dislike", authenticateAllowAll, async (req, res) => {
  if (!req.user) {
    return res.status(401).json({
      success: false,
    });
  }

  const postId = req.params.id;

  db.get(`select * from posts where id = ${postId}`, function (error, row) {
    if (error || !row) {
      return res.redirect(`/${req.user?.role || "reader"}/article/${postId}`);
    }

    // delete the like from the likes table if it exists
    db.run(`delete from likes where user_id = ? and post_id = ?`, [req.user.id, postId], function (error) {
      if (error) {
        return res.status(500).json({
          success: false,
          error,
        });
      }

      return res.status(200).json({
        success: true,
      });
    });
  });
});

// insert new post
router.put(
  "/",
  authenticate,
  body("title").isString().isLength({
    min: 1,
  }),
  body("content").isString().isLength({
    min: 1,
  }),
  body("is_draft").isBoolean(),
  async (req, res) => {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
      return res.status(400).json({
        success: false,
        errors: errors.array(),
      });
    }

    const { title, subtitle, content, is_draft } = req.body;

    db.run(
      "insert into posts ('user_id','title','subtitle','content','is_draft') values (?, ?, ?, ?, ?)",
      [req.user.id, title, subtitle, content, !is_draft ? 1 : 0],
      function (error) {
        if (error) {
          return res.status(500).json({
            success: false,
            error: error,
          });
        }

        return res.status(200).json({
          success: true,
          id: this.lastID,
        });
      }
    );
  }
);

// update post details
router.patch(
  "/:id",
  authenticate,
  body("title").isString().isLength({
    min: 1,
  }),
  body("content").isString().isLength({
    min: 1,
  }),
  body("is_draft").isBoolean(),
  async (req, res) => {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
      return res.status(400).json({
        success: false,
        errors: errors.array(),
      });
    }

    const { title, subtitle, content, is_draft } = req.body;

    db.run(
      `update posts set
        title = ?,
        subtitle = ?,
        content = ?,
        is_draft = ?,
        updated_at = datetime(current_timestamp, 'localtime')
      where posts.id = ${req.params.id}`,
      [title, subtitle, content, !is_draft ? 1 : 0],
      function (error) {
        if (error) {
          console.log(error);
          return res.status(500).json({
            success: false,
            error: error,
          });
        }

        return res.status(200).json({
          success: true,
          id: req.params.id,
        });
      }
    );
  }
);

// delete post by id
router.delete("/:id", authenticate, async (req, res) => {
  if (!req.params.id) {
    return res.status(400).json({
      success: false,
      error: "no id found in params",
    });
  }

  // delete comments and likes from post
  // then delete the post
  db.exec(
    `
      delete from comments where post_id = ${req.params.id};
      delete from likes where post_id = ${req.params.id};
      delete from posts where posts.id = ${req.params.id};
    `,
    function (error) {
      if (error) {
        // return the errors to the client
        return res.status(500).json({
          success: false,
          error: error,
        });
      }

      // if successful return a success response
      return res.status(200).json({
        success: true,
      });
    }
  );
});

module.exports = router;
