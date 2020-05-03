
### BD_TREINO.SQL ###

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

### TAB_LOCALIDADE.SQL ###

INSERT INTO `Localidade`
	(`idMapa`,`cidade`,`uf`,`regiao`)
VALUES
	("1","Angra Dos Reis","RJ","Região Sudeste"),
	("2","Aperibé","RJ","Região Sudeste"),
	("3","Araruama","RJ","Região Sudeste"),
	("4","Areal","RJ","Região Sudeste"),
	("5","Armação Dos Búzios","RJ","Região Sudeste"),
	("6","Arraial do Cabo","RJ","Região Sudeste"),
	("7","Barra do Piraí","RJ","Região Sudeste"),
	("8","Barra Mansa","RJ","Região Sudeste"),
	("9","Belford Roxo","RJ","Região Sudeste"),
	("10","Bom Jardim","RJ","Região Sudeste"),
	("11","Bom Jesus do Itabapoana","RJ","Região Sudeste"),
	("12","Cabo Frio","RJ","Região Sudeste"),
	("13","Cachoeiras de Macacu","RJ","Região Sudeste"),
	("14","Cambuci","RJ","Região Sudeste"),
	("15","Carapebus","RJ","Região Sudeste"),
	("16","Comendador Levy Gasparian","RJ","Região Sudeste"),
	("17","Campos Dos Goytacazes","RJ","Região Sudeste"),
	("18","Cantagalo","RJ","Região Sudeste"),
	("19","Cardoso Moreira","RJ","Região Sudeste"),
	("20","Carmo","RJ","Região Sudeste"),
	("21","Casimiro de Abreu","RJ","Região Sudeste"),
	("22","Conceição de Macabu","RJ","Região Sudeste"),
	("23","Cordeiro","RJ","Região Sudeste"),
	("24","Duas Barras","RJ","Região Sudeste"),
	("25","Duque de Caxias","RJ","Região Sudeste"),
	("26","Engenheiro Paulo de Frontin","RJ","Região Sudeste"),
	("27","Guapimirim","RJ","Região Sudeste"),
	("28","Iguaba Grande","RJ","Região Sudeste"),
	("29","Itaboraí","RJ","Região Sudeste"),
	("30","Itaguaí","RJ","Região Sudeste"),
	("31","Italva","RJ","Região Sudeste"),
	("32","Itaocara","RJ","Região Sudeste"),
	("33","Itaperuna","RJ","Região Sudeste"),
	("34","Itatiaia","RJ","Região Sudeste"),
	("35","Japeri","RJ","Região Sudeste"),
	("36","Laje do Muriaé","RJ","Região Sudeste"),
	("37","Macaé","RJ","Região Sudeste"),
	("38","Macuco","RJ","Região Sudeste"),
	("39","Magé","RJ","Região Sudeste"),
	("40","Mangaratiba","RJ","Região Sudeste"),
	("41","Maricá","RJ","Região Sudeste"),
	("42","Mendes","RJ","Região Sudeste"),
	("43","Mesquita","RJ","Região Sudeste"),
	("44","Miguel Pereira","RJ","Região Sudeste"),
	("45","Miracema","RJ","Região Sudeste"),
	("46","Natividade","RJ","Região Sudeste"),
	("47","Nilópolis","RJ","Região Sudeste"),
	("48","Niterói","RJ","Região Sudeste"),
	("49","Nova Friburgo","RJ","Região Sudeste"),
	("50","Nova Iguaçu","RJ","Região Sudeste"),
	("51","Paracambi","RJ","Região Sudeste"),
	("52","Paraíba do Sul","RJ","Região Sudeste"),
	("53","Parati","RJ","Região Sudeste"),
	("54","Paty do Alferes","RJ","Região Sudeste"),
	("55","Petrópolis","RJ","Região Sudeste"),
	("56","Pinheiral","RJ","Região Sudeste"),
	("57","Piraí","RJ","Região Sudeste"),
	("58","Porciúncula","RJ","Região Sudeste"),
	("59","Porto Real","RJ","Região Sudeste"),
	("60","Quatis","RJ","Região Sudeste"),
	("61","Queimados","RJ","Região Sudeste"),
	("62","Quissamã","RJ","Região Sudeste"),
	("63","Resende","RJ","Região Sudeste"),
	("64","Rio Bonito","RJ","Região Sudeste"),
	("65","Rio Claro","RJ","Região Sudeste"),
	("66","Rio Das Flores","RJ","Região Sudeste"),
	("67","Rio Das Ostras","RJ","Região Sudeste"),
	("68","Rio de Janeiro","RJ","Região Sudeste"),
	("69","Santa Maria Madalena","RJ","Região Sudeste"),
	("70","Santo Antônio de Pádua","RJ","Região Sudeste"),
	("71","São Francisco de Itabapoana","RJ","Região Sudeste"),
	("72","São Fidélis","RJ","Região Sudeste"),
	("73","São Gonçalo","RJ","Região Sudeste"),
	("74","São João da Barra","RJ","Região Sudeste"),
	("75","São João de Meriti","RJ","Região Sudeste"),
	("76","São José de Ubá","RJ","Região Sudeste"),
	("77","São José do Vale do Rio Preto","RJ","Região Sudeste"),
	("78","São Pedro da Aldeia","RJ","Região Sudeste"),
	("79","São Sebastião do Alto","RJ","Região Sudeste"),
	("80","Sapucaia","RJ","Região Sudeste"),
	("81","Saquarema","RJ","Região Sudeste"),
	("82","Seropédica","RJ","Região Sudeste"),
	("83","Silva Jardim","RJ","Região Sudeste"),
	("84","Sumidouro","RJ","Região Sudeste"),
	("85","Tanguá","RJ","Região Sudeste"),
	("86","Teresópolis","RJ","Região Sudeste"),
	("87","Trajano de Morais","RJ","Região Sudeste"),
	("88","Três Rios","RJ","Região Sudeste"),
	("89","Valença","RJ","Região Sudeste"),
	("90","Varre-sai","RJ","Região Sudeste"),
	("91","Vassouras","RJ","Região Sudeste"),
	("92","Volta Redonda","RJ","Região Sudeste");

### TAB_SIGNO.SQL ###

INSERT INTO `Signo`
	(`signo`,`dataInicial`,`dataFinal`)
VALUES
	("Aquário","20 de janeiro","18 de fevereiro"),
	("Peixes","19 de fevereiro","20 de março"),
	("Áries","21 de março","19 de abril"),
	("Touro","20 de abril","20 de maio"),
	("Gêmeos","21 de maio","21 de junho"),
	("Câncer","22 de junho","22 de julho"),
	("Leão","23 de julho","22 de agosto"),
	("Virgem","23 de agosto","22 de setembro"),
	("Libra","23 de setembro","22 de outubro"),
	("Escorpião","23 de outubro","21 de novembro"),
	("Sagitário","22 de novembro","21 de dezembro"),
	("Capricórnio","22 de dezembro","19 de janeiro");

### TAB_FRUTA.SQL ###

INSERT INTO `Fruta`
	(`idFrutas`,`nomeFruta`)
VALUES
	("1","Abacate"),
	("2","Abacaxi "),
	("3","Abiu"),
	("4","Abóbora "),
	("5","Abricó"),
	("6","Açaí"),
	("7","Acerola"),
	("8","Ameixa"),
	("9","Amora"),
	("10","Ananás "),
	("11","Anonácea"),
	("12","Araçá"),
	("13","Azeitona "),
	("14","Babaco"),
	("15","Bacaba"),
	("16","Bacuri"),
	("17","Banana"),
	("18","Baru"),
	("19","Bilimbi"),
	("20","Biribá"),
	("21","Buriti"),
	("22","Butiá"),
	("23","Cabeludinha"),
	("24","Cacau "),
	("25","Cagaita"),
	("26","Cagaita"),
	("27","Caimito"),
	("28","Cajá"),
	("29","Cajá-manga"),
	("30","Caju"),
	("31","Calabaça "),
	("32","Calabura"),
	("33","Cambucá"),
	("34","Cambuci"),
	("35","Caqui "),
	("36","Carambola "),
	("37","Cereja "),
	("38","Coco "),
	("39","Conde"),
	("40","Cupuaçu"),
	("41","Damasco "),
	("42","Dovyalis"),
	("43","Durião"),
	("44","Embaúba"),
	("45","Feijoa"),
	("46","Figo "),
	("47","Framboesa "),
	("48","Fruta-do-conde"),
	("49","Fruta-pão"),
	("50","Glicosmis"),
	("51","Goiaba "),
	("52","Granadilla"),
	("53","Graviola"),
	("54","Groselha "),
	("55","Grumixama"),
	("56","Guabiju"),
	("57","Guabiroba"),
	("58","Guaraná"),
	("59","Guariroba"),
	("60","Heisteria"),
	("61","Himbeere"),
	("62","Ilama"),
	("63","Ingá"),
	("64","Jabuticaba"),
	("65","Jaca"),
	("66","Jambo"),
	("67","Jambolão"),
	("68","Jamelão"),
	("69","Jaracatiá"),
	("70","Jatobá"),
	("71","Jenipapo"),
	("72","Jerivá"),
	("73","Jujuba"),
	("74","Kiwi"),
	("75","Langsat"),
	("76","Laranja "),
	("77","Lichia "),
	("78","Limão "),
	("79","Limas Ácida"),
	("80","Lima Doce"),
	("81","Longan"),
	("82","Lucuma"),
	("83","Mabolo"),
	("84","Maçã "),
	("85","Macadâmia"),
	("86","Mamão "),
	("87","Mamey"),
	("88","Mamoncillo"),
	("89","Maná"),
	("90","Manga "),
	("91","Mangaba"),
	("92","Mangostão "),
	("93","Maracujá"),
	("94","Marmeladinha"),
	("95","Marmelo "),
	("96","Marolo"),
	("97","Marula"),
	("98","Massala"),
	("99","Melancia "),
	("100","Melão "),
	("101","Mirtilo "),
	("102","Morango "),
	("103","Murici"),
	("104","Naranjilla"),
	("105","Nectarina "),
	("106","Nêspera "),
	("107","Noni"),
	("108","Noz Pecã"),
	("109","Olho-De-Boi"),
	("110","Pequi"),
	("111","Pêra"),
	("112","Pêssego "),
	("113","Physalis"),
	("114","Pinha"),
	("115","Pinhão "),
	("116","Pistache"),
	("117","Pitanga"),
	("118","Pitangão"),
	("119","Pitaya"),
	("120","Pitomba"),
	("121","Pulasan"),
	("122","Pupunha"),
	("123","Quina"),
	("124","Rambutão"),
	("125","Romã "),
	("126","Salak"),
	("127","Santol"),
	("128","Sapoti"),
	("129","Sapucaia"),
	("130","Sapucaia"),
	("131","Seriguela"),
	("132","Taiúva "),
	("133","Tâmara"),
	("134","Tamarindo"),
	("135","Tangerina "),
	("136","Tarumã"),
	("137","Tomate "),
	("138","Toranja "),
	("139","Umbu"),
	("140","Umê"),
	("141","Uva "),
	("142","Uvaia"),
	("143","Veludo"),
	("144","Xixá"),
	("145","Yamamomo"),
	("146","Zimbro "),
	("147","Zitrone");

### TAB_COMIDA.SQL ###

INSERT INTO `Comida`
	(`idComida`,`nomePrato`)
VALUES
	("1","Doce de batata doce"),
	("2","Churrasco"),
	("3","Bala de banana"),
	("4","Tapioca"),
	("5","Pizza assado no forno à lenha"),
	("6","Feijão tropeiro"),
	("7","Arroz carreteiro"),
	("8","Açaí na tijela"),
	("9","Paçoca de amendoim"),
	("10","Pato no tucupi"),
	("11","Maniçoba"),
	("12","Baião de dois"),
	("13","Acarajé"),
	("14","Pamonha"),
	("15","Dobradinha"),
	("16","Rapadura"),
	("17","Farofa de içá"),
	("18","Barreado"),
	("19","Pastel de feira"),
	("20","Couve refogada com alho"),
	("21","Sanduíche de pernil"),
	("22","Palmito"),
	("23","Umbu em natura"),
	("24","Camarão na moranga"),
	("25","Doce de abóbora"),
	("26","Feijoada"),
	("27","Galinhada com pequi"),
	("28","Peixe na telha"),
	("29","Biscoito de polvilho"),
	("30","Galinha à cabidela"),
	("31","Pão de mel com doce de leite"),
	("32","Peixe assado na folha de bananeira"),
	("33","Queijo coalho na brasa"),
	("34","Torta de liquidicador"),
	("35","Café coado no filtro de pano"),
	("36","Caldo de cana"),
	("37","Arroz, feijão, bife e batata frita"),
	("38","Buchada de bode"),
	("39","Bolo de rolo"),
	("40","Furrundum"),
	("41","Chá mate gelado e pastel"),
	("42","Rabada"),
	("43","Vaca atolada"),
	("44","Pitanga"),
	("45","Quibe"),
	("46","Pintando na brasa"),
	("47","Cuscuz paulista"),
	("48","Quebra queixo"),
	("49","Pingado de padaria"),
	("50","Quindim"),
	("51","Cajuzinho"),
	("52","Sorvete de milho"),
	("53","Sarapatel"),
	("54","Bolinho de chuva"),
	("55","Caruru"),
	("56","Frango com quiabo"),
	("57","Leitão à pururuca"),
	("58","Canjica doce"),
	("59","Pinhão"),
	("60","Vinho quente"),
	("61","Cachaça artesanal de qualidade"),
	("62","Pão de queijo"),
	("63","Caldeirada de tucunaré"),
	("64","Moqueca"),
	("65","Mandioca frita"),
	("66","Broa de fubá"),
	("67","Jaca em compota"),
	("68","Sonho de padaria"),
	("69","Sorvete de cupuaçu"),
	("70","Requeijão cremoso"),
	("71","Pimenta cumari inteira"),
	("72","Churrasco grego"),
	("73","Queijo de Minas fresco"),
	("74","Misto quente"),
	("75","Caldo de piranha"),
	("76","Doce de leite mineiro"),
	("77","Brigadeiro"),
	("78","Acerola suco"),
	("79","Bobó de camarão"),
	("80","Pudim de leite condensado"),
	("81","Manjar de coco"),
	("82","Refrigerante de guaraná"),
	("83","Coxinha"),
	("84","Caldo de mocotó"),
	("85","Romeu e Julieta"),
	("86","Chimarrão"),
	("87","Virado à Paulista"),
	("88","Jabuticaba no pé"),
	("89","Bala de coco de festa de aniversário"),
	("90","Bolinho de bacalhau"),
	("91","Beirute"),
	("92","Caldinho de feijão"),
	("93","Melão de Mossoró-RN"),
	("94","Milho assado"),
	("95","Batata doce assada"),
	("96","Caipirinha de cachaça"),
	("97","Geléia de mocotó"),
	("98","Caju castanha"),
	("99","Angú"),
	("100","Macarrão com carne moída"),
	("101","Macarrão com frango"),
	("102","Macarrão com requeijão"),
	("103","Lasanha de espinafre"),
	("104","Bolo de chocolate"),
	("105","Pé de Moleque"),
	("106","Broa de milho");

### TAB_CARRO.SQL ###

INSERT INTO `Carro`
	(`idCarro`,`nomeCarro`,`marcaCarro`)
VALUES
	("1","A3","Audi"),
	("2","A3 Sedan","Audi"),
	("3","Q3 ","Audi"),
	("4","TT","Audi"),
	("5","A1","Audi"),
	("6","R8","Audi"),
	("7","A4","Audi"),
	("8","A5","Audi"),
	("9","A6","Audi"),
	("10","A7","Audi"),
	("11","Q5","Audi"),
	("12","Q7","Audi"),
	("13","Senna","Audi");

### TAB_PESSOA.SQL ###

INSERT INTO `Pessoa`
	(`idPessoa`,`nome`,`dataNascimento`,`Localidade_idMapa`,`estadoCivil`,`Signo_signo`)
VALUES
	("1","Bruno","1996-11-2","67","solteiro","Escorpião"),
	("2","Roberta","1976-10-23","78","casado","Escorpião"),
	("3","Emanuelly","1976-5-13","33","divorciado","Touro"),
	("4","João Miguel","2000-3-13","86","casado","Peixes"),
	("5","Hortencia","2000-8-13","74","divorciado","Leão"),
	("6","Luisa","1986-6-26","47","casado","Câncer"),
	("7","Joana","2001-7-8","39","solteiro","Câncer"),
	("8","Clarisse","1991-9-20","28","solteiro","Virgem"),
	("9","Marco","1987-5-25","25","divorciado","Gêmeos"),
	("10","Bianca","1972-2-8","5","divorciado","Aquário");

### TAB_PESQUISA.SQL ###

INSERT INTO `Pesquisa`
	(`idPesquisa`,`Comida_idComida`,`Carro_idCarro`,`Frutas_idFrutas`,`Pessoa_idPessoa`)
VALUES
	("1","37","2","72","3"),
	("2","64","8","48","9"),
	("3","7","11","4","3"),
	("4","79","3","90","7"),
	("5","97","5","15","10"),
	("6","105","6","133","6"),
	("7","47","7","78","3"),
	("8","26","4","133","7"),
	("9","106","8","98","2"),
	("10","59","11","49","7");

##################################################
