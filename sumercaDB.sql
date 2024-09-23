-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sumerca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sumerca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sumerca` DEFAULT CHARACTER SET latin1 ;
USE `sumerca` ;

-- -----------------------------------------------------
-- Table `sumerca`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sumerca`.`Usuarios` (
  `idUsuarios` INT(18) NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `fechaNacimiento` DATE NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` VARCHAR(20) NULL,
  PRIMARY KEY (`idUsuarios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sumerca`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sumerca`.`clientes` (
  `cedula` INT(18) NOT NULL DEFAULT '0',
  `puntaje` INT NULL,
  `paginaWeb` VARCHAR(60) NULL,
  `direccion` VARCHAR(45) NULL,
  PRIMARY KEY (`cedula`),
  CONSTRAINT `fkusuariosClientes`
    FOREIGN KEY (`cedula`)
    REFERENCES `sumerca`.`Usuarios` (`idUsuarios`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sumerca`.`tipoproductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sumerca`.`tipoproductos` (
  `idTipoProducto` INT(18) NOT NULL DEFAULT '0',
  `nombreTipoProducto` VARCHAR(50) CHARACTER SET 'utf8' NULL,
  PRIMARY KEY (`idTipoProducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sumerca`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sumerca`.`productos` (
  `idProducto` INT(18) NOT NULL,
  `idTipoProducto` INT(18) NULL,
  `nombreProducto` VARCHAR(50) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `valorVenta` INT(18) NULL DEFAULT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `FK_TIPOPRODUCTO_idx` (`idTipoProducto` ASC) VISIBLE,
  CONSTRAINT `FK_TIPOPRODUCTO`
    FOREIGN KEY (`idTipoProducto`)
    REFERENCES `sumerca`.`tipoproductos` (`idTipoProducto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sumerca`.`sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sumerca`.`sucursal` (
  `idSucursal` INT(18) NOT NULL,
  `nombre` VARCHAR(50) NULL,
  `direccion` VARCHAR(50) NULL DEFAULT NULL,
  `ciudad` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`idSucursal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sumerca`.`vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sumerca`.`vendedor` (
  `Cedula` INT(18) NOT NULL,
  `idSucursal` INT(18) NULL DEFAULT NULL,
  `salario` VARCHAR(45) NULL,
  PRIMARY KEY (`Cedula`),
  INDEX `FK_VENDEDOR_idx` (`idSucursal` ASC) VISIBLE,
  CONSTRAINT `FK_VENDEDOR`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `sumerca`.`sucursal` (`idSucursal`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fkVendedorUsuarios`
    FOREIGN KEY (`Cedula`)
    REFERENCES `sumerca`.`Usuarios` (`idUsuarios`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sumerca`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sumerca`.`factura` (
  `numeroFactura` INT(18) NOT NULL DEFAULT '0',
  `idProducto` INT(18) NULL DEFAULT NULL,
  `idVendedor` INT(18) NULL DEFAULT NULL,
  `idCliente` INT(18) NULL DEFAULT NULL,
  `cantidad` INT(18) NULL DEFAULT NULL,
 `fechaVenta` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`numeroFactura`),
  INDEX `FK_VENDEDOR_idx` (`idVendedor` ASC) VISIBLE,
  INDEX `FK_PRODUCTO_idx` (`idProducto` ASC) VISIBLE,
  INDEX `FK_CLIENTE_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `FK_CLIENTE`
    FOREIGN KEY (`idCliente`)
    REFERENCES `sumerca`.`clientes` (`cedula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PRODUCTOFAC`
    FOREIGN KEY (`idProducto`)
    REFERENCES `sumerca`.`productos` (`idProducto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_VENDEDORFAC`
    FOREIGN KEY (`idVendedor`)
    REFERENCES `sumerca`.`vendedor` (`Cedula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

drop table factura;
select * from factura;


-- -----------------------------------------------------
-- Table `sumerca`.`inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sumerca`.`inventario` (
  `idProducto` INT(18) NOT NULL,
  `cantidad` INT(18) NULL,
  `valor` INT(18) NULL,
  PRIMARY KEY (`idProducto`),
  CONSTRAINT `FK_PRODUCTO`
    FOREIGN KEY (`idProducto`)
    REFERENCES `sumerca`.`productos` (`idProducto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



/*PRUEBAS*/



