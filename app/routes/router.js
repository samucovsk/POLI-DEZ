var express = require("express");
var router = express.Router();

router.get("/login", function (req, res) {
    res.render("C:\Users\PMB\Downloads\POLI-DEZ\app\views\pages\login.html",{pagina:"login"});
});