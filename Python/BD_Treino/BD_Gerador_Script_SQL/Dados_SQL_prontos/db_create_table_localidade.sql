# Tabela `Localidade`
CREATE TABLE IF NOT EXISTS `Localidade` (
  `idMapa` INT NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `uf` VARCHAR(2) NOT NULL,
  `regiao` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idMapa`));