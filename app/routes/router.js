const express = require('express');
const app = express();

router.get("/home", function (req, res) {
    res.render("pages/index.html");
});
router.get("/login", function (req, res) {
    res.render("pages/login.html");
});
router.get("/noticias", function (req, res) {
    res.render("pages/news.html");
});
router.get("/politicos", function (req, res) {
    res.render("pages/perfil-candidato.html");
});
module.exports = router;