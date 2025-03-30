-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema littlelemondm
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondm
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemondm` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `littlelemondm` ;

-- -----------------------------------------------------
-- Table `littlelemondm`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`staff` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Role` VARCHAR(100) NOT NULL,
  `Address` VARCHAR(255) NULL DEFAULT NULL,
  `Contact_Number` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `Annual_Salary` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE INDEX `Contact_Number` (`Contact_Number` ASC) VISIBLE,
  UNIQUE INDEX `Email` (`Email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondm`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`customers` (
  `ClientID` INT NOT NULL AUTO_INCREMENT,
  `ClientFirstName` VARCHAR(250) NOT NULL,
  `ClientLastName` VARCHAR(250) NOT NULL,
  `PhoneNumber` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`ClientID`),
  UNIQUE INDEX `PhoneNumber` (`PhoneNumber` ASC) VISIBLE,
  UNIQUE INDEX `Email` (`Email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondm`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `TableNo` INT NULL DEFAULT NULL,
  `EmployeeID` INT NULL DEFAULT NULL,
  `ClientID` INT NOT NULL,
  `BookingTime` DATETIME NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `EmployeeID` (`EmployeeID` ASC) VISIBLE,
  INDEX `ClientID` (`ClientID` ASC) VISIBLE,
  CONSTRAINT `bookings_ibfk_1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `littlelemondm`.`staff` (`EmployeeID`)
    ON DELETE SET NULL,
  CONSTRAINT `bookings_ibfk_2`
    FOREIGN KEY (`ClientID`)
    REFERENCES `littlelemondm`.`customers` (`ClientID`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondm`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`menus` (
  `MenuID` INT NOT NULL AUTO_INCREMENT,
  `MenuName` VARCHAR(200) NOT NULL,
  `Cuisine` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondm`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `TableNo` INT NOT NULL,
  `MenuID` INT NOT NULL,
  `BookingID` INT NOT NULL,
  `BillAmount` DECIMAL(10,2) NOT NULL,
  `Quantity` INT NULL DEFAULT NULL,
  `OrderDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`OrderID`),
  INDEX `BookingID` (`BookingID` ASC) VISIBLE,
  INDEX `MenuID` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`BookingID`)
    REFERENCES `littlelemondm`.`bookings` (`BookingID`)
    ON DELETE CASCADE,
  CONSTRAINT `orders_ibfk_2`
    FOREIGN KEY (`MenuID`)
    REFERENCES `littlelemondm`.`menus` (`MenuID`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondm`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`delivery` (
  `DeliveryID` INT NOT NULL AUTO_INCREMENT,
  `DeliveryDate` DATE NOT NULL,
  `DeliveryStatus` ENUM('Pending', 'Dispatched', 'Delivered', 'Cancelled') NOT NULL,
  `OrderID` INT NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `OrderID` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `delivery_ibfk_1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `littlelemondm`.`orders` (`OrderID`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondm`.`menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`menuitems` (
  `MenuItemID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(200) NOT NULL,
  `CourseType` ENUM('Starter', 'Main Course', 'Dessert') NOT NULL,
  `Price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`MenuItemID`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondm`.`menu_menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`menu_menuitems` (
  `MenuID` INT NOT NULL,
  `MenuItemID` INT NOT NULL,
  PRIMARY KEY (`MenuID`, `MenuItemID`),
  INDEX `MenuItemID` (`MenuItemID` ASC) VISIBLE,
  CONSTRAINT `menu_menuitems_ibfk_1`
    FOREIGN KEY (`MenuID`)
    REFERENCES `littlelemondm`.`menus` (`MenuID`),
  CONSTRAINT `menu_menuitems_ibfk_2`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `littlelemondm`.`menuitems` (`MenuItemID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

