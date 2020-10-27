CREATE DATABASE exerciciolivraria
GO
USE exerciciolivraria

CREATE TABLE livro(
codigo_livro        INT				NOT NULL,
nome				VARCHAR(100)	NULL,
lingua				VARCHAR(50)		NULL,
ano					INT				NULL
PRIMARY KEY(codigo_livro)
)

CREATE TABLE edicoes(
isbn				INT				NOT NULL,
preco				DECIMAL(7,2)	NULL,
ano					INT				NULL,
num_paginas			INT				NULL,		
qtd_estoque			INT				NULL
PRIMARY KEY(isbn)
)

CREATE TABLE autor(
codigo_autor		INT				NOT NULL,
nome				VARCHAR(100)    NULL,
dt_nasc				DATE			NULL,
pais				VARCHAR(50)		NULL,
biografia			VARCHAR(Max)	NULL
PRIMARY KEY(codigo_autor)
)

CREATE TABLE editora(
codigo_editora		INT				NOT NULL,
nome				VARCHAR(50)     NULL,
logradouro			VARCHAR(255)	NULL,
numero				INT				NULL,
cep					CHAR(8)			NULL,
telefone			CHAR(11)		NULL
PRIMARY KEY(codigo_editora)
)

CREATE TABLE livro_autor (
livrocodigo_livro	INT NOT NULL,
autorcodigo_autor INT NOT NULL,
PRIMARY KEY(livrocodigo_livro, autorcodigo_autor),
FOREIGN KEY(autorcodigo_autor) REFERENCES autor(codigo_autor),
FOREIGN KEY (livrocodigo_livro) REFERENCES livro(codigo_livro)
)

CREATE TABLE livro_edicoes_editora(
edicoesisbn	INT NOT NULL,
editoracodigo_editora	INT NOT NULL,
livrocodigo_livro INT NOT NULL,
PRIMARY KEY (edicoesisbn, editoracodigo_editora, livrocodigo_livro),
FOREIGN KEY (edicoesisbn) REFERENCES edicoes(isbn),
FOREIGN KEY (editoracodigo_editora) REFERENCES editora(codigo_editora),
FOREIGN KEY(livrocodigo_livro) REFERENCES livro(codigo_livro)
)

EXEC sp_help autor
EXEC sp_help edicoes
EXEC sp_help editora
EXEC sp_help livro
EXEC sp_help livro_autor
EXEC sp_help livro_edicoes_editora


SELECT * FROM edicoes

SELECT * FROM autor

SELECT * FROM editora

SELECT * FROM livro

SELECT * FROM livro_autor

SELECT * FROM livro_edicoes_editora





EXEC sp_rename 'dbo.edicoes.ano', 'AnoEdicao', 'COLUMN'



ALTER TABLE editora
ALTER COLUMN nome VARCHAR(30) NULL


ALTER TABLE autor
DROP COLUMN dt_nasc 

ALTER TABLE autor
ADD ano INT NULL

INSERT INTO livro(codigo_livro,nome,lingua,ano)
VALUES
(1001,'CCNA 4.1','PT-BR',2015),
(1002,'HTML 5','PT-BR',2017),
(1003,'Redes de Computadores','EN',2010),
(1004,'Android em Ação','PT-BR',2018)

INSERT INTO autor(codigo_autor,nome,ano,pais,biografia)
VALUES
(10001,'Inácio da Silva',1975,'Brasil','Programador WEB desde 1995'),
(10002,'Andrew Tannenbaum',1944,'EUA','Chefe do Departamento de Sistemas de Computação da Universidade de Vrij'),
(10003,'Luis Rocha',1967,'Brasil','Programador Mobile desde 2000'),
(10004,'David Halliday',1916,'EUA','Físico PH.D desde 1941')

INSERT INTO livro_autor
VALUES
(1001,10001),
(1002,10003),
(1003,10002),
(1004,10003)

INSERT INTO edicoes
VALUES(0130661023,189.99,2018,653,10)


-- CORREÇÃO DO NOME DA UNIVERSIDADE DE VRIJ PARA VRIJE
UPDATE autor
SET biografia = 'Chefe do Departamento de Sistemas de Computação da Universidade de Vrije'
WHERE codigo_autor = 10002

--VENDA DE DUAS UNIDADES, RETIRAR 2 DO ESTOQUE
UPDATE edicoes
SET qtd_estoque = qtd_estoque - 2
WHERE ISBN = 0130661023

--APAGAR DAVID HALLIDAY DA TABELA
DELETE autor
WHERE codigo_autor = 10004
SELECT * FROM autor