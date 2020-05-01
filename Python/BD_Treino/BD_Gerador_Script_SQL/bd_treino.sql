# Criar Banco de Dados
CREATE DATABASE `DBTeste`;

# Selecionar BD
USE `DBTeste`;

# Tabela `Localidade`
CREATE TABLE IF NOT EXISTS `Localidade` (
  `idMapa` INT NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `uf` VARCHAR(2) NOT NULL,
  `regiao` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idMapa`));

# Tabela `Signo`
CREATE TABLE IF NOT EXISTS `Signo` (
  `signo` VARCHAR(12) NOT NULL,
  `dataInicial` VARCHAR(15) NOT NULL,
  `dataFinal` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`signo`));

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

# Tabela `Fruta`
CREATE TABLE IF NOT EXISTS `Fruta` (
  `idFrutas` INT NOT NULL,
  `nomeFruta` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idFrutas`));

# Tabela `Comida`
CREATE TABLE IF NOT EXISTS `Comida` (
  `idComida` INT NOT NULL,
  `nomePrato` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idComida`));

# Tabela `Carro`
CREATE TABLE IF NOT EXISTS `Carro` (
  `idCarro` INT NOT NULL,
  `nomeCarro` VARCHAR(15) NOT NULL,
  `marcaCarro` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idCarro`));

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