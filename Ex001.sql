/*
O nosso cliente solicitou uma tabela para armazenar os livros que são comercializados pela empresa.
A solicitação é somente para livros e não há a necessidade de realizar busca em outras tabelas.
Hoje há um funcionário de vendas que tem uma tabela do Excel para guardar esses registros, mas as buscas estão ficando complexas.
Decidiu-se então criar um banco de dados separado para esse funcionário.


Após a criação da tabela, deveremos entregar algumas queries prontas para que sejam enviadas para o programador.
As queries são as seguintes:

1 - Trazer todos os dados.
2 - Trazer o nome do livro e o nome da editora.
3 - Trazer o nome do livro e a UF dos livros publicados por autores do sexo masculino.
4 - Trazer o nome do livro e o número de páginas dos livros publicados por autores do sexo feminino.
5 - Trazer os valores dos livros das editoras de São Paulo.
6 - Trazer os dados dos autores do sexo masculino que tiveram livros publicados por São Paulo ou Rio de Janeiro.

*/


/* Sprit de criação do banco de dados e da tabela */

CREATE DATABASE LIVRARIA;

CREATE TABLE LIVROS(
	livro 	VARCHAR(100),
	autor   VARCHAR(100),
	sexo    CHAR(1),
	paginas INT(5),
	editora VARCHAR(30),
	valor   FLOAT(10,2),
	uf      CHAR(2),
	ano     INT(4)
);


/* Scrip de inserção de dados na tabela */

INSERT INTO LIVROS
VALUES 
  ('Cavaleiro Real', 'Ana Claudia', 'F', 465, 'Atlas', 49.9, 'RJ', 2009)
, ('SQL para leigos', 'João Nunes', 'M', 450, 'Addison', 98, 'SP', 2018)
, ('Receitas Caseiras', 'Celia Tavares', 'F', 210, 'Atlas', 45, 'RJ', 2008)
, ('Pessoas Efetivas', 'Eduardo Santos', 'M', 390, 'Beta', 78.99, 'RJ', 2018)
, ('Habitos Saudáveis', 'Eduardo Santos', 'M', 630, 'Beta', 150.98, 'RJ', 2019)
, ('A Casa Marrom', 'Hermes Macedo', 'M', 250, 'Bubba', 60, 'MG', 2016)
, ('Estacio Querido', 'Geraldo Francisco', 'M', 310, 'Insignia', 100, 'ES', 2015)
, ('Pra sempre amigas', 'Leda Silva', 'F', 510, 'Insignia', 78.98, 'ES', 2011)
, ('Copas Inesqueciveis', 'Marco Alcantara', 'M', 200, 'Larson', 130.98, 'RS', 2018)
, ('O poder da mente', 'Clara Mafra', 'F', 120, 'Continental', 56.58, 'RS', 2017);
	

/* Script de projeção */

SELECT * FROM LIVROS;

SELECT 
   livro, editora 
FROM 
   LIVROS;

/* Script de projeção e seleção */

SELECT 
   livro, uf 
FROM 
   LIVROS 
WHERE 
   sexo = 'M';



SELECT 
   livro, paginas 
FROM 
   LIVROS 
WHERE 
   sexo = 'F';
   
   
   
SELECT 
   valor 
FROM 
   LIVROS 
WHERE 
   uf = 'SP';
   
   
   
SELECT * FROM LIVROS 
WHERE 
   sexo = 'M' 
   AND (uf = 'SP' 
   OR uf = 'RJ');
