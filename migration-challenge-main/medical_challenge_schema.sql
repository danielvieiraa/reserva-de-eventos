-- MySQL Script generated by MySQL Workbench
-- Wed May 12 11:45:11 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema temporario
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema temporario
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `temporario` DEFAULT CHARACTER SET utf8 ;
USE `temporario` ;

-- -----------------------------------------------------
-- Table `temporario`.`convenios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `temporario`.`convenios` ;

CREATE TABLE IF NOT EXISTS `temporario`.`convenios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `temporario`.`pacientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `temporario`.`pacientes` ;

CREATE TABLE IF NOT EXISTS `temporario`.`pacientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `sexo` ENUM('Masculino', 'Feminino') NOT NULL,
  `nascimento` DATE NOT NULL,
  `cpf` VARCHAR(14) NULL,
  `rg` VARCHAR(20) NULL,
  `id_convenio` INT NULL,
  `cod_referencia` VARCHAR(50) NULL,
  PRIMARY KEY (`id`),
  INDEX `paciente_id_convenio_idx` (`id_convenio` ASC) VISIBLE,
  CONSTRAINT `paciente_id_convenio`
    FOREIGN KEY (`id_convenio`)
    REFERENCES `temporario`.`convenios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `temporario`.`procedimentos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `temporario`.`procedimentos` ;

CREATE TABLE IF NOT EXISTS `temporario`.`procedimentos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `temporario`.`profissionais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `temporario`.`profissionais` ;

CREATE TABLE IF NOT EXISTS `temporario`.`profissionais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `crm` VARCHAR(20) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `temporario`.`agendamentos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `temporario`.`agendamentos` ;

CREATE TABLE IF NOT EXISTS `temporario`.`agendamentos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_paciente` INT NULL,
  `id_profissional` INT NOT NULL,
  `dh_inicio` DATETIME NOT NULL,
  `dh_fim` DATETIME NOT NULL,
  `id_convenio` INT NULL,
  `id_procedimento` INT NULL,
  `observacoes` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `agendamento_id_convenio_idx` (`id_convenio` ASC) VISIBLE,
  INDEX `agendamento_id_procedimento_idx` (`id_procedimento` ASC) VISIBLE,
  INDEX `agendamento_id_profissional_idx` (`id_profissional` ASC) VISIBLE,
  INDEX `agendamento_id_paciente_idx` (`id_paciente` ASC) VISIBLE,
  CONSTRAINT `agendamento_id_convenio`
    FOREIGN KEY (`id_convenio`)
    REFERENCES `temporario`.`convenios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `agendamento_id_procedimento`
    FOREIGN KEY (`id_procedimento`)
    REFERENCES `temporario`.`procedimentos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `agendamento_id_profissional`
    FOREIGN KEY (`id_profissional`)
    REFERENCES `temporario`.`profissionais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `agendamento_id_paciente`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `temporario`.`pacientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `temporario`.`convenios`
-- -----------------------------------------------------
START TRANSACTION;
USE `temporario`;
INSERT INTO `temporario`.`convenios` (`id`, `nome`, `descricao`) VALUES (1, 'Particular', 'Convênio Particular (Padrão)');
INSERT INTO `temporario`.`convenios` (`id`, `nome`, `descricao`) VALUES (2, 'DevMed', 'Convênio da Empresa Dev');
INSERT INTO `temporario`.`convenios` (`id`, `nome`, `descricao`) VALUES (4, 'MigraMed', 'Convênio dos Funcionário de Migração da Empresa Dev');

COMMIT;


-- -----------------------------------------------------
-- Data for table `temporario`.`pacientes`
-- -----------------------------------------------------
START TRANSACTION;
USE `temporario`;
INSERT INTO `temporario`.`pacientes` (`id`, `nome`, `sexo`, `nascimento`, `cpf`, `rg`, `id_convenio`, `cod_referencia`) VALUES (1, 'Paciente de Testes', DEFAULT, '1989-05-12', '000.000.000-00', '00000-0', 1, NULL);
INSERT INTO `temporario`.`pacientes` (`id`, `nome`, `sexo`, `nascimento`, `cpf`, `rg`, `id_convenio`, `cod_referencia`) VALUES (10272, 'Fulano de Tal', DEFAULT, '1974-06-19', '111.111.111-22', '11111-2', 1, NULL);
INSERT INTO `temporario`.`pacientes` (`id`, `nome`, `sexo`, `nascimento`, `cpf`, `rg`, `id_convenio`, `cod_referencia`) VALUES (10276, 'Ciclano de Tal', DEFAULT, '2001-12-25', '222.222.222-33', '22222-3', 4, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `temporario`.`procedimentos`
-- -----------------------------------------------------
START TRANSACTION;
USE `temporario`;
INSERT INTO `temporario`.`procedimentos` (`id`, `nome`, `descricao`) VALUES (1, 'Consulta', 'Procedimento Padrão da Clínica');
INSERT INTO `temporario`.`procedimentos` (`id`, `nome`, `descricao`) VALUES (2, 'Retorno', 'Pacientes em Caráter de Retorno');
INSERT INTO `temporario`.`procedimentos` (`id`, `nome`, `descricao`) VALUES (3, 'Acompanhamento', 'Consulta de Acompanhamento');

COMMIT;


-- -----------------------------------------------------
-- Data for table `temporario`.`profissionais`
-- -----------------------------------------------------
START TRANSACTION;
USE `temporario`;
INSERT INTO `temporario`.`profissionais` (`id`, `nome`, `crm`) VALUES (85217, 'Dr. Lucas KNE', NULL);
INSERT INTO `temporario`.`profissionais` (`id`, `nome`, `crm`) VALUES (85218, 'Dr. Analista Pietro', NULL);
INSERT INTO `temporario`.`profissionais` (`id`, `nome`, `crm`) VALUES (85219, 'Suporte temporario', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `temporario`.`agendamentos`
-- -----------------------------------------------------
START TRANSACTION;
USE `temporario`;
INSERT INTO `temporario`.`agendamentos` (`id`, `id_paciente`, `id_profissional`, `dh_inicio`, `dh_fim`, `id_convenio`, `id_procedimento`, `observacoes`) VALUES (1, 1, 85217, '2021-05-12 11:15:00', '2021-05-12 11:30:00', 1, 1, 'Primeira consulta do paciente.');
INSERT INTO `temporario`.`agendamentos` (`id`, `id_paciente`, `id_profissional`, `dh_inicio`, `dh_fim`, `id_convenio`, `id_procedimento`, `observacoes`) VALUES (2, 1, 85217, '2021-05-14 08:00:00', '2021-05-14 08:30:00', 1, 2, 'Retorno do paciente.');
INSERT INTO `temporario`.`agendamentos` (`id`, `id_paciente`, `id_profissional`, `dh_inicio`, `dh_fim`, `id_convenio`, `id_procedimento`, `observacoes`) VALUES (3, 10276, 85218, '2021-06-01 14:30:00', '2021-06-01 14:45:00', 4, 3, 'Acompanhamento de rotina.');

COMMIT;

