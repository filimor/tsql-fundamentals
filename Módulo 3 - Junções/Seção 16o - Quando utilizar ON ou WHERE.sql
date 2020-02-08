/*
Para começar, vamos seguir uma receita de bolo : 

ON    - Para combinar
WHERE - Para Filtrar

E vamos aos poucos tratar as exceções... 

Quando você tem um predicado que precisa ser aplicar para atender 
a um regra de negócio, as vezes podemos ter a dúvida em onde usar esse predicado. 
Se posso aplicar filtro no fase ON ou na fase Where !?

Lembra do desenvolvedor novato que teve que alterar um instrução
SELECT de outro desenvolvedor na aula "Erros de lógica no OUTER JOIN".

Naquela aula ficou uma pergunta no final.

É se fosse solicitado para um outro programador novato que realizasse 
a alteração no código para continuar a mostrar "todos" os clientes 
com os pedidos feito nos últimos 5 anos??

Ou seja, se o cliente não tem o Pedido feito nos último 5 anos,
mostre os dados dele mesmo assim. 

*/

Use LojaVirtual
go


Select c.id as idCliente , 
       c.PrimeiroNome as Nome , 
	   c.CPF as CPF, 
	   c.Endereco as Endereco ,   
	   c.CEP as CEP ,
	   p.id  as idPedido , 
	   p.DataPedido as DataPedido, 
	   p.Valor  as Valor 
  From Cliente as c
  Left Join Pedido as p
    On c.id = p.idCliente 
 Where UF = 'SP'
   and Substring(cep,1,1) = '0'
   and p.DataPedido >= dateadd(year,-5,getdate())
   

/*

Como fazer para mostrar todos os clientes com os pedidos realizados nos
últimos 5 anos e mesmo assim mostrar os clientes sem pedidos nesse mesmo período? 

Quando aplicamos o filtro no " where p.DataPedido >= dateadd(year,-5,getdate()) "
é realizado o filtro na coluna do lado não preservado do resultado. 

Isso que dizer que as colunas com o valor NULL do lado não preservado são 
descartados e com isso não temos mais a informação de clientes sem pedido.

ok?

Então temos que manter ainda a finalidade o OUTER JOIN, que é manter os clientes mesmo sem pedido.

Se nos lembramos das fases do OUTER JOIN, temos:

*/
SELECT 
'...'
  From Cliente as c              -- (1) 
  Left Outer Join Pedido as p    -- (2)
    On c.id = p.idCliente        -- (3) e (4)
 Where UF = 'SP'                 -- (5) 

 /*
(1)  Fase FROM     - Primeira fase da instrução, carrega a tabela Cliente.
(2)  Fase JOIN     - Efetua o produto cartesiano com a tabela Pedido.

(3)  Fase ON       - Efetua a junção interna entre as linhas de Cliente e Pedido.
                     No ON que é feito a correspondência entre as tabelas.
(4)                - Como é um LEFT OUTER JOIN, ele inclui as linhas de CLIENTES que não
		           - foram identificadas em Pedidos. Com isso ele preserva as linhas 
			       - da tabela a esquerda, que é a tabela CLIENTE. 
			       - As linhas da tabela a DIRETA, as colunas são apresentas 
			       - com valores NULL.

 (5) Fase WHERE    - Efetua o filtro para estado de São Paulo.
 

Na fase (3) ON, ocorre a correspondência entre as tabela Cliente e Pedido.
No ON, como vimos, podemos fazer o EQUI-JOIN , NO-EQUI JOIN e o COMPOSITE-JOIN. 

No COMPOSITE-JOIN, utilizamos duas ou mais comparações com operadores de comparação
com as expressões. Lembre-se:
*/

ON Tabela1.ColunaA = Tabela2.ColunaA 
   AND 
   Tabela1.ColunaB = Tabela2.ColunaB

/*
Como podemos usar qualquer expressão no ON, podemos sim realizar a correspondência 
de uma coluna com uma expressão que não necessariamente seja uma coluna.

Algo que pode ser: 

*/

SELECT 
'...'
  From Cliente as c                                -- (1) 
  Left Join Pedido as p                            -- (2)
    On c.id = p.idCliente                          -- (3) 
   and p.DataPedido >= dateadd(year,-5,getdate())  -- (4) 
 Where UF = 'SP'                                   -- (5) 

/*
Sim, podemos aplicar a correspondência entre uma coluna e uma expressão 

(1)  Fase FROM     - Primeira fase da instrução, carrega a tabela Cliente.
(2)  Fase JOIN     - Efetua o produto cartesiano com a tabela Pedido.

(3)  Fase ON       - Efetua a junção interna entre as linhas de Cliente e Pedido.
                     No ON que é feito a correspondência entre as tabelas.
					 Temos aqui um COMPOSITE-JOIN com duas comparações. 

					 Na primeira comparação "On c.id = p.idCliente" está 
					 ocorrendo a correspondência entre a tabela CLIENTE e a tabela Pedido. 

					 Essa fase ainda não foi finalizada. 

(4)                - Na segunda comparação 	"and p.DataPedido >= dateadd(year,-5,getdate())"
                     temos ainda uma comparação de correspondência da data do pedido com 
					 uma data de 5 anos atrás.

                     Como é um LEFT JOIN, ele inclui as linhas de CLIENTES que não
		             foram identificadas em Pedidos dos últimos 5 anos. Com isso ele preserva as linhas 
			         da tabela a esquerda, que é a tabela CLIENTE. 
			         As linhas da tabela a DIRETA, as colunas são apresentas 
			         com valores NULL.

 (5) Fase WHERE    - Efetua o filtro para estado de São Paulo.
 

*/


Use LojaVirtual
go


Select c.id as idCliente , 
       c.PrimeiroNome as Nome , 
	   c.CPF as CPF, 
	   c.Endereco as Endereco ,   
	   c.CEP as CEP ,
	   p.id  as idPedido , 
	   p.DataPedido as DataPedido, 
	   p.Valor  as Valor 
  From Cliente as c
  Left Join Pedido as p
    On c.id = p.idCliente 
   And p.DataPedido >= dateadd(year,-5,getdate())
 Where UF = 'SP'
   and Substring(cep,1,1) = '0'

 /*
 Essa regra tem algum efeito quando utilizamos o INNER JOIN? 

 Vamos fazer um com  INNER JOIN onde usando o filtro da data 
 no WHERE e no ON.

 */

Select count(*) 
  From Cliente as c
  Join Pedido as p
    On c.id = p.idCliente 
 Where UF = 'SP'
   and Substring(cep,1,1) = '0'
   and p.DataPedido >= dateadd(year,-5,getdate())


Select count(*) 
  From Cliente as c
  Join Pedido as p
    On c.id = p.idCliente 
   and p.DataPedido >= dateadd(year,-5,getdate())
 Where UF = 'SP'
   and Substring(cep,1,1) = '0'

/*


*/


