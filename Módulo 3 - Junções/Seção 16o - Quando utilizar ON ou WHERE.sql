/*
Para come�ar, vamos seguir uma receita de bolo : 

ON    - Para combinar
WHERE - Para Filtrar

E vamos aos poucos tratar as exce��es... 

Quando voc� tem um predicado que precisa ser aplicar para atender 
a um regra de neg�cio, as vezes podemos ter a d�vida em onde usar esse predicado. 
Se posso aplicar filtro no fase ON ou na fase Where !?

Lembra do desenvolvedor novato que teve que alterar um instru��o
SELECT de outro desenvolvedor na aula "Erros de l�gica no OUTER JOIN".

Naquela aula ficou uma pergunta no final.

� se fosse solicitado para um outro programador novato que realizasse 
a altera��o no c�digo para continuar a mostrar "todos" os clientes 
com os pedidos feito nos �ltimos 5 anos??

Ou seja, se o cliente n�o tem o Pedido feito nos �ltimo 5 anos,
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
�ltimos 5 anos e mesmo assim mostrar os clientes sem pedidos nesse mesmo per�odo? 

Quando aplicamos o filtro no " where p.DataPedido >= dateadd(year,-5,getdate()) "
� realizado o filtro na coluna do lado n�o preservado do resultado. 

Isso que dizer que as colunas com o valor NULL do lado n�o preservado s�o 
descartados e com isso n�o temos mais a informa��o de clientes sem pedido.

ok?

Ent�o temos que manter ainda a finalidade o OUTER JOIN, que � manter os clientes mesmo sem pedido.

Se nos lembramos das fases do OUTER JOIN, temos:

*/
SELECT 
'...'
  From Cliente as c              -- (1) 
  Left Outer Join Pedido as p    -- (2)
    On c.id = p.idCliente        -- (3) e (4)
 Where UF = 'SP'                 -- (5) 

 /*
(1)  Fase FROM     - Primeira fase da instru��o, carrega a tabela Cliente.
(2)  Fase JOIN     - Efetua o produto cartesiano com a tabela Pedido.

(3)  Fase ON       - Efetua a jun��o interna entre as linhas de Cliente e Pedido.
                     No ON que � feito a correspond�ncia entre as tabelas.
(4)                - Como � um LEFT OUTER JOIN, ele inclui as linhas de CLIENTES que n�o
		           - foram identificadas em Pedidos. Com isso ele preserva as linhas 
			       - da tabela a esquerda, que � a tabela CLIENTE. 
			       - As linhas da tabela a DIRETA, as colunas s�o apresentas 
			       - com valores NULL.

 (5) Fase WHERE    - Efetua o filtro para estado de S�o Paulo.
 

Na fase (3) ON, ocorre a correspond�ncia entre as tabela Cliente e Pedido.
No ON, como vimos, podemos fazer o EQUI-JOIN , NO-EQUI JOIN e o COMPOSITE-JOIN. 

No COMPOSITE-JOIN, utilizamos duas ou mais compara��es com operadores de compara��o
com as express�es. Lembre-se:
*/

ON Tabela1.ColunaA = Tabela2.ColunaA 
   AND 
   Tabela1.ColunaB = Tabela2.ColunaB

/*
Como podemos usar qualquer express�o no ON, podemos sim realizar a correspond�ncia 
de uma coluna com uma express�o que n�o necessariamente seja uma coluna.

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
Sim, podemos aplicar a correspond�ncia entre uma coluna e uma express�o 

(1)  Fase FROM     - Primeira fase da instru��o, carrega a tabela Cliente.
(2)  Fase JOIN     - Efetua o produto cartesiano com a tabela Pedido.

(3)  Fase ON       - Efetua a jun��o interna entre as linhas de Cliente e Pedido.
                     No ON que � feito a correspond�ncia entre as tabelas.
					 Temos aqui um COMPOSITE-JOIN com duas compara��es. 

					 Na primeira compara��o "On c.id = p.idCliente" est� 
					 ocorrendo a correspond�ncia entre a tabela CLIENTE e a tabela Pedido. 

					 Essa fase ainda n�o foi finalizada. 

(4)                - Na segunda compara��o 	"and p.DataPedido >= dateadd(year,-5,getdate())"
                     temos ainda uma compara��o de correspond�ncia da data do pedido com 
					 uma data de 5 anos atr�s.

                     Como � um LEFT JOIN, ele inclui as linhas de CLIENTES que n�o
		             foram identificadas em Pedidos dos �ltimos 5 anos. Com isso ele preserva as linhas 
			         da tabela a esquerda, que � a tabela CLIENTE. 
			         As linhas da tabela a DIRETA, as colunas s�o apresentas 
			         com valores NULL.

 (5) Fase WHERE    - Efetua o filtro para estado de S�o Paulo.
 

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


