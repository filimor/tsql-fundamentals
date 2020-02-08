/*

INNER JOIN  (Jun��o Interna) 

- Realiza uma opera��o de jun��o vertical ou jun��o de colunas
  de duas tabelas atrav�s de compara��o entre as colunas.

- 2 fases de processamento l�gico, que � o produto cartesiano 
  entre as duas tabelas e filtra as linhas com o predicado entre as 
  duas tabelas.

- O filtro aplicado com o predicado associada as linhas da tabela a
  esquerda do JOIN com as linhas da tabela a direta do JOIN. Lembrando que como 
  estamos falando de 

  FROM Tabela1 INNER JOIN Tabela2 
    ON Tabela1.Coluna1 = Tabela2.Coluna2 

- Acima voc� pode perceber que temos um predicado formado por duas 
  express�es e um operador de compara��o. Ent�o temos um operador de compara��o que 
  realizar� a jun��o de duas tabelas usando em comum os valores id�nticos 
  de duas colunas.  

- Se a condi��o for verdadeira, as linhas da jun��o ser�o enviadas para pr�xima
  fase do comando. 
  Essas linhas s�o conhecidas como linhas internas da jun��o.

- Geralmente e como uma boa pr�tica, as colunas envolvidas no filtro de linhas
  s�o as Chave Prim�rias (PK) com as Chaves Estrangeiras (FK) 
	
- SQL Server suporta duas sintaxe do INNER JOIN. 
  O padr�o ANSI92 e ANSI89.

- Um dos tipos de JOIN mais utilizados, 
  tamb�m conhecido como Join equivalente (Equi Join).

 
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

insert into dbo.Montadora values (1,'Fiat'),(2,'Ford'),(3,'GM')
go

Create Table dbo.Carro(
id int not null,
Modelo varchar(20) not null,
idMontadora int foreign key references Montadora(id) )
go

insert into dbo.Carro values (1,'Uno',1),(2,'Onix',3),(3,'KA',2),(4,'Mobi',1),(5,'Prisma',3),(6,'Fiesta',2)

select * from dbo.Montadora
select * from dbo.Carro

select * 
  From Montadora 
 Inner join Carro
    on Montadora.id = Carro.idMontadora
 Order by Montadora.id


/*
Formato ANSI-92
*/

Select * 
  from Montadora 
 Inner Join Carro
    on Montadora.id = Carro.idMontadora
     
-- De qual tabela pertece a coluna id?

Select id, Nome  , id , Modelo , idMontadora
  From Montadora 
 Inner Join Carro
    on id = idMontadora


-- Por isso que utilizamos o alias para o nome da tabelas.
Select Montadora.id, Montadora.Nome  , Carro.id , Carro.Modelo , Carro.idMontadora
  From Montadora 
 Inner Join Carro
    on Montadora.id = idMontadora
  

--------------------------------------------
-- Formato simplificado : INNER JOIN = JOIN 

Select Montadora.id, 
       Montadora.Nome  , 
	   Carro.id , 
	   Carro.Modelo , 
	   Carro.idMontadora
  From Montadora 
  Join Carro
    on Montadora.id = Carro.idMontadora

/*
Formato ANSI 89
*/

Select Montadora.id, 
       Montadora.Nome  , 
	   Carro.id , 
	   Carro.Modelo , 
	   Carro.idMontadora
  From Montadora , Carro
 Where Montadora.id = Carro.idMontadora


-- Seguran�a do JOIN no padr�o ANSI-92

Select Montadora.id, 
       Montadora.Nome  , 
	   Carro.id , 
	   Carro.Modelo , 
	   Carro.idMontadora
  From Montadora 
  Join Carro

GO

Select Montadora.id, 
       Montadora.Nome  , 
	   Carro.id , 
	   Carro.Modelo , 
	   Carro.idMontadora
  From Montadora , Carro



/*
Exemplo Pr�tico 
*/

/*

Monstrar a rela��o de Categoria e seu produtos. 

*/

use LojaVirtual
go

Select * from Produto
Select * from Categoria

Select Categoria.id,
       Categoria.Descricao, 
       Produto.id, 
	   Produto.Titulo 
  From Categoria  -- PK
  Join Produto    -- FK
    on Categoria.id = Produto.IdCategoria
 Order by Categoria.Descricao

-- Manda impede de realizar a jun��o em qualquer ordem 
Select Categoria.id,
       Categoria.Descricao , 
       Produto.id, 
	   Produto.Titulo 
  From Produto -- FK
  Join Categoria -- PK 
    on Produto.IdCategoria = Categoria.id
 Order by Categoria.Descricao


 /*
 Processamento l�gico 
 */


 Select Categoria.id,                          -- (3)  Apresenta��o 
        Categoria.Descricao, 
        Produto.id, 
	    Produto.Titulo 
   From Categoria Join Produto                 -- (1)   Produto Cartesiano
     on Categoria.id = Produto.IdCategoria     -- (2)   Filtro de linhas 
  Order by Categoria.Descricao                 -- (4)   Ordena��o

