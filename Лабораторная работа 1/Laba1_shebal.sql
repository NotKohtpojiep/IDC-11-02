-- Создание таблицы Факультет
CREATE TABLE `faculty` (
  `code` int NOT NULL AUTO_INCREMENT COMMENT 'just a comment...',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `foundation_date` date NOT NULL,
  `occupation` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `max_student` int NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `faculty_code_UNIQUE` (`code`)
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8 
COMMENT='Idk what should i put here';

-- Создание таблицы Кафедра
CREATE TABLE `education`.`department` (
  `dep_code` INT NOT NULL,
  `fac_code` INT NOT NULL,
  `name` NVARCHAR(30) NOT NULL,
  `responsible` NVARCHAR(50) NOT NULL,
  `graduating_dep` INT NOT NULL,
  `site` NVARCHAR(100) NULL,
  `mob_number` bigint NULL,
  PRIMARY KEY (`dep_code`),
  INDEX `fac_code_idx` (`fac_code` ASC) VISIBLE,
  CONSTRAINT `faculty_key`
    FOREIGN KEY (`fac_code`)
    REFERENCES `education`.`faculty` (`code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'kAfEdRa -_-'; 