-- Exemplos simples de queries no MySQL
-- Utiliz tabelas usadas no livro do Silberschatz, sexta edição.

-- criar novo banco de dados
create database db_University;

-- deletar banco de dados
drop db_University;

-- mostrar bancos de dados existente no server MySQL
show databases;

-- seleciona banco de dados
use db_University;

-- cria nova tabela no banco selecionado
create table if not exists department (
	dept_name varchar(20),
    building varchar(15),
    budget numeric(12, 2),
    primary key (dept_name)); -- define chave primária
	
create table if not exists course (
	course_id    varchar(7),
	title        varchar(50),
    dept_name    varchar(20),
    credits      numeric(2,0), -- número de ponto flutuante (numero de digitos, numero de casas decimais)
    primary key(course_id),
    foreign key (dept_name) references department(dept_name) -- atrela coluna à coluna de outra tabela
);

create table if not exists instructor (
	ID          varchar(5),
    name        varchar(20) not null, -- erro se campo for nulo
    dept_name   varchar(20),
	salary      numeric(8,2),
    primary key(ID),
    foreign key (dept_name) references department(dept_name)
);

create table if not exists section (
	course_id     varchar(8),
    sec_id        varchar(8),
    semester      varchar(6),
    year          numeric(4,0),
    building      varchar(15),
    room_number   varchar(7),
    time_slot_id  varchar(4),
    primary key (course_id, sec_id, semester, year), -- essa combinação deve ser única ou retornará erro
    foreign key (course_id) references course(course_id)
);

create table if not exists teaches (
	ID varchar(5),
    course_id varchar(8),
    sec_id varchar(8),
    semester varchar(6),
    year numeric(4,0),
    primary key(ID, course_id, sec_id, semester, year),
    foreign key(course_id, sec_id, semester, year) references section(course_id, sec_id, semester, year),
    foreign key (ID) references instructor(ID)
);

-- deleta tabela
drop table my_table

-- apaga todos os registros da tabela
delete from department;
truncate table department; -- reseta o auto_increment

-- modifica tabela
alter table instructor add column salary numeric(8,2); -- adiciona nova coluna
alter table instructor drop column salary; -- remove coluna
alter table instructor rename column salary to payment; -- renomeia coluna
alter table instructor rename to professor; -- renomeia tabela

-- insere 
-- insere registro/tupla numa tabela/relação
insert into department values("Comp. Eng.", "North", 350000);
insert into instructor(ID, name, dept_name, salary) values(10211, "Philippe", "Comp. Eng.", 77000);

-- mostra todos os itens 
select * from instructor;

-- mostra o nome de todos os instrutores
select name from instructor;
select distinct dept_name from instructor;

-- select usando operações aritméticas
select name, dept_name, salary*1.1 from instructor; 

-- select usando where
select name, salary from instructor where salary <= 50000;

-- select com duas tabelas conectdas por chave estrangeira
select name, instructor.dept_name, building
from  instructor, department
where instructor.dept_name = department.dept_name;

select 
	name, course_id
from 
	instructor, teaches
where 
	instructor.ID = teaches.ID and instructor.dept_name = 'Comp. Sci.';
	
-- natural join junta tabelas onde as colunas tem o mesmo nome
-- seria o mesmo que usar o select acima
select name, course_id from instructor natural join teaches;

-- aqui compara com uma terceira tabela usando prod. cartesiano
-- note que a comparação é executada DEPOIS do natural join
select name, title from instructor natural join teaches, course where teaches.course_id = course.course_id;

-- essa query é diferente, ir´levar em conta todas as colunas que são iguais.
select name, title
from instructor natural join teaches natural join course;

-- define expkicitamente as colunas no natural join
select name, title
from (instructor natural join teaches) join course using(course_id);

-- utiliza 'as' para renomear coluna durante uma consulta
select name as 'Nome', title as 'Título'
from (instructor natural join teaches) join course using(course_id);

-- outro exemplo do uso de AS:
select name, title 
from instructor 
natural join teaches as T, course as C where T.course_id = C.course_id;

-- utiliza wildcard para filtrar resultados
select dept_name from department where building like '%Watson%';

-- seleciona apenas atributos de uma tabela num join
select instructor.* from instructor, teaches where instructor.ID = teaches.ID;

-- ordena resultados
select name from instructor AS I, teaches AS T where I.ID = T.ID order by name;

-- ordena de forma descrescente
select * from instructor order by salary desc;
select * from instructor order by salary desc, name desc;

-- selectiona intervalos
select * from instructor where salary >= 20000 and salary <= 70000;
select * from instructor where salary between 40000 and 70000;

-- operação de união de conjuntos
(select course_id from section where semester = 'Fall' and year=2009) union
(select course_id from section where semester = 'Spring' and  year=2010);

-- união com tuplas duplicadas
(select course_id from section where semester = 'Fall' and year=2009) union all
(select course_id from section where semester = 'Spring' and  year=2010);

-- verifica registros com campos nulos
select * from instructor where salary is not null;

-- algumas funções prontas do MySQL
select avg(salary) from instructor; -- calcula média aritmética
select count(distinct ID) from instructor where dept_name = 'Comp. Sci.'; -- conta tuplas
select count(*) from teaches; -- conta todosos registros
select dept_name, avg(salary) from instructor group by dept_name;
select dept_name, avg(salary) from instructor group by dept_name having avg(salary) > 50000;

-- atualiza e deleta registro
insert into instructor values(1122, 'MS Barney', 'Biology', 66600);
update instructor set name = 'Prof. Aquaplay', salary = 250000 where name = 'MS Barney';
delete from instructor where name = 'Prof. Aquaplay';
