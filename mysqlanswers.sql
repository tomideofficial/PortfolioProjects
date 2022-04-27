
;


CREATE SCHEMA IF NOT EXISTS `project_1` DEFAULT CHARACTER SET utf8 ;
USE `project_1` ;

-- -----------------------------------------------------
-- Table `project_1`.`Departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_1`.`Departments` (
  `Dept_id` INT NOT NULL,
  `Dept_name` VARCHAR(30) NOT NULL,
  `Dept_description` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`Dept_id`))
ENGINE = InnoDB;

desc Departments;
-- -----------------------------------------------------
-- Table `project_1`.`Jobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_1`.`Jobs` (
  `Job_id` INT NOT NULL,
  `Job_title` VARCHAR(35) not null,
  `min_salary` DECIMAL(6,0) NULL DEFAULT NULL,
  `max_salary` DECIMAL(6,0) NULL,
  PRIMARY KEY (`Job_id`))
ENGINE = InnoDB;

desc Jobs
-- -----------------------------------------------------
-- Table `project_1`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_1`.`employees` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(30) NULL DEFAULT NULL,
  `last_name` VARCHAR(30) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `hire_date` DATE NOT NULL,
  `job_id` INT NOT NULL,
  `commission` DECIMAL(6,0) NULL DEFAULT NULL,
  `Dept_id` INT NOT NULL,
  `salary` DECIMAL(8,2) NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `Dept_id_idx` (`Dept_id` ASC) VISIBLE,
  INDEX `job_id_idx` (`job_id` ASC) VISIBLE,
  CONSTRAINT `Dept_id`
    FOREIGN KEY (`Dept_id`)
    REFERENCES `project_1`.`Departments` (`Dept_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `job_id`
    FOREIGN KEY (`job_id`)
    REFERENCES `project_1`.`Jobs` (`Job_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


desc employees;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
