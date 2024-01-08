const express = require("express");
const { getOrCreateConnection } = require("../db");
const { authenticate, authenticateAllowAll } = require("../middleware/auth");
const dayjs = require("dayjs");

var calendar = require("dayjs/plugin/calendar");

dayjs.extend(calendar);

const router = express.Router();

const db = getOrCreateConnection();

// display the reader article view
router.get("/reader/article/:id", authenticateAllowAll, async (req, res, next) => {
  const articleId = req.params.id;

  // select the article in the database where the article isn't a draft
  db.get(
    `select
        posts.id as id,
        users.name as 'author',
        users.username as 'author_username',
        title,
        subtitle,
        content,
        count(likes.id) as 'likes',
        max(case
          when likes.user_id = ${req.user?.id || "'null'"} then 1
          else 0
        end) as liked_by_user,
        created_at,
        updated_at
      from posts
      left join users on posts.user_id = users.id
      left join likes on likes.post_id = posts.id
      where posts.id = ${articleId}
      group by 1,2,3,4,5,6,9,10
      order by posts.updated_at desc`,
    function (error, post) {
      if (error) {
        next(error);
      }

      // redirect if the post doesnt exist
      if (!post) {
        return res.redirect("/reader");
      }

      // render the reader-article template
      return res.render("reader-article", {
        user: req.user,
        title: "Home",
        article: {
          ...post,
          content: post?.content?.replaceAll("@@", "\n"),
          created_at: dayjs(post?.created_at).calendar(),
          updated_at: dayjs(post?.updated_at).calendar(),
        },
        user: req.user,
        navigation: [
          {
            label: "Home",
            href: "/reader",
            active: false,
          },
        ],
      });
    }
  );
});

// display the author article view
router.get("/author/article/:id", authenticate, async (req, res, next) => {
  const articleId = req.params.id;

  // redirect to the reader article if the user has a role of "reader"
  if (req.user.role === "reader") {
    return res.redirect(`/reader/article/${articleId}`);
  }

  // select the article in the database
  db.get(
    `select
      posts.id as id,
      users.name as 'author',
      users.username as 'author_username',
      title,
      subtitle,
      content,
      count(likes.id) as 'likes',
      max(case
        when likes.user_id = ${req.user?.id || "'null'"} then 1
        else 0
      end) as liked_by_user,
      created_at,
      updated_at
    from posts
    left join users on posts.user_id = users.id
    left join likes on likes.post_id = posts.id
    where posts.id = ${articleId}
    group by 1,2,3,4,5,6,9,10
    order by posts.updated_at desc`,
    function (error, post) {
      if (error) {
        next(error);
      }

      // redirect if the post doesnt exist
      if (!post) {
        return res.redirect("/author");
      }

      // render the author-article template
      return res.render("author-article", {
        user: req.user,
        title: "Home",
        article: {
          ...post,
          content: post?.content?.replaceAll("@@", "\n"),
          created_at: dayjs(post?.created_at).calendar(),
          updated_at: dayjs(post?.updated_at).calendar(),
        },
        user: req.user,
        navigation: [
          {
            label: "Home",
            href: "/author",
            active: false,
          },
        ],
      });
    }
  );
});

// create a new article
router.get("/author/new", authenticate, async (req, res, next) => {
  return res.render("author-create", {
    title: "Home",
    user: req.user,
    navigation: [
      {
        label: "Home",
        href: "/reader",
        active: false,
      },
      {
        label: "Settings",
        href: "/reader",
        active: false,
      },
    ],
  });
});

// edit an existing article
router.get("/author/edit/:id", authenticate, async (req, res, next) => {
  db.get(`select * from posts where posts.id = ${req.params.id}`, function (error, post) {
    if (error) {
      return next(error);
    }

    if (!post) {
      return res.redirect("/author");
    }

    return res.render("author-edit", {
      title: "Home",
      user: req.user,
      post,
      navigation: [
        {
          label: "Home",
          href: "/reader",
          active: false,
        },
        {
          label: "Settings",
          href: "/reader",
          active: false,
        },
      ],
    });
  });
});

module.exports = router;
