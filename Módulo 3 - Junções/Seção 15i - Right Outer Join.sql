/*

RIGHT OUTER JOIN 

- RIGHT OUTER JOIN preserva as linhas da tabelas a direita  
  do JOIN quando a condi��o do filtro � falsa ou desconhecida. 

- Exemplos. 
   
  FROM Tabela1 
  RIGHT OUTER JOIN Tabela2 
    ON Tabela1.ColunaA = Tabela2.ColunaA 
  
  (1) Ocorre o produto cartesiano entre Tabela1 e Tabela2 ;
  (2) Ocorre o filtro de linhas entre Tabela1 e Tabela2 (o resultado vou chamar de V1) ;
  (3) Ocorre a inclus�o das linhas de Tabela1 (RIGHT TABLE) 
      que n�o satisfazem a condi��o do filtro de linhas 
  (4) Os dados s�o enviados para a pr�xima fase. 

- Pela minha experi�ncia na programa��o e consultoria, o uso do RIGHT JOIN e bem 
  menor que o uso do LEFT JOIN. Se voc� tem duas tabelas para fazer um OUTER JOIN,
  a pr�tica sempre levar� ao LEFT JOIN. 

*/

/*
Exemplo 
*/

use DBExemplo
go

drop table if exists dbo.Carro 
go

drop table if exists dbo.Montadora 
go

Create Table dbo.Montadora (
id int not null primary key ,
Nome varchar(20) not null)
go

insert into dbo.Montadora values (1,'Fiat'),(2,'Ford'),(3,'GM') , (4,'VW')
go

Create Table dbo.Carro(
id int not null,
Modelo varchar(20) not null,
idMontadora int foreign key references Montadora(id) )
go

insert into dbo.Carro values (1,'Uno',1),(2,'Onix',3),(3,'KA',2),(4,'Mobi',1),(5,'Prisma',3),(6,'Fiesta',2)

select * from dbo.Montadora order by id 
select * from dbo.Carro order by idMontadora

Select Montadora.*  , 
       Carro.*  
  From Montadora 
  Left Join Carro
    On Montadora.id = carro.idMontadora
 Order by Montadora.id


Select Montadora.*  ,Carro.* 
  From Carro
  Right Join Montadora 
    On Montadora.id = carro.idMontadora
 Order by Montadora.id


/*
Agora vamos imaginar um cen�rio abaixo:

Temos o cadastro de montadora, onde cada montadora tem um carro ou v�rios carros. 
E temos tamb�m um cadastro de estados indicando onde os carros s�o fabricados.

*/
use DBExemplo
go

drop table if exists dbo.Estado 
go

Create Table dbo.Estado 
(
   id int not null primary key,
   Nome char(20),
   Sigla char(2) 
)

insert into dbo.Estado (id,Nome,Sigla) values (1,'S�o Paulo','SP'),(2,'Rio de Janeiro','RJ'),
                                              (3,'Minas Gerais','MG'),(4,'Roraima','RR')

Select * from dbo.Estado
											  

drop table if exists dbo.Carro 
go

Create Table dbo.Carro(
   id int not null,
   Modelo varchar(20) not null,
   idMontadora int foreign key references Montadora(id) ,
   idEstado int foreign key references Estado(id)
)
go

insert into dbo.Carro values (1,'Uno',1,3),(2,'Onix',3,1),(3,'KA',2,2),(4,'Mobi',1,3),(5,'Prisma',3,1),(6,'Fiesta',2,2)

select * from dbo.Montadora order by id 
select * from dbo.Estado order by id 
select * from dbo.Carro order by idMontadora


-- 
Select Montadora.* , 
       Carro.* , 
	   Estado.*  
  From Montadora
  Join Carro 
    on Montadora.id = Carro.idMontadora
 Right Join Estado 
    on Carro.idEstado = Estado.id 


Select Montadora.* , 
       Carro.* , 
	   Estado.*   
  From Estado 
  Left Join Carro 
    on Carro.idEstado = Estado.id 
   Join Montadora 
    on Montadora.id = Carro.idMontadora



