-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema porfolio
-- -----------------------------------------------------
-- base de datos de usuarios en porfolio

-- -----------------------------------------------------
-- Schema porfolio
--
-- base de datos de usuarios en porfolio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `porfolio` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `porfolio` ;

-- -----------------------------------------------------
-- Table `porfolio`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfolio`.`persona` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(13) NOT NULL,
  `github` VARCHAR(45) NOT NULL,
  `linkedin` VARCHAR(45) NOT NULL,
  `foto` VARCHAR(100) NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  `fechaNac` DATE NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfolio`.`tipo_empleo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfolio`.`tipo_empleo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombreTipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfolio`.`experiencia_profecional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfolio`.`experiencia_profecional` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre_proyecto` VARCHAR(45) NOT NULL,
  `esTrabajoActual` TINYINT NOT NULL,
  `fechaInicio` DATE NOT NULL,
  `fechaFin` DATE NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `persona_id` INT NOT NULL,
  `tipo_empleo_id` INT NOT NULL,
  PRIMARY KEY (`id`, `tipo_empleo_id`, `persona_id`),
  INDEX `fk_experiencia_profecional_persona_idx` (`persona_id` ASC) VISIBLE,
  INDEX `fk_experiencia_profecional_tipo_empleo1_idx` (`tipo_empleo_id` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_profecional_persona`
    FOREIGN KEY (`persona_id`)
    REFERENCES `porfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experiencia_profecional_tipo_empleo1`
    FOREIGN KEY (`tipo_empleo_id`)
    REFERENCES `porfolio`.`tipo_empleo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfolio`.`proyect`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfolio`.`proyect` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  `repositorio/url` VARCHAR(45) NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_proyect_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_proyect_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `porfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfolio`.`tecnology`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfolio`.`tecnology` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(20) NOT NULL,
  `imgIcono` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfolio`.`proyect_has_tecnology`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfolio`.`proyect_has_tecnology` (
  `proyect_id` INT NOT NULL,
  `tecnology_id` INT NOT NULL,
  PRIMARY KEY (`proyect_id`, `tecnology_id`),
  INDEX `fk_proyect_has_tecnology_tecnology1_idx` (`tecnology_id` ASC) VISIBLE,
  INDEX `fk_proyect_has_tecnology_proyect1_idx` (`proyect_id` ASC) VISIBLE,
  CONSTRAINT `fk_proyect_has_tecnology_proyect1`
    FOREIGN KEY (`proyect_id`)
    REFERENCES `porfolio`.`proyect` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proyect_has_tecnology_tecnology1`
    FOREIGN KEY (`tecnology_id`)
    REFERENCES `porfolio`.`tecnology` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfolio`.`educacion/cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfolio`.`educacion/cursos` (
  `id` INT NOT NULL,
  `NombreInst` VARCHAR(45) NOT NULL,
  `ImgDiploma` VARCHAR(45) NULL,
  `Titulo` VARCHAR(45) NOT NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_educacion/cursos_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_educacion/cursos_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `porfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
