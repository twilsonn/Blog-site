const express = require("express");
const dayjs = require("dayjs");
const { getOrCreateConnection } = require("../db");
const { authenticate, authenticateAllowAll } = require("../middleware/auth");

const router = express.Router();

const db = getOrCreateConnection();

// display the home page for readers
router.get("/reader", authenticateAllowAll, async (req, res, next) => {
  // select all the published articles
  db.all(
    `select
      posts.id as id,
      users.name as 'author',
      title,
      subtitle,
      content,
      count(likes.id) as 'likes',
      max(case
        when likes.user_id = ${req?.user?.id || "'null'"} then 1
        else 0
      end) as liked_by_user,
      created_at,
      updated_at
    from posts
    left join users on posts.user_id = users.id
    left join likes on likes.post_id = posts.id
    where posts.is_draft = 0
    group by 1,2,3,4,5,8,9
    order by posts.updated_at desc`,
    function (error, rows) {
      if (error) {
        next(error);
      }

      return res.render("reader-home", {
        user: req.user,
        title: "Home",
        articles: rows.map((article) => ({
          ...article,
          created_at: dayjs(article.created_at).format("DD-MM-YYYY"),
          updated_at: dayjs(article.updated_at).format("DD-MM-YYYY"),
        })),
        navigation: [
          {
            label: "Home",
            href: "#",
            active: true,
          },
        ],
      });
    }
  );
});

// display the home page for authors
router.get("/author", authenticate, async (req, res, next) => {
  // redirect if the role has reader permissions
  if (req.user.role === "reader") {
    return res.redirect("/reader");
  }

  // select all the articles
  db.all(
    `select
        posts.id as id,
        users.name as 'author',
        title,
        subtitle,
        content,
        count(likes.id) as 'likes',
        max(case
            when likes.user_id = ${req?.user?.id || "'null'"} then 1
            else 0
        end) as liked_by_user,
        created_at,
        updated_at,
        is_draft
      from posts
      left join users on posts.user_id = users.id
      left join likes on likes.post_id = posts.id
      group by 1,2,3,4,5,8,9
      order by posts.updated_at desc`,
    function (error, articles) {
      if (error) {
        next(error);
      }

      return res.render("author-home", {
        user: req.user,
        title: "Home",
        articles: articles.map((article) => ({
          ...article,
          created_at: dayjs(article.created_at).format("DD-MM-YYYY"),
          updated_at: dayjs(article.updated_at).format("DD-MM-YYYY"),
        })),
        navigation: [
          {
            label: "Home",
            href: "#",
            active: true,
          },
        ],
      });
    }
  );
});

module.exports = router;
