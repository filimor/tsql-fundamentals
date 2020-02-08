/*

FULL OUTER JOIN 

- FULL OUTER JOIN preserva as linhas da DUAS tabelas  
  do JOIN quando a condição do filtro é falsa ou desconhecida 
  para o lado esquerdo ou direito da junção 

- Exemplos. 
   
  FROM Tabela1 
  FULL OUTER JOIN Tabela2 
    ON Tabela1.ColunaA = Tabela2.ColunaA 
  
  (1) Ocorre o produto cartesiano entre Tabela1 e Tabela2 ;
  (2) Ocorre o filtro de linhas entre Tabela1 e Tabela2 (o resultado vou chamar de V1) ;
  (3) Ocorre a inclusão das linhas de Tabela1 e da Tabela2  
      que não satisfazem a condição do filtro de linhas 
  (4) Os dados são enviados para a próxima fase. 

*/

/*
Exemplo 
*/

use DBExemplo
go

drop table if exists dbo.Carro 
go


drop table if exists dbo.Estado 
go

Create Table dbo.Estado (
id int not null primary key,
Nome char(20),
Sigla char(2) )

insert into dbo.Estado (id,Nome,Sigla) values (1,'São Paulo','SP'),(2,'Rio de Janeiro','RJ'),
                                              (3,'Minas Gerais','MG'),(4,'Roraima','RR')


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
idMontadora int foreign key references Montadora(id) ,
idEstado int foreign key references Estado(id)
)
go

insert into dbo.Carro values (1,'Uno',1,3) ,(2,'Onix',3,1)  ,(3,'KA',2,2),
                             (4,'Mobi',1,3),(5,'Prisma',3,1),(6,'Fiesta',2,2),
							 (4,'Argo',1,null),(5,'Equinox',3,null),(6,'Focus',2,null)



select * from dbo.Montadora order by id 
select * from dbo.Carro order by idMontadora
select * from dbo.Estado order by id 


Select *
  From Carro 
  Full Join Estado 
    On Carro.idEstado = Estado.id


Select *
  From Montadora 
  left join Carro 
    on Montadora.id = Carro.idMontadora 
  Full Outer Join Estado 
    On Carro.idEstado = Estado.id


