/*
Eduardo tem que criar um controle de cat�logo de um restaurante fastfood, onde s�o vendidos os lanches 
, bebidas e sobremesas que ser�o identificados como Itens. Eles tamb�m vendem os chamados combos que cont�m v�rios itens como um lanche,
uma bebida ou uma sobremesa.

Tanto os itens como os combos tem um pre�o determinado no cat�logo. 

Para representar o cat�logo, foi criada a tabela abaixo:

Os itens j� s�o identificados automaticamente com n�meros entre 1 e 100000 e os combos j� s�o identificados
automaticamente com n�meros entre 100001 e 200000 pela aplica��o.

Voce dever criar uma estrutura de tabela ou tabelas que permita montar uma composi��o de Combos a partir dos Itens.

Qual das op��es abaixo permite manter essa estrutura?



*/

drop table if exists catalogo
drop table if exists composicao 
go

Create Table Catalogo (
   id int not null,
   Titulo varchar(20) not null,
   Descricao varchar(100) not null,
   Preco smallmoney not null check (Preco > 0 ),
   Grupo char(10) not null default 'Item' check (Grupo in ('Item','Combo')),
   Constraint PKCatalogo Primary Key (id) 
)


insert into Catalogo (id,Titulo,Preco, Grupo , Descricao )
values (1,'Lanche A', 10.00, 'Item' , ''),
       (2,'Lanche B', 12.00, 'Item', ''),
       (3,'Lanche B', 14.00, 'Item', ''),
	   (4,'Suco 01' , 5.00 , 'Item', ''),
	   (5,'Suco 02' , 7.50 , 'Item', ''),
	   (6,'Sobremesa X', 7.00, 'Item', ''),
	   (7,'Sobremesa Y', 9.00, 'Item', '')

insert into Catalogo (id,Titulo,Preco, Grupo , Descricao)
values (100001,'Combo A', 20.00, 'Combo', ''),
       (100002,'Combo B', 25.00, 'Combo', ''),
       (100003,'Combo C', 24.00, 'Combo', ''),
	   (100004,'Combo D' ,15.00, 'Combo', '')


Select * from Catalogo





Create Table Composicao (
   id int not null,
   idCombo int not null check(idCombo > 10000),  
   idItem  int not null check (idItem < 10000),
   Validade datetime not null 
)
