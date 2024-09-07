const express = require("express");
const router = express.Router();
const pool = require('../../config/pool-conexoes');

const usuarioController = require("../controllers/usuarioController");
const politicoController = require("../controllers/politicosController");
const { autenticador } = require("../sessions/autenticador_middleware");
const { mensagemErro } = require("../util/logs");

const upload = require("../util/uploadImg");
const uploadPerfil = upload("./app/public/imagem/imagens-servidor/perfil/", 3, ['jpeg', 'jpg', 'png'],);

/* ====================== Rotas GET ====================== */

router.get('/logOut', autenticador.limparSessao, function (req, res) {
    res.redirect('/');
});

router.get("/", autenticador.verificarUsuAutenticado, function (req, res) {
    res.render("pages/index", { pagina: "home", logado: req.session.autenticado });
});

router.get("/home", autenticador.verificarUsuAutenticado,function (req, res) {
    res.render("pages/index", { pagina: "home", logado: req.session.autenticado });
});

router.get("/escolha", function (req, res) {
    res.render("pages/escolha", { pagina: "escolha", logado: req.session.autenticado });
});
router.get("/noticias", function (req, res) {
    res.render("pages/news", { pagina: "noticias", logado: req.session.autenticado });
});
router.get("/login_usuario", function (req, res) {
    res.render("pages/login", { 
        pagina: "login", 
        erros: null, 
        form_aprovado: false, 
        cadastro_aprovado: true,
        logado: req.session.autenticado,
        dadosForm: {
            email: "",
            senha: ""
        }
    });
});
router.get("/politicos", function (req, res) {
    res.render("pages/PARTIDOS", { pagina: "politicos", logado: req.session.autenticado });
});
router.get("/politicocadastro", function (req, res) {
    res.render(
        "pages/cadastro-politico", 
        { 
            pagina: "politicocadastro", 
            logado: req.session.autenticado, 
            form_aprovado: false,
            erros: null, 
            dadosForm: { 
                nome: "", 
                email: "", 
                data_nascimento: "",
                cpf: "", 
                Estado: "", 
                senha: "", 
                confirmarSenha: "" 
            }
        }
    );
});

router.get("/usuario", function (req, res) {
    res.render(
        "pages/cadastro-usuario", 
        { 
            pagina: "usuario", 
            logado: req.session.autenticado, 
            form_aprovado: false,
            erros: null, 
            dadosForm: { 
                nome: "", 
                email: "", 
                data_nascimento: "", 
                Estado: "", 
                senha: "", 
                confirmarSenha: "" 
            }
        }
    );
});

router.get('/signin', function (req, res) {
    res.render('pages/login',
        { 
            pagina: "login", 
            logado: req.session.autenticado, 
            form_aprovado: false,
            erros: null, 
            dadosForm: { 
                email: "", 
                senha: "", 
            }
        }
    )
});

router.get(
    '/perfil-eleitor', 
    autenticador.verificarUsuAutenticado, 
    autenticador.verificarUsuAutorizado('eleitor', 'pages/login', { pagina: "login", logado: null, dadosForm: { email: '', senha: '' }, form_aprovado: false, erros: null }), 
    function (req, res) {
        console.log(req.session.autenticado);
        res.render('pages/perfil-eleitor', { pagina: "perfil-eleitor", logado: req.session.autenticado });
    }
);

router.get(
    '/perfil-candidato', 
    autenticador.verificarUsuAutenticado, 
    autenticador.verificarUsuAutorizado('candidato', 'pages/login', { pagina: "login", logado: null, dadosForm: { email: '', senha: '' }, form_aprovado: false, erros: null }), 
    function (req, res) {
        console.log(req.session.autenticado);
        res.render('pages/perfil-candidato', { pagina: "perfil-candidato", logado: req.session.autenticado });
    }
);

router.get(
    '/editar_eleitor', 
    autenticador.verificarUsuAutenticado, 
    autenticador.verificarUsuAutorizado('eleitor', 'pages/login', { pagina: "login", logado: null, dadosForm: { email: '', senha: '' }, form_aprovado: false, erros: null }), 
    function (req, res) {
        console.log(req.session.autenticado);
        res.render(
            'pages/editar-eleitor', 
            { 
                logado: req.session.autenticado,
                dadosForm: req.session.autenticado,
                erros: null
            }
        );
    }
);

/* ====================== Rotas POST ====================== */

router.post("/cadastro", usuarioController.regrasValidacaoFormCad, function (req, res){
    usuarioController.cadastrarUsuario(req, res);
    console.log(req.session.autenticado);
    
});

router.post("/cadastro-politico", politicoController.regrasValidacaoFormCad, function (req, res) {
    politicoController.cadastrarPolitico(req, res);
});

router.post('/signin', usuarioController.regrasValidacaoFormLogin, autenticador.gravarUsuAutenticado, function (req, res) {
    console.log(req.session.autenticado);
    
    usuarioController.signInEleitor(req, res);
});

// Atualizar dados de usuário

router.post(
    '/update_eleitor',
    autenticador.verificarUsuAutenticado, 
    autenticador.verificarUsuAutorizado('eleitor', 'pages/login', { pagina: "login", logado: null, dadosForm: { email: '', senha: '' }, form_aprovado: false, erros: null }), 
    uploadPerfil("imgPerfil"),
    usuarioController.regrasValidacaoFormAttPerfil,
    function (req, res) {
        usuarioController.atualizarConta(req, res);
    }
);

//banco de dados//
router.get('/tabelas', async (req, res) => {
    try {
        const [results, fields] = await pool.query('SHOW TABLES');
        res.json(results);
    } catch (error) {
        console.error('Erro ao listar as tabelas:', error);
        res.status(500).send('Erro ao listar as tabelas');
    }
});

// Apenas teste (pode apagar dps)
router.get('/pegar_usuario', async (req, res) => {
    try {
        const [results, fields] = await pool.query('SELECT * FROM Usuario WHERE idUsuario = 53');
        res.json(results);
        console.log(results);
        
    } catch (error) {
        console.error('Erro ao listar as tabelas:', error);
        res.status(500).send('Erro ao listar as tabelas');
    }
})

module.exports = router;