-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema polidez
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `polidez` ;

-- -----------------------------------------------------
-- Schema polidez
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `polidez` DEFAULT CHARACTER SET utf8mb3 ;
USE `polidez` ;

-- -----------------------------------------------------
-- Table `polidez`.`Politicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `polidez`.`Politicos` (
  `idPoliticos` INT NOT NULL,
  `nomePoliticos` VARCHAR(45) NULL DEFAULT NULL,
  `perfilPoliticos` VARCHAR(45) NULL DEFAULT NULL,
  `senhaPoliticos` VARCHAR(45) NULL DEFAULT NULL,
  `cidadePoliticos` VARCHAR(45) NULL DEFAULT NULL,
  `ufPoliticos` VARCHAR(45) NULL DEFAULT NULL,
  `dataNascPoliticos` VARCHAR(45) NULL DEFAULT NULL,
  `contatoPoliticos` VARCHAR(45) NULL DEFAULT 'emailCandidato',
  `imagemPerfilPoliticos` VARCHAR(45) NULL,
  `bannerPerfilPoliticos` VARCHAR(45) NULL,
  PRIMARY KEY (`idPoliticos`),
  UNIQUE INDEX `idCandidatos_UNIQUE` (`idPoliticos` ASC) VISIBLE,
  UNIQUE INDEX `perfilCandidato_UNIQUE` (`perfilPoliticos` ASC) VISIBLE,
  UNIQUE INDEX `contatoCandidato_UNIQUE` (`contatoPoliticos` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `polidez`.`partidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `polidez`.`partidos` (
  `idPartido` INT NOT NULL,
  `nomePartido` VARCHAR(45) NULL DEFAULT NULL,
  `Eleitos_idEleito` INT NOT NULL,
  PRIMARY KEY (`idPartido`),
  UNIQUE INDEX `idPartido_UNIQUE` (`idPartido` ASC) VISIBLE,
  UNIQUE INDEX `nomePartido_UNIQUE` (`nomePartido` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `polidez`.`Eleitos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `polidez`.`Eleitos` (
  `idEleitos` INT NOT NULL,
  `cargoEleitos` VARCHAR(45) NULL,
  `ini_mandEleitos` VARCHAR(45) NULL,
  `fim_mandEleitos` VARCHAR(45) NULL,
  `Politicos_idPoliticos` INT NOT NULL,
  PRIMARY KEY (`idEleitos`),
  INDEX `fk_Eleitos_Politicos1_idx` (`Politicos_idPoliticos` ASC) VISIBLE,
  CONSTRAINT `fk_Eleitos_Politicos1`
    FOREIGN KEY (`Politicos_idPoliticos`)
    REFERENCES `polidez`.`Politicos` (`idPoliticos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `polidez`.`projetos_Politicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `polidez`.`projetos_Politicos` (
  `idProjPoliticos` INT NOT NULL,
  `descricaoProjPoliticos` VARCHAR(45) NOT NULL,
  `dataProjPoliticos` VARCHAR(45) NULL DEFAULT NULL,
  `statusProjPoliticos` VARCHAR(45) NULL DEFAULT NULL,
  `tituloProjPoliticos` VARCHAR(45) NULL DEFAULT NULL,
  `Eleitos_idEleitos` INT NOT NULL,
  PRIMARY KEY (`idProjPoliticos`),
  INDEX `fk_projetosPoliticos_Eleitos1_idx` (`Eleitos_idEleitos` ASC) VISIBLE,
  CONSTRAINT `fk_projetosPoliticos_Eleitos1`
    FOREIGN KEY (`Eleitos_idEleitos`)
    REFERENCES `polidez`.`Eleitos` (`idEleitos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `polidez`.`Propostas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `polidez`.`Propostas` (
  `idPropostasEleito` INT NOT NULL,
  `tituloPropEleito` VARCHAR(45) NULL DEFAULT NULL,
  `statusPropEleito` VARCHAR(45) NULL DEFAULT NULL,
  `dataPropEleito` VARCHAR(45) NULL DEFAULT NULL,
  `descricaoPropEleito` VARCHAR(45) NULL DEFAULT NULL,
  `Politicos_idPoliticos` INT NOT NULL,
  PRIMARY KEY (`idPropostasEleito`),
  UNIQUE INDEX `idProjetosEleito_UNIQUE` (`idPropostasEleito` ASC) VISIBLE,
  INDEX `fk_Propostas_eleitos_Politicos1_idx` (`Politicos_idPoliticos` ASC) VISIBLE,
  CONSTRAINT `fk_Propostas_eleitos_Politicos1`
    FOREIGN KEY (`Politicos_idPoliticos`)
    REFERENCES `polidez`.`Politicos` (`idPoliticos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `polidez`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `polidez`.`Usuario` (
  `idUsuario` INT NOT NULL,
  `cidadeUsuario` VARCHAR(45) NULL,
  `numUsuario` VARCHAR(45) NULL,
  `complementoUsuario` VARCHAR(45) NULL,
  `endereçoUsuario` VARCHAR(45) NULL,
  `nomeUsuario` VARCHAR(45) NULL,
  `dataNascUsuario` VARCHAR(45) NULL,
  `emailUsuario` VARCHAR(45) NULL,
  `CPFUsuario` VARCHAR(45) NULL,
  `TelefoneUsuario` VARCHAR(45) NULL,
  `SenhaUsuario` VARCHAR(45) NULL,
  `bannerPerfilUsuario` VARCHAR(45) NULL,
  `imagemPerfilUsuario` VARCHAR(45) NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `polidez`.`Politicos_has_partidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `polidez`.`Politicos_has_partidos` (
  `Politicos_idPoliticos` INT NOT NULL,
  `partidos_idPartido` INT NOT NULL,
  `ini_filiacao` VARCHAR(45) NULL,
  `fim_filiacao` VARCHAR(45) NULL,
  `nomePartido` VARCHAR(45) NULL,
  PRIMARY KEY (`Politicos_idPoliticos`, `partidos_idPartido`),
  INDEX `fk_Politicos_has_partidos_partidos1_idx` (`partidos_idPartido` ASC) VISIBLE,
  INDEX `fk_Politicos_has_partidos_Politicos1_idx` (`Politicos_idPoliticos` ASC) VISIBLE,
  CONSTRAINT `fk_Politicos_has_partidos_Politicos1`
    FOREIGN KEY (`Politicos_idPoliticos`)
    REFERENCES `polidez`.`Politicos` (`idPoliticos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Politicos_has_partidos_partidos1`
    FOREIGN KEY (`partidos_idPartido`)
    REFERENCES `polidez`.`partidos` (`idPartido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `polidez`.`Seguindo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `polidez`.`Seguindo` (
  `Politicos_idPoliticos` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Data_inicio_seguindo` VARCHAR(45) NULL,
  PRIMARY KEY (`Politicos_idPoliticos`, `Usuario_idUsuario`),
  INDEX `fk_Politicos_has_Usuario_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_Politicos_has_Usuario_Politicos1_idx` (`Politicos_idPoliticos` ASC) VISIBLE,
  CONSTRAINT `fk_Politicos_has_Usuario_Politicos1`
    FOREIGN KEY (`Politicos_idPoliticos`)
    REFERENCES `polidez`.`Politicos` (`idPoliticos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Politicos_has_Usuario_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `polidez`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `polidez`.`resposta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `polidez`.`resposta` (
  `idresposta` INT NOT NULL,
  `id_respondente` INT NOT NULL,
  `tipo_respondente` INT NULL,
  `resposta` VARCHAR(45) NULL,
  `data_resposta` VARCHAR(45) NULL,
  `Politicos_idPoliticos` INT NOT NULL,
  PRIMARY KEY (`idresposta`, `id_respondente`),
  INDEX `fk_resposta_Politicos1_idx` (`Politicos_idPoliticos` ASC) VISIBLE,
  CONSTRAINT `fk_resposta_Politicos1`
    FOREIGN KEY (`Politicos_idPoliticos`)
    REFERENCES `polidez`.`Politicos` (`idPoliticos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `polidez`.`mensagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `polidez`.`mensagem` (
  `idmensagem` INT NOT NULL,
  `data_msg` VARCHAR(45) NULL,
  `mensagem` VARCHAR(45) NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Politicos_idPoliticos` INT NOT NULL,
  `resposta_idresposta` INT NOT NULL,
  `resposta_id_respondente` INT NOT NULL,
  PRIMARY KEY (`idmensagem`),
  INDEX `fk_mensagem_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_mensagem_Politicos1_idx` (`Politicos_idPoliticos` ASC) VISIBLE,
  INDEX `fk_mensagem_resposta1_idx` (`resposta_idresposta` ASC, `resposta_id_respondente` ASC) VISIBLE,
  CONSTRAINT `fk_mensagem_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `polidez`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mensagem_Politicos1`
    FOREIGN KEY (`Politicos_idPoliticos`)
    REFERENCES `polidez`.`Politicos` (`idPoliticos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mensagem_resposta1`
    FOREIGN KEY (`resposta_idresposta` , `resposta_id_respondente`)
    REFERENCES `polidez`.`resposta` (`idresposta` , `id_respondente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `polidez`.`Lives`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `polidez`.`Lives` (
  `idLives` INT NOT NULL AUTO_INCREMENT,
  `Politicos_idPoliticos` INT NOT NULL,
  `dataLive` VARCHAR(45) NULL,
  `horaInicioLive` VARCHAR(45) NULL,
  `horaFinalLive` VARCHAR(45) NULL,
  `tituloLive` VARCHAR(45) NULL,
  `assuntoLive` VARCHAR(45) NULL,
  INDEX `fk_Lives_Politicos1_idx` (`Politicos_idPoliticos` ASC) VISIBLE,
  PRIMARY KEY (`idLives`),
  CONSTRAINT `fk_Lives_Politicos1`
    FOREIGN KEY (`Politicos_idPoliticos`)
    REFERENCES `polidez`.`Politicos` (`idPoliticos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `polidez`.`Postagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `polidez`.`Postagem` (
  `idPostagem` INT NOT NULL,
  `data_postagem` VARCHAR(45) NULL,
  `Postagem` TEXT(500) NULL,
  `Politicos_idPoliticos` INT NOT NULL,
  `Titulo_postagem` VARCHAR(150) NULL,
  `Imagem_postagem` VARCHAR(45) NULL,
  PRIMARY KEY (`idPostagem`),
  INDEX `fk_Postagem_Politicos1_idx` (`Politicos_idPoliticos` ASC) VISIBLE,
  CONSTRAINT `fk_Postagem_Politicos1`
    FOREIGN KEY (`Politicos_idPoliticos`)
    REFERENCES `polidez`.`Politicos` (`idPoliticos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `polidez`.`Usuario_curte_postagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `polidez`.`Usuario_curte_postagem` (
  `Usuario_idUsuario` INT NOT NULL,
  `Postagem_idPostagem` INT NOT NULL,
  `Data_curtida` DATE NULL,
  `Usuario_curte_postagem` VARCHAR(45) NULL,
  INDEX `fk_Usuario_has_Postagem_Postagem1_idx` (`Postagem_idPostagem` ASC) VISIBLE,
  INDEX `fk_Usuario_has_Postagem_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_Postagem_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `polidez`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Postagem_Postagem1`
    FOREIGN KEY (`Postagem_idPostagem`)
    REFERENCES `polidez`.`Postagem` (`idPostagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
