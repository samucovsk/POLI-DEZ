const { validationResult } = require("express-validator");
const usuario = require("../models/usuarioModel");
const bcrypt = require("bcryptjs");
const politico = require("../models/politicosModel");

const verificarUsuAutenticado = (req, res, next) => {
    if (req.session.autenticado) {
        var autenticado = req.session.autenticado;
    } else {
        var autenticado = { nome: null, id: null, tipo: null };
    }
    req.session.autenticado = autenticado;
    next();
}

const limparSessao = (req, res, next) => {
    req.session.destroy();
    next();
}

const gravarUsuAutenticado = async (req, res, next) => {
    const erros = validationResult(req); 
    var autenticado = { nome: null, id: null, data_nascimento: null };

    if (erros.isEmpty()) {
        let results;
        let total = 0;
        let isPolitico = req.body.tipo_politico ? true : false;        

        if (isPolitico) {
            results = await politico.findCampoCustom(req.body.email, "contatoPoliticos");
        } else {
            results = await usuario.findCampoCustom(req.body.email, "emailUsuario");
        }
        total = Object.keys(results).length;
        
        if (total == 1) {           
            if (isPolitico) {
                autenticado = {
                    nome: results[0].nomePoliticos,
                    id: results[0].idPoliticos,
                    data_nascimento: results[0].dataNascPoliticos,
                    tipo: "politico"
                };
            } else {
                autenticado = {
                    nome: results[0].nomeUsuario,
                    id: results[0].idUsuario,
                    data_nascimento: results[0].dataNascUsuario,
                    tipo: "usuario"
                };
            }
        }
    }
    req.session.autenticado = autenticado; 
    console.log(req.session.autenticado);
    
    next();
}

const verificarUsuAutorizado = (tipoPermitido, destinoFalha) => {
    return (req, res, next) => {
        if (req.session.autenticado.autenticado != null &&
            tipoPermitido.includes(req.session.autenticado.tipo)) { 
            next();
        } else {
            res.render(destinoFalha, req.session.autenticado);
        }
    };
}

module.exports.autenticador = {
    verificarUsuAutenticado,
    limparSessao,
    gravarUsuAutenticado,
    verificarUsuAutorizado
}