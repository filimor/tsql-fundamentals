/*

OUTER JOIN (Junção Externa) 

- OUTER JOIN foi definido somente no ANSI-92.
 
  No Padrão ANSI-89

  From TabelaA, TabelaB
  Where TabelaA.ID *= TabelaB.ID

- O OUTER JOIN realiza três fases de processamento lógico.

- A primeira fase é o produto cartesiano entre as duas tabelas. Temos um 
  resultado que são todas as linhas e colunas. 

- A segunda fase é o filtro de linha entre as duas tabelas. 
  O resultado é as linhas internas entre as duas tabelas. 
  Até esse ponto o comportamento é igual ao JOIN (INNER JOIN). 

- A terceira fase de processamento é a inclusão no resultado do 
  JOIN das linhas de uma das tabelas cuja a comparação do filtro 
  de linha é falsa ou desconhecida.
 
- Mas qual das tabelas do OUTER JOIN será considerada para inclusão 
  dessas linhas que não foram processadas na segunda fase? 

- O OUTER JOIN permite que você especifique qual tabela do JOIN será 
  considerada para a inclusão de linhas externas. 
  A tabela a esquerda (LEFT), a tabela a direita (RIGHT) 
  ou as duas tabelas (FULL).

- Vamos entender antes a proposta e depois vamos para cada aula. 

*/

use DBExemplo
go

drop table if exists dbo.Carro 
go

drop table if exists dbo.Montadora 
go

Create Table dbo.Montadora 
(
   id int not null primary key ,
   Nome varchar(20) not null
)
go

insert into dbo.Montadora values (1,'Fiat'),(2,'Ford'),(3,'GM') , (4,'VW')
go

Create Table dbo.Carro
(
   id int not null,
   Modelo varchar(20) not null,
   idMontadora int foreign key references Montadora(id) 
)
go

insert into dbo.Carro values (1,'Uno',1),(2,'Onix',3),(3,'KA',2),
                             (4,'Mobi',1),(5,'Prisma',3),(6,'Fiesta',2)

select * from dbo.Montadora order by id 
select * from dbo.Carro order by idMontadora

Select Montadora.id, 
       Montadora.Nome  , 
	   Carro.id , 
	   Carro.Modelo , 
	   Carro.idMontadora
  From Montadora 
  Join Carro
    on Montadora.id = Carro.idMontadora


/*
1. Fase do JOIN - Realizar o CROSS JOIN 
*/


Select Montadora.id, 
       Montadora.Nome  , 
	   Carro.id , 
	   Carro.Modelo , 
	   Carro.idMontadora
  From Montadora 
  Cross Join Carro


/*
2. Fase do JOIN - Obter as linhas internas a junção.
*/


Select Montadora.id, 
       Montadora.Nome  , 
	   Carro.id , 
	   Carro.Modelo , 
	   Carro.idMontadora
  From Montadora 
  Join Carro
  on Montadora.id = Carro.idMontadora
  

/*
3. Fase do JOIN - Obter as linhas externas da junção. Qual tabela?
*/

Select Montadora.id, 
       Montadora.Nome  , 
	   Carro.id , 
	   Carro.Modelo , 
	   Carro.idMontadora
  From Montadora 
  Left Outer Join Carro
    on Montadora.id = Carro.idMontadora





