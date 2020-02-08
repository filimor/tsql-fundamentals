/*

CROSS JOIN 

- Realiza uma opera��o de produto cartesiano entre
  as linhas de duas tabelas.
- 1 fase de processamento l�gico, que � o produto cartesiano
- Realiza a correspond�ncia de uma linha da tabela a esquerda
  com todas as linhas da tabela da direta. 
- Resultado do produto cartesino ser� sempre a multiplica��o
  das linhas da tabela a esquerda com as linhas da tabela da direta.
- SQL Server suporta duas sintaxe do CROSS JOIN. 
  O padr�o ANSI92 e ANSI89.

*/

use DBExemplo

drop table if exists dbo.Caixa
go

Create Table dbo.Caixa 
(
   id int not null,
   Modelo varchar(20) not null
)
go

insert into dbo.Caixa values (1,'Caixa Madeira'),(2,'Caixa Plastica'),(3,'Caixa Papel�o')
go

drop table if exists dbo.Tamanho

Create Table dbo.Tamanho 
(
   id int not null,
   Tamanho varchar(20) not null
)
go

insert into dbo.Tamanho values (1,'Pequena'),(2,'M�dia'),(3,'Grande'),(4,'Extra Grande')

select * from dbo.Caixa
select * from dbo.Tamanho



/*
Formato ANSI-92
*/

Select id , Modelo , id , Tamanho
  From dbo.Caixa  
  Cross Join dbo.Tamanho 
   
-- De qual tabela pertece a coluna id?

Select Caixa.id , Caixa.Modelo , Tamanho.id , Tamanho.Tamanho
  From dbo.Caixa as Caixa 
  Cross Join dbo.Tamanho as Tamanho 

Select Caixa.Modelo+' '+ Tamanho.Tamanho as Produto 
  From dbo.Caixa as Caixa 
  Cross Join dbo.Tamanho as Tamanho 



/*
Formato ANSI 89
*/

Select Caixa.Modelo +' '+ Tamanho.Tamanho
  From dbo.Caixa as Caixa,  
       dbo.Tamanho as Tamanho 



/*
Exemplo 2 

Voce est� criando um aplica��o mobile para controlar 
os jogo de loteria. 

Entre todas as tarefas que tem a aplica��o, voce ter� que
comparar tr�s apostas com 5 n�meros com o resultado de mais de 3.000 sorteios. 

*/

Select * from Aposta

Select * from Resultado 
Where Jogo = 3000

select 3719 * 4


Select * 
  From Aposta 
 Cross Join Resultado 




Select * 
  From Aposta 
 Cross Join Resultado 
  Where Aposta.Apo01 in (Resultado.Num01,
                        Resultado.Num02,
	  				    Resultado.Num03,
	 				    Resultado.Num04,
	 				    Resultado.Num05)
   and Aposta.Apo02 in (Resultado.Num01,
                        Resultado.Num02,
					    Resultado.Num03,
					    Resultado.Num04,
					    Resultado.Num05)
   and Aposta.Apo03 in (Resultado.Num01,
                        Resultado.Num02,
					    Resultado.Num03,
					    Resultado.Num04,
					    Resultado.Num05)

/*
*/

/*
Exemplo Pr�tico 
*/

-- Apresentar uma rela��o de produtos com as filiais Litoral e Interior, 
-- para posterior an�lise de distribui��o.

use LojaVirtual
go

-- Temos os produtos.
Select * from Produto
-- Temos as filiais.
Select * from Filial where id in (5,6)
-- Temos o Estoque dos Produtos x Filiais 
Select * from Estoque
where idFilial > 1


select count(*) from Produto
select count(*) from Filial where id in (5,6)

select 222 * 2


/*
Cross Join 
*/
Select Produto.id, Produto.Titulo , Produto.IdCategoria ,
       Filial.ID, Filial.Nome 
  From Produto 
 Cross Join Filial 
order by Titulo

/*
Cross Join, filtrando a filial 1 
*/
Select Produto.id, Produto.Titulo , Produto.IdCategoria ,
       Filial.ID, Filial.Nome 
  From Produto 
 Cross Join Filial 
 Where Filial.id in (5,6)
order by Titulo


/*
Processamento l�gico. 
*/

Select Produto.id, Produto.Titulo , Produto.IdCategoria ,
       Filial.ID, Filial.Nome 
  From Produto 
 Cross Join Filial -- 222 x 6 
 Order by Produto.Titulo





