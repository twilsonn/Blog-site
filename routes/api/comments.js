const express = require("express");
const dayjs = require("dayjs");
var calendar = require("dayjs/plugin/calendar");
const { authenticateAllowAll } = require("../../middleware/auth");
const { getOrCreateConnection } = require("../../db");

dayjs.extend(calendar);

const router = express.Router();

const db = getOrCreateConnection();

router.get("/:postId", async (req, res) => {
  // get all the comments for a post by it's id
  return db.all(
    `select
      comments.id as 'id',
      content,
      users.name,
      users.username,
      users.role,
      created_at  
    from comments 
    left join users on users.id = comments.user_id
    where comments.post_id = ${req.params.postId}
    order by created_at desc`,
    function (error, comments) {
      if (error) {
        return res.status(500).json({
          success: false,
          error,
        });
      }

      return res.status(200).json({
        success: true,
        comments: comments.map((comment) => ({
          ...comment,
          created_at: dayjs(comment.created_at).calendar(),
        })),
      });
    }
  );
});

router.post("/:postId", authenticateAllowAll, async (req, res) => {
  // throw an error if the user is not logged in
  if (!req.user) {
    return res.status(500).json({
      success: false,
      message: "user is not logged in",
    });
  }

  return db.serialize(function () {
    // check if the post exists
    db.get(`select id from posts where id = ${req.params.postId}`, function (error, row) {
      if (error || !row) {
        return res.status(500).json({
          success: false,
          message: error,
        });
      }
    });

    // insert comment in database
    db.run(
      "insert into comments ('content', 'user_id', 'post_id') values (? , ?, ?)",
      [req.body.content, req.user.id, req.params.postId],
      function (error) {
        if (error) {
          return res.status(500).json({
            success: false,
            error,
          });
        }
      }
    );

    // return all the comments along with the updated comment
    db.all(
      `select
        comments.id as 'id',
        content,
        users.name,
        users.username,
        users.role,
        created_at  
      from comments 
      left join users on users.id = comments.user_id
      where comments.post_id = ${req.params.postId}
      order by created_at desc`,
      function (error, comments) {
        if (error) {
          return res.status(500).json({
            success: false,
            error,
          });
        }

        return res.status(200).json({
          success: true,
          comments: comments.map((comment) => ({
            ...comment,
            created_at: dayjs(comment.created_at).calendar(),
          })),
        });
      }
    );
  });
});

router.delete("/:postId", authenticateAllowAll, async (req, res) => {
  // throw a bad request error if a comment id is not supplied in the request
  if (!req.query.id) {
    return res.status(400).json({
      success: false,
      message: "no comment id found",
    });
  }

  // throw an error if the user is not logged in
  if (!req.user) {
    return res.status(500).json({
      success: false,
      message: "user is not logged in",
    });
  }

  return db.serialize(function () {
    // check if comment belongs to the current user
    db.get(`select id, user_id from comments where id = ${req.query.id}`, function (error, row) {
      if (error || !row) {
        return res.status(500).json({
          success: false,
          message: error,
        });
      }

      if (row.user_id !== req.user.id) {
        return res.status(500).json({
          success: false,
          message: "You can only delete your own comments",
        });
      }
    });

    // delete the comment from the database
    db.get(`delete from comments where id = ${req.query.id}`, function (error) {
      if (error) {
        console.log(error);
        return res.status(500).json({
          success: false,
          message: error,
        });
      }
    });

    // return all the comments
    db.all(
      `select
        comments.id as 'id',
        content,
        users.name,
        users.username,
        users.role,
        created_at  
      from comments 
      left join users on users.id = comments.user_id
      where comments.post_id = ${req.params.postId}
      order by created_at desc`,
      function (error, comments) {
        if (error) {
          return res.status(500).json({
            success: false,
            error,
          });
        }

        return res.status(200).json({
          success: true,
          comments: comments.map((comment) => ({
            ...comment,
            created_at: dayjs(comment.created_at).calendar(),
          })),
        });
      }
    );
  });
});

module.exports = router;
