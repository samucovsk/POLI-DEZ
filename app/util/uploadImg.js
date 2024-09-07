const { validationResult } = require("express-validator");
const multer = require("multer");
const path = require("path");

const createFileFilter = (extensoesPermitidas) => {
    return (req, file, cowboy) => {
        const extensoesRegex = new RegExp(extensoesPermitidas.join('|'));
        const extname = extensoesRegex.test(path.extname(file.originalname).toLowerCase());
        const mimetype = extensoesRegex.test(file.mimetype);

        if (extname && mimetype) {
            return cowboy(null, true);
        } else {
            return cowboy(new Error("Tipo de arquivo inválido"));
        }
    };
};

module.exports = (caminho = null, tamanhoArq = 3, extensoesPermitidas = ['jpeg', 'jpg', 'png']) => {
    return (campoArquivo) => {
        return (req, res, next) => {
            const fileFilter = createFileFilter(extensoesPermitidas);
            // Salvar em SGBD

            if (caminho == null) {
                const storage = multer.memoryStorage();
                upload = multer({
                    storage: storage,
                    limits: { fileSize: tamanhoArq * 1024 * 1024 },
                })
            } else {
                var storagePasta = multer.diskStorage({
                    destination: (req, file, cowboy) => {
                        cowboy(null, caminho)
                    },
                    filename: (req, file, cowboy) => {
                        cowboy(
                            null,
                            file.fieldname + "-" + Date.now() + path.extname(file.originalname)
                        )
                    }
                });
                // Upload
                upload = multer({
                    storage: storagePasta,
                    limits: { fileSize: tamanhoArq * 1024 * 1024 },
                    fileFilter: fileFilter
                });
            }


            req.session.erroMulter = null
            upload.single(campoArquivo)(req, res, function (err) {
                if (err instanceof multer.MulterError) {
                    req.session.erroMulter = {
                        value: '',
                        msg: err.message,
                        path: campoArquivo
                    }
                } else if (err) {
                    req.session.erroMulter = {
                        value: '',
                        msg: err.message,
                        path: campoArquivo
                    }
                }
                next();
            });

        }
    }
}