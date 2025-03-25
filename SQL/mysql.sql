-- criar novo banco de dado
CREATE DATABASE IF NOT EXISTS db_Library;


-- listar bancos de dados no servidos MySql
SHOW DATABASES;


-- seleciona banco de dados criado no servidor
USE db_LIbrary;


-- verifica qual banco de dados está sendo utilizado
SELECT DATABASE();


-- deletar um banco de dados
DROP DATABASE IF EXISTS db_Boceta;

-- excluir tabela
DROP TABLE IF EXISTS tarefas;


-- mostra tabelas do banco selecionado
SHOW TABLES;


-- cria uma tabela no nosso banco de dados
CREATE TABLE IF NOT EXISTS tbl_Book (
	Book_id smallint AUTO_INCREMENT PRIMARY KEY,
	Book_name VARCHAR(50) NOT NULL,
	Book_ISBN VARCHAR(30) NOT NULL,
	Book_date_pub DATE NOT NULL,
	Book_prize decimal NOT NULL,
	Author_Id smallint NOT NULL
	);
	
CREATE TABLE IF NOT EXISTS tbl_Author (
	Author_id smallint AUTO_INCREMENT PRIMARY KEY,
	Author_name varchar(50) NOT NULL,
	Author_surname varchar(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS tbl_Publisher (
	Publisher_id smallint AUTO_INCREMENT PRIMARY KEY,
	Publisher_name varchar(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Purchase (
	Purchase_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
	Purchase_code VARCHAR(50),
	Purchase_date DATE,
	FOREIGN KEY (Product_code) REFERENCES Product(Product_code)
);
-- ---------------------------------------------------------------

-- teste com auto incremento
CREATE TABLE IF NOT EXISTS tbl_foods (
	id smallint AUTO_INCREMENT PRIMARY KEY,
	name varchar(50)
) AUTO_INCREMENT = 20;

INSERT INTO tbl_foods (name) VALUES('batata frita');
INSERT INTO tbl_foods (name) VALUES('hamburguer');
INSERT INTO tbl_foods (name) VALUES('pastel');
INSERT INTO tbl_foods (name) VALUES('pizza');

SELECT * FROM tbl_foods;
-- ---------------------------------------------------------------

-- seleciona o registro mais recente com base no id de auto incremento
SELECT MAX(Book_id) FROM tbl_Book;
SELECT MAX(id) FROM tbl_foods;
-- ---------------------------------------------------------------

-- alterar valor de incremento
ALTER TABLE tbl_foods AUTO_INCREMENT = 90;
INSERT INTO tbl_foods (name) VALUES('coxinha');
INSERT INTO tbl_foods (name) VALUES('coca-cola');
INSERT INTO tbl_foods (name) VALUES('sprite');
SELECT * FROM tbl_foods;

-- excluir uma coluna no banco de dados
USE db_LIbrary;
ALTER TABLE tbl_Book DROP COLUMN Author_id;
SELECT * FROM tbl_Book;
-- ---------------------------------------------------------------

-- adiciona uma coluna ao banco e referncia coluna de outra tabela
USE db_LIbrary;
ALTER TABLE tbl_Book ADD Author_id SMALLINT NOT NULL;
ALTER TABLE tbl_Book ADD CONSTRAINT Author_fk_id FOREIGN KEY(Author_id) REFERENCES tbl_Author(Author_id);
SELECT * FROM tbl_Book;
-- ---------------------------------------------------------------

-- criando relacionamento entre duas colunas de diferentes tabelas
ALTER TABLE tbl_Book ADD Publisher_id SMALLINT NOT NULL;
ALTER TABLE tbl_Book ADD CONSTRAINT Publisher_fk_id FOREIGN KEY(Publisher_id) REFERENCES tbl_Publisher(Publisher_id);
SELECT * FROM tbl_Book;
-- ---------------------------------------------------------------

-- alterar tipode dados de uma coluna
ALTER TABLE tbl_Book ALTER COLUMN Author_id SMALLINT;
-- ---------------------------------------------------------------

-- adicionar chave primária em coluna existente
ALTER TABLE tbl_Customers ADD PRIMARY KEY (Customer_id);
-- ---------------------------------------------------------------

-- inserindo dados numa tabela
INSERT INTO tbl_Author (Author_Id, Author_name, Author_surname) VALUES(1, 'James', 'Stewart');
INSERT INTO tbl_Author (Author_Id, Author_name, Author_surname) VALUES(2, 'Bjarne', 'Stroustrup');
INSERT INTO tbl_Author (Author_Id, Author_name, Author_surname) VALUES(3, 'Thomas', 'Cormen');
INSERT INTO tbl_Author (Author_Id, Author_name, Author_surname) VALUES(4, 'Martin', 'Fowler');
INSERT INTO tbl_Author (Author_Id, Author_name, Author_surname) VALUES(5, 'Matthew', 'Sadiku');
SELECT * FROM tbl_Author;

INSERT INTO tbl_Publisher (Publisher_name) Values('Cengage Learning');
INSERT INTO tbl_Publisher (Publisher_name) Values('MIT Press');
INSERT INTO tbl_Publisher (Publisher_name) Values('Addison-Wesley');
INSERT INTO tbl_Publisher (Publisher_name) Values('McGraw-Hill Education');
SELECT * FROM tbl_Publisher;

INSERT INTO tbl_Book (Book_name, Book_ISBN, Book_date_pub, Book_prize, Author_Id, Publisher_id) 
	VALUES('Programming: Principles and Practice Using C++', 0321992784, '20140525', 53.90, 2, 3);
	
INSERT INTO tbl_Book (Book_name, Book_ISBN, Book_date_pub, Book_prize, Author_Id, Publisher_id) 
	VALUES('Calculus', 1285740629, '20201110', 48.70, 1, 4);
	
INSERT INTO tbl_Book (Book_name, Book_ISBN, Book_date_pub, Book_prize, Author_Id, Publisher_id) 
	VALUES('Introduction to Algorithms', 1225733629, '20200608', 58.20, 3, 2);
	
INSERT INTO tbl_Book (Book_name, Book_ISBN, Book_date_pub, Book_prize, Author_Id, Publisher_id) 
	VALUES('Fundamentals of Electric Circuits', 1234746429, '20121110', 38.70, 5, 4);
	
SELECT * FROM tbl_Book;
-- ---------------------------------------------------------------

-- exemplos de consultas com SELECT
SELECT * FROM tbl_Book;
SELECT Author_name FROM tbl_Author;
SELECT Book_name, Book_date_pub, Book_prize FROM tbl_Book;
-- ---------------------------------------------------------------


-- exemplos de consultas com SELECT com ordem crescente e decrescente
SELECT Author_name FROM tbl_Author ORDER BY Author_name;
SELECT Author_name FROM tbl_Author ORDER BY Author_name DESC;
SELECT Book_name, Book_prize FROM tbl_Book ORDER BY Book_prize ASC;
SELECT Book_name, Book_prize FROM tbl_Book ORDER BY Book_prize DESC;
SELECT * FROM tbl_foods ORDER BY name ASC;
SELECT * FROM tbl_foods ORDER BY name DESC;
-- ---------------------------------------------------------------

-- exemplo de criação e exclusão de índices para otimizar performance de consulta no banco
SHOW INDEX FROM tbl_Publisher;

EXPLAIN SELECT * FROM tbl_Publisher WHERE Publisher_name = 'MIT Press'; -- mostra estatisticas sobre consultas, útil para otimização

CREATE INDEX idx_Publisher ON tbl_Publisher(Publisher_name); -- índices devem ser criado em colunas muito acessadas e NÃO alteradas;
-- ---------------------------------------------------------------


-- exemplos de filtros de consultas com WHERE
SELECT * FROM tbl_Book WHERE Book_prize < 50;
SELECT Author_name FROM tbl_Author WHERE Author_surname = 'Stewart';
SELECT Book_name, Book_ISBN, Book_date_pub, Book_Prize FROM tbl_book WHERE Publisher_Id = 4;
-- ---------------------------------------------------------------


-- filtro WHERE com operadores NOT, AND e NOT
SELECT * FROM tbl_Book WHERE Book_prize > 40 AND Book_date_pub > '20200101';
SELECT * FROM tbl_book WHERE Author_id = 1 OR Author_Id = 3;
SELECT * FROM tbl_book WHERE Author_id > 1 AND NOT Author_Id = 3;
SELECT * FROM tbl_author WHERE NOT AUthor_surname = 'Cormen';
-- ---------------------------------------------------------------


-- filtro WHERE com IN e OUT
SELECT * FROM tbl_book WHERE Author_id IN(1,3,5);
SELECT * FROM tbl_book WHERE Author_id NOT IN(1,3);
SELECT * FROM tbl_publisher WHERE publisher_id NOT IN(1,3);
SELECT * FROM tbl_book WHERE publisher_id IN(SELECT Publisher_id FROM tbl_publisher WHERE Publisher_name = 'MIT Press');
-- ---------------------------------------------------------------

-- excluir registro de uma determinada tabela
INSERT INTO tbl_Book (Book_name, Book_ISBN, Book_date_pub, Book_prize, Author_Id, Publisher_id) VALUES('50 shades of grey', '666666', '19960606', 1.66, 1, 1);
SELECT * FROM tbl_book;
-- ---------------------------------------------------------------

DELETE FROM tbl_Book WHERE Book_name = '50 shades of grey';
SELECT * FROM tbl_book;

DELETE FROM tbl_Author WHERE Author_id > 2;
SELECT * FROM tbl_Author;
-- ---------------------------------------------------------------


-- deleta todos os registrosde uma tabela, mas não a tabela em si
TRUNCATE TABLE tbl_foods;
-- ---------------------------------------------------------------


-- consulta tabela usando alias em uma coluna
SELECT Author_name AS Professor FROM tbl_Author;
SELECT Book_name AS Livro, Book_prize AS Preço FROM tbl_book AS Books;
-- ---------------------------------------------------------------


-- uso das funções de agregação para o cálculo de média, contagem, maximos, minimos, etc
SELECT COUNT(*) FROM tbl_Book; --retorna número de registro na tabela
SELECT COUNT(DISTINCT Publisher_id) FROM tbl_Book; --conta registro onde coluna especificada deve ser especifica (sem repetições)
SELECT MAX(Book_prize) FROM tbl_Book; --retorna maior item numérico 
SELECT MIN(Book_prize) FROM tbl_Book;
SELECT AVG(Book_prize) FROM tbl_Book; -- retorna média
SELECT SUM(Book_prize) FROM tbl_Book; -- retorna soma de todos os preços
-- ---------------------------------------------------------------

-- renomeia tabela
RENAME TABLE tlb_foods TO tbl_Food;
-- ---------------------------------------------------------------


-- atualizar dados de uma tabela
CREATE TABLE IF NOT EXISTS tbl_Fruit (
	Fruit_id SMALLINT AUTO_INCREMENT NOT NULL,
	Fruit_name VARCHAR(40) NOT NULL,
	CONSTRAINT PRIMARY KEY (Fruit_id)
);

INSERT INTO tbl_Fruit (Fruit_name) VALUES('Apple');
INSERT INTO tbl_Fruit (Fruit_name) VALUES('Pyneapple');
INSERT INTO tbl_Fruit (Fruit_name) VALUES('Starberry');
INSERT INTO tbl_Fruit (Fruit_name) VALUES('Piar');

SELECT * FROM tbl_Fruit;

UPDATE tbl_Fruit SET Fruit_name = 'Pineapple' WHERE Fruit_name = 'Pyneapple';
UPDATE tbl_Fruit SET Fruit_name = 'Strawberry' WHERE Fruit_name = 'Starberry';
UPDATE tbl_Fruit SET Fruit_name = 'Pear' WHERE Fruit_name = 'Piar';

UPDATE tbl_Book SET Book_name = 'Calculus Vol. 1' WHERE Book_id = 2;
SELECT * FROM tbl_Book;
-- ---------------------------------------------------------------


-- faz consulta com intervalos usando a clausula BETWEEN
SELECT * FROM tbl_Book WHERE Author_id BETWEEN 2 AND 4;
SELECT * FROM tbl_Book WHERE Book_prize BETWEEN 40 AND 50;
SELECT * FROM tbl_Book WHERE Book_date_pub BETWEEN '20120101' AND '20200101';
SELECT Book_name AS Nome, Book_prize AS Preço FROM tbl_Book WHERE Book_date_pub BETWEEN '20120101' AND '20200101';
-- ---------------------------------------------------------------


-- filtrando consultas com base em strings
SELECT * FROM tbl_Book WHERE Book_name LIKE 'F%'; --seleciona livro que começa com F
SELECT * FROM tbl_Book WHERE Book_name NOT LIKE 'C%'; --seleciona livro que não começa com C
SELECT * FROM tbl_author WHERE Author_name LIKE '_a%'; -- lista autores com segunda letra 'a' e ignorando a primeira letra 
SELECT * FROM tbl_author WHERE Author_name LIKE '%j%'; -- lista autores com letra j no nome
-- ---------------------------------------------------------------


-- filtrando dados com REGEX
SELECT * FROM tbl_Book WHERE Book_name REGEXP '^[FS]';
SELECT * FROM tbl_Book WHERE Book_name REGEXP '^[^FS]';
SELECT * FROM tbl_Book WHERE Book_name REGEXP '^[ng]$';
-- ---------------------------------------------------------------


-- define valor padrão para colunas
ALTER TABLE tbl_Author MODIFY COLUMN Author_surname VARCHAR(60) DEFAULT 'Smith' NOT NULL;
INSERT INTO tbl_Author(Author_name) VALUES('John');
ALTER TABLE tbl_Author MODIFY COLUMN Author_surname VARCHAR(60) NOT NULL; -- remove default
INSERT INTO tbl_Author(Author_name, Author_surname) VALUES('David', 'Copperfield');
SELECT * FROM tbl_author;
-- ---------------------------------------------------------------


-- realiza backup do banco
mysqldump -u root -p db_Library > C:\Users\User\Desktop\db_library.sql -- cria backup root é o usuário

 -- fazer restauração do db, para isso é necessário criar um banco vazio e transferir o conteúdo dobackup
 CREATE DATABASE IF NOT EXISTS db_library_backup;
 mysql -u root -p db_library_backup < C:\Users\User\Desktop\db_library.sql
-- ---------------------------------------------------------------


-- fazer consulta agrupada por coluna
CREATE TABLE Vendas (
ID Smallint Primary Key,
Nome_Vendedor Varchar(20),
Quantidade Int,
Produto Varchar(20),
Cidade Varchar(20)
);

INSERT INTO Vendas (ID, Nome_Vendedor, Quantidade, Produto, Cidade)
  VALUES
(10,'Jorge',1400,'Mouse','São Paulo'),
(12,'Tatiana',1220,'Teclado','São Paulo'),
(14,'Ana',1700,'Teclado','Rio de Janeiro'),
(15,'Rita',2120,'Webcam','Recife'),
(18,'Marcos',980,'Mouse','São Paulo'),
(19,'Carla',1120,'Webcam','Recife'),
(22,'Roberto',3145,'Mouse','São Paulo');

-- obtem a soma da quantidade total de mouses vendidos
SELECT SUM(Quantidade) AS TotalMouses FROM vendas WHERE Produto = 'Mouse';

-- obtem a soma da quantidade total de itens vendidos por cidade
SELECT Cidade, SUM(Quantidade) AS Total FROM vendas GROUP BY Cidade;

-- obtem a soma da quantidade total de itens vendidos por vendedor
SELECT Nome_Vendedor, SUM(Quantidade) AS Total FROM vendas GROUP BY Nome_Vendedor;

-- agrupa a quantidade de vendas por cidade
SELECT Cidade, COUNT(*) AS Total FROM vendas GROUP BY Cidade;

-- ---------------------------------------------------------------


-- filtrar consultas de agrupamentos com condições usando HAVING
SELECT Nome_Vendedor, SUM(Quantidade) AS Total FROM vendas GROUP BY Nome_Vendedor HAVING SUM(Quantidade) > 1500;
SELECT Cidade, SUM(Quantidade) AS Total FROM vendas GROUP BY Cidade HAVING SUM(Quantidade) > 3000;

SELECT Nome_Vendedor, SUM(Quantidade) AS TotalMice FROM vendas 
WHERE Produto = 'Mouse' GROUP BY Nome_Vendedor HAVING SUM(Quantidade) > 1000;
-- ---------------------------------------------------------------


-- criação de views (tabelas temporárias geradas por consulta)
CREATE VIEW vw_AuthorsBooks -- ALTER altera uma view existente
AS SELECT tbl_Book.Book_name AS Livro,
tbl_Author.Author_name AS Autor
FROM tbl_Book
INNER JOIN tbl_Author
ON tbl_Book.Book_id = tbl_Author.Author_id;

-- ALTER altera uma view existente
ALTER VIEW vw_AuthorsBooks 
AS SELECT tbl_Book.Book_name AS Livro,
tbl_Author.Author_name AS Autor,
tbl_Author.Author_surname AS Sobrenome,
tbl_Book.Book_Prize AS Preço
FROM tbl_Book
INNER JOIN tbl_Author
ON tbl_Book.Book_id = tbl_Author.Author_id;

SELECT * FROM vw_authorsbooks;

-- excluir uma visão
DROP VIEW vw_authorsbooks;
-- ---------------------------------------------------------------


-- cnsultar dados de tabelas relacionadas com INNER JOIN
SELECT * FROM tbl_Book INNER JOIN tbl_Author ON tbl_Book.Author_id = tbl_Author.Author_id;
SELECT Book_name, Author_name, Author_surname FROM tbl_Book INNER JOIN tbl_Author ON tbl_Book.Author_id = tbl_Author.Author_id;

SELECT Book_name AS Livro, Author_surname AS Autor FROM tbl_book AS B
 INNER JOIN tbl_author AS A ON B.Author_id = A.Author_id
 WHERE A.Author_surname LIKE 'S%';
 
 -- três tabelas
SELECT Book_name AS Livro, Author_surname AS Autor, Publisher_name AS Editora
FROM tbl_book AS B
INNER JOIN tbl_author AS A ON B.Author_id = A.Author_id
INNER JOIN tbl_Publisher AS P ON B.Publisher_id = P.Publisher_id;

SELECT Book_name AS Livro, Author_surname AS Autor, Publisher_name AS Editora
FROM tbl_book AS B
INNER JOIN tbl_author AS A ON B.Author_id = A.Author_id
INNER JOIN tbl_Publisher AS P ON B.Publisher_id = P.Publisher_id
WHERE P.Publisher_name = 'McGraw-Hill Education';

-- ---------------------------------------------------------------

-- executando consultas com OUTER JOIN, retorna registros mesmo sem ter correspondente
SELECT * FROM tbl_Author 
LEFT JOIN tbl_Book
ON tbl_Book.Author_id = tbl_Author.Author_id;

-- verifica autores que nao publicaram livros
SELECT * FROM tbl_Author 
LEFT JOIN tbl_Book
ON tbl_Book.Author_id = tbl_Author.Author_id
WHERE tbl_book.Author_id IS NULL;

-- faz a mesma operação mas com a tabela da direita
INSERT INTO tbl_Publisher(Publisher_name) VALUES('MIT Press');

SELECT * FROM tbl_Book
RIGHT JOIN tbl_Publisher
ON tbl_Book.Publisher_id = tbl_Publisher.Publisher_id;

SELECT * FROM tbl_Book
RIGHT JOIN tbl_Publisher
ON tbl_Book.Publisher_id = tbl_Publisher.Publisher_id
WHERE tbl_book.Author_id IS NULL;
-- ---------------------------------------------------------------

-- concatenando textos em consultas
SELECT CONCAT('Philippe', 'Matias') AS 'Meu_nome';

SELECT CONCAT(Author_name, ' ', Author_surname) AS 'Autor' FROM tbl_Author;

SELECT CONCAT('Eu gosto do livro', ' \'', Book_name, '\'') AS 'Livro'
 FROM tbl_book WHERE MOD(Book_id, 2) = 0;
-- ---------------------------------------------------------------

-- verificando se registro na tbela é nulo
CREATE TABLE teste_nulos (
id smallint PRIMARY KEY auto_increment,
item varchar(20),
quantidade smallint NULL);

INSERT INTO teste_nulos (id, item, quantidade)
VALUES (1, 'Pendrive', 5);
INSERT INTO teste_nulos (id, item, quantidade)
VALUES (2, 'Monitor', 7);
INSERT INTO teste_nulos (id, item, quantidade)
VALUES (3, 'Teclado', NULL);

SELECT * FROM teste_nulos;

SELECT CONCAT('A quantidade adquirida é ', ' ', quantidade)
FROM teste_nulos
WHERE  item = 'Teclado';

SELECT CONCAT('A quantidade adquirida é ', ' ', IFNULL(quantidade, 0))
FROM teste_nulos
WHERE  item = 'Teclado';

SELECT CONCAT('A quantidade adquirida é ', ' ', COALESCE(NULL, quantidade, NULL, 0))
FROM teste_nulos
WHERE  item = 'Monitor';
-- ---------------------------------------------------------------

-- funções matemáticas no sql
SELECT (2 + 2 - 1);
SELECT (2 * 3 + 5) /2;
SELECT 3 DIV 2;
SELECT 3 MOD 2;
SELECT 10/3;

SELECT CEILING(10/3); -- arredonda pra cima
SELECT FLOOR(10/3); -- arredonda pra baixo
SELECT POW(2, 3);
SELECT SQRT(49);
SELECT SIN(PI()/2);
SELECT HEX(255);

SELECT Book_Name AS 'Livro', Book_prize * 5
AS 'Preço de 5 unidades' FROM tbl_Book;

SELECT Book_Name AS 'Livro', Book_prize / 2
AS 'Preço com 50% de desconto' FROM tbl_Book;
-- ---------------------------------------------------------------


-- funções e procedimentos
-- criando a função
CREATE FUNCTION fn_soma (a DECIMAL(10, 2), b INT)
RETURNS DECIMAL(10, 2)
RETURN a + b;

CREATE FUNCTION fn_mul (a DECIMAL(10, 2), b INT)
RETURNS DECIMAL(10, 2)
RETURN a * b;

-- invocando a função
SELECT fn_soma(20.25, 2) AS 'resultado';

SELECT Book_name AS 'Livro', fn_mul(Book_prize, 2) AS 'Dobro do preço' FROM tbl_Book;

-- excluir uma função
DROP FUNCTION fn_soma;
-- ---------------------------------------------------------------


-- stored procedures/procedimentos armazenados
CREATE PROCEDURE pcd_DisplayPrice (varBook SMALLINT)
SELECT Book_name, CONCAT('O preço é ', Book_prize) AS 'Preço' 
FROM tbl_book WHERE Book_id = varBook;

CALL pcd_DisplayPrice(3);

DROP PROCEDURE pcd_DisplayPrice;
-- ---------------------------------------------------------------


-- stored procedures e funçõescom blocos BEGIN/END
DELIMITER $$
CREATE FUNCTION IF NOT EXISTS aumenta_preco (preco DECIMAL(10, 2), taxa DECIMAL(10, 2)) RETURNS DECIMAL(10, 2)
BEGIN
	RETURN preco + preco * taxa / 100;
END$$
DELIMITER ;

SELECT aumenta_preco(30, 10) AS 'Preço';


DELIMITER //
CREATE PROCEDURE IF NOT EXISTS showPrice (idBook SMALLINT)
BEGIN
	SELECT Book_name AS 'Livro' FROM tbl_Book WHERE Book_id = idbook;
END//
DELIMITER ;

CALL showPrice(2);
-- ---------------------------------------------------------------


-- usando parametros IN, OUT e INOUT em funtions e stored procedures
-- parametro IN faz a variável associada se perder e passa por valor
-- OUT passa por referência e é NULL por default
-- INOUT passa por referencia mas não nula
DELIMITER //

CREATE PROCEDURE IF NOT EXISTS showBookAuthor(IN authorSurname VARCHAR(60))
BEGIN
	SELECT Book_name AS 'Livro', CONCAT(Author_name, ' ', Author_surname) AS Author
	FROM tbl_book INNER JOIN tbl_author ON tbl_book.Author_id = tbl_author.Author_id
	WHERE tbl_Author.Author_surname = authorSurname;
END//

DELIMITER ;


SET @sname = 'Sadiku';
CALL showBookAuthor(@sname);


DELIMITER //

CREATE PROCEDURE IF NOT EXISTS increasePrice(IN id INT, rate DECIMAL(10, 2))
BEGIN
	UPDATE tbl_book 
	SET Book_Prize = tbl_book.Book_prize + tbl_book.Book_prize * rate/100.0
	WHERE Book_id = id;
END//

DELIMITER ;

SET @book = 2;
SET @increase = 10;

SELECT * FROM tbl_book WHERE Book_id = @book;

CALL increasePrice(@book, @increase);

SELECT * FROM tbl_book WHERE Book_id = @book;
-- ---------------------------------------------------------------


-- usando parametro OUT para capturar valores para variáveis
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS test_out(IN id INT, OUT book VARCHAR(50))
BEGIN
	SELECT Book_name
	INTO book
	FROM tbl_Book
	WHERE Book_id = id;
END//
DELIMITER ;

CALL test_out(3, @mybook);
SELECT @mybook AS 'Meu livro';

-- INOUT é como se fosse referencia do c++ e OUT a mesma coisa só que a variável é criada dentro de uma procedure

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS triplica(INOUT num INT)
BEGIN
	SET num = num * 3;
END//
DELIMITER ;

SET @numero = 3;
SELECT @numero;

CALL triplica(@numero);
SELECT @numero;
-- ---------------------------------------------------------------


-- declara função com variável de escopo local
DELIMITER $$
CREATE FUNCTION IF NOT EXISTS calcula_desconto (livro SMALLINT, desconto DECIMAL(10, 2)) RETURNS DECIMAL(10, 2)
BEGIN
	DECLARE preco DECIMAL(10, 2);	
	SELECT Book_prize FROM tbl_Book WHERE Book_id = livro INTO preco;
	RETURN preco - desconto;
END$$
DELIMITER ;

SELECT * FROM tbl_Book WHERE Book_id = 2;
SELECT calcula_desconto(4, 10.00);
SELECT * FROM tbl_Book WHERE Book_id = 2;
-- ---------------------------------------------------------------

-- exibindo metadados com comandos DESCRIBE, SHOW e mysqlshow
mysql -u root -p -- loga no db
HELP SHOW/help contents -- lista comandos disponíveis
SHOW DATABASES; -- lista bancos de dados
USE db_Library; --seleciona db
SHOW TABLES; --losta tabelas do banco selecionado
SHOW CREATE TABLE tbl_Book; -- exibe código usado para criar tabela
SHOW CREATE PROCEDURE pcd_displayPrice; -- exibe código usado para criar procedure
SHOW CREATE FUNCTION my_function; -- exibe código usado para criar função
SHOW [FULL] COLUMNS FROM tbl_Author [LIKE 'i%']; -- mostra informações sobre coluna numa tbla
SHOW COLUMNS FROM tbl_Author WHERE Type LIKE 'varchar%'; -- mostra informações sobre coluna numa tbla

SHOW GRANTS FOR root@localhost; -- exibe privilegios de usr do db

DESCRIBE tbl_Publisher;
DESC tbl_Book;
quit - sai do mysel
-- ---------------------------------------------------------------


-- o uso de triggers, que é uma função que é executada antes ou depois de uma operação no banco
CREATE TABLE IF NOT EXISTS tbl_Product (
Product_id SMALLINT AUTO_INCREMENT NOT NULL,
Product_name VARCHAR(45) NULL,
Product_price DECIMAL(10,2) NULL,
Product_price_discount DECIMAL(10,2) NULL,
PRIMARY KEY(Product_id));

CREATE TRIGGER IF NOT EXISTS tr_discount BEFORE|AFTER INSERT|UPDATE|DELETE
ON tbl_Product
FOR EACH ROW
SET NEW.Product_price_discount = (NEW.Product_price * 0.9); -- new é usado para valores que ainda não existem!

INSERT INTO tbl_Product(Product_name, Product_price) VALUES('video card', 299);
INSERT INTO tbl_Product(Product_name, Product_price) VALUES('headset', 26);
INSERT INTO tbl_Product(Product_name, Product_price) VALUES('OLED screen', 399);
INSERT INTO tbl_Product(Product_name, Product_price) VALUES('mechanical keyboard', 59);

SELECT * FROM tbl_Product;
-- ---------------------------------------------------------------


-- operações sql para gerenciar usuários
-- ver usuários cadastrads
SELECT User FROM Mysql.User;
SELECT User, Host FROM Mysql.User;

-- criar novo usuário
CREATE USER spike@localhost IDENTIFIED BY '4321'; -- para acessar banco de forma remota, não ponha @localhost

-- definir senha
SET PASSWORD FOR 'spike'@'localhost' = PASSWORD('kakaka');

-- renomear usuário
RENAME USER 'spike' TO 'mike';

-- excluir usuário
DROP USER spike;
-- ---------------------------------------------------------------

-- configurar permissões de usuários banco de dados
mysql -u root -p -- loga no mysql
SHOW GRANTS FOR spike@localhost; --mostra permissões de acesso
GRANT USAGE|ALL ON *.* TO mel@localhost IDENTIFIED BY '22234';
GRANT USAGE|ALL ON *.* TO Aleyna IDENTIFIED BY '22234' WITH GRANT OPTION;
GRANT SELECT (Book_name), INSERT(Book_name) ON db_Library TO spike@localhost.com;
REVOKE SELECT (Book_name), INSERT(Book_name) ON db_Library FROM spike@localhost.com;
REVOKE DELETE ON *.db_Library FROM spike@localhost;
REVOKE ALL GRANT OPTION FROM Aleyna, spike@localhost;
-- ---------------------------------------------------------------