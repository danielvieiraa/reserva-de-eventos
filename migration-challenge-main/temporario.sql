<?php
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
