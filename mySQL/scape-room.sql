-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema escape_room
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema escape_room
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `escape_room` DEFAULT CHARACTER SET utf8mb4 ;
USE `escape_room` ;

-- -----------------------------------------------------
-- Table `escape_room`.`element`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escape_room`.`element` (
  `element_id` INT NOT NULL AUTO_INCREMENT,
  `type` ENUM('room', 'clue', 'object') NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `quantity` INT NOT NULL DEFAULT 1,
  `price` DECIMAL NULL,
  `status` ENUM('active', 'deleted') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`element_id`),
  UNIQUE INDEX `element_id_UNIQUE` (`element_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escape_room`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escape_room`.`room` (
  `element_id` INT NOT NULL,
  `difficulty` ENUM('easy', 'medium', 'hard', 'very hard') NOT NULL,
  PRIMARY KEY (`element_id`),
  UNIQUE INDEX `element_id_UNIQUE` (`element_id` ASC) VISIBLE,
  CONSTRAINT `fk_element3`
    FOREIGN KEY (`element_id`)
    REFERENCES `escape_room`.`element` (`element_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escape_room`.`clue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escape_room`.`clue` (
  `element_id` INT NOT NULL,
  `theme` ENUM('horror', 'western', 'scifi') NOT NULL,
  PRIMARY KEY (`element_id`),
  UNIQUE INDEX `element_id_UNIQUE` (`element_id` ASC) VISIBLE,
  CONSTRAINT `fk_element1`
    FOREIGN KEY (`element_id`)
    REFERENCES `escape_room`.`element` (`element_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escape_room`.`decor_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escape_room`.`decor_item` (
  `element_id` INT NOT NULL,
  `material` ENUM('wood', 'metal', 'glass', 'cardboard', 'paper', 'fabric', 'leather', 'stone', 'ceramic', 'electronics', 'resin', 'rubber', 'foam', 'plastic', 'other') NOT NULL DEFAULT 'other',
  PRIMARY KEY (`element_id`),
  INDEX `fk_element2_idx` (`element_id` ASC) VISIBLE,
  UNIQUE INDEX `element_id_UNIQUE` (`element_id` ASC) VISIBLE,
  CONSTRAINT `fk_element2`
    FOREIGN KEY (`element_id`)
    REFERENCES `escape_room`.`element` (`element_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escape_room`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escape_room`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escape_room`.`reward`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escape_room`.`reward` (
  `reward_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`reward_id`),
  UNIQUE INDEX `reward_id_UNIQUE` (`reward_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escape_room`.`user_plays_room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escape_room`.`user_plays_room` (
  `user_id` INT NOT NULL,
  `room_id` INT NOT NULL,
  `solved` TINYINT NOT NULL,
  `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`, `room_id`),
  INDEX `fk_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_room3_idx` (`room_id` ASC) VISIBLE,
  CONSTRAINT `fk_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `escape_room`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_room3`
    FOREIGN KEY (`room_id`)
    REFERENCES `escape_room`.`room` (`element_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escape_room`.`user_has_reward`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escape_room`.`user_has_reward` (
  `user_id` INT NOT NULL,
  `reward_id` INT NOT NULL,
  `date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`, `reward_id`),
  INDEX `fk_reward1_idx` (`reward_id` ASC) VISIBLE,
  INDEX `fk_user2_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user2`
    FOREIGN KEY (`user_id`)
    REFERENCES `escape_room`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reward1`
    FOREIGN KEY (`reward_id`)
    REFERENCES `escape_room`.`reward` (`reward_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escape_room`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escape_room`.`ticket` (
  `ticket_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `price` DECIMAL NOT NULL,
  `cashed` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ticket_id`, `user_id`),
  INDEX `fk_user3_idx` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `ticket_id_UNIQUE` (`ticket_id` ASC) VISIBLE,
  CONSTRAINT `fk_user3`
    FOREIGN KEY (`user_id`)
    REFERENCES `escape_room`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escape_room`.`subcription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escape_room`.`subcription` (
  `user_id` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user4`
    FOREIGN KEY (`user_id`)
    REFERENCES `escape_room`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escape_room`.`room_has_clue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escape_room`.`room_has_clue` (
  `room_id` INT NOT NULL,
  `clue_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`room_id`, `clue_id`),
  INDEX `fk_clue1_idx` (`clue_id` ASC) VISIBLE,
  INDEX `fk_room1_idx` (`room_id` ASC) VISIBLE,
  CONSTRAINT `fk_room1`
    FOREIGN KEY (`room_id`)
    REFERENCES `escape_room`.`room` (`element_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clue1`
    FOREIGN KEY (`clue_id`)
    REFERENCES `escape_room`.`clue` (`element_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escape_room`.`room_has_decor_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escape_room`.`room_has_decor_items` (
  `room_id` INT NOT NULL,
  `decor_item_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`room_id`, `decor_item_id`),
  INDEX `fk_decor_items1_idx` (`decor_item_id` ASC) VISIBLE,
  INDEX `fk_room2_idx` (`room_id` ASC) VISIBLE,
  CONSTRAINT `fk_room2`
    FOREIGN KEY (`room_id`)
    REFERENCES `escape_room`.`room` (`element_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_decor_items1`
    FOREIGN KEY (`decor_item_id`)
    REFERENCES `escape_room`.`decor_item` (`element_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
