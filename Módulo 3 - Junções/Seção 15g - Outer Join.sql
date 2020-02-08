/*

OUTER JOIN (Jun��o Externa) 

- OUTER JOIN foi definido somente no ANSI-92.
 
  No Padr�o ANSI-89

  From TabelaA, TabelaB
  Where TabelaA.ID *= TabelaB.ID

- O OUTER JOIN realiza tr�s fases de processamento l�gico.

- A primeira fase � o produto cartesiano entre as duas tabelas. Temos um 
  resultado que s�o todas as linhas e colunas. 

- A segunda fase � o filtro de linha entre as duas tabelas. 
  O resultado � as linhas internas entre as duas tabelas. 
  At� esse ponto o comportamento � igual ao JOIN (INNER JOIN). 

- A terceira fase de processamento � a inclus�o no resultado do 
  JOIN das linhas de uma das tabelas cuja a compara��o do filtro 
  de linha � falsa ou desconhecida.
 
- Mas qual das tabelas do OUTER JOIN ser� considerada para inclus�o 
  dessas linhas que n�o foram processadas na segunda fase? 

- O OUTER JOIN permite que voc� especifique qual tabela do JOIN ser� 
  considerada para a inclus�o de linhas externas. 
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
2. Fase do JOIN - Obter as linhas internas a jun��o.
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
3. Fase do JOIN - Obter as linhas externas da jun��o. Qual tabela?
*/

Select Montadora.id, 
       Montadora.Nome  , 
	   Carro.id , 
	   Carro.Modelo , 
	   Carro.idMontadora
  From Montadora 
  Left Outer Join Carro
    on Montadora.id = Carro.idMontadora





