# Tabela `Pessoa`
CREATE TABLE IF NOT EXISTS `Pessoa` (
  `idPessoa` INT NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `dataNascimento` DATE NOT NULL,
  `Localidade_idMapa` INT NOT NULL,
  `estadoCivil` VARCHAR(10) NOT NULL,
  `Signo_signo` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`idPessoa`),
  FOREIGN KEY (`Localidade_idMapa`) REFERENCES `Localidade` (`idMapa`),
  FOREIGN KEY (`Signo_signo`) REFERENCES `Signo` (`signo`));