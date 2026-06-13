# Tabela `Pesquisa`
CREATE TABLE IF NOT EXISTS `Pesquisa` (
  `idPesquisa` INT NOT NULL,
  `Comida_idComida` INT NOT NULL,
  `Carro_idCarro` INT NOT NULL,
  `Frutas_idFrutas` INT NOT NULL,
  `Pessoa_idPessoa` INT NOT NULL,
  PRIMARY KEY (`idPesquisa`, `Pessoa_idPessoa`),
  FOREIGN KEY (`Comida_idComida`) REFERENCES `Comida` (`idComida`),
  FOREIGN KEY (`Carro_idCarro`) REFERENCES `Carro` (`idCarro`),
  FOREIGN KEY (`Frutas_idFrutas`) REFERENCES `Fruta` (`idFrutas`),
  FOREIGN KEY (`Pessoa_idPessoa`) REFERENCES `Pessoa` (`idPessoa`));