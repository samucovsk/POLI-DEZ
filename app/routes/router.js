var express = require("express");
var router = express.Router();

router.get("/", function (req, res) {
    res.render("app\views\pages\login.html",{pagina:"login"});
});