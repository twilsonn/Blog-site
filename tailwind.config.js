/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./views/*"],
  theme: {
    extend: {},
  },
  plugins: [require("@tailwindcss/forms"), require("@tailwindcss/typography")],
};
