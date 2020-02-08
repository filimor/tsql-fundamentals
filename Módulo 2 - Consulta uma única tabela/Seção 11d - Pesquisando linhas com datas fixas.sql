/*
Pesquisando linhas com colunas do tipo datetime ou date 
*/
use FundamentosTSQL
go

/*
Podemos realizar filtros de linhas com colunas do tipo data 
na tabela para obter um conjunto de dados através 
de uma intervalo. Exemplos 

- Os lancamentos do último mês.
- Os pedidos do dia atual.
- Os funcionários contratados até ao ano passado.

São alguns exemplos de como podemos usar colunas do tipo datetime/date
junto com funções para filtra os dados. 
*/


-- Apresentar os pedidos que foram realizados em 06 de Abril de 2008 

Select * 
  From Vendas.Pedido 
 Where DataPedido = '2008-04-06'

 -- ou

 Select * 
  From Vendas.Pedido 
 Where DataPedido = '20080406'


 -- ou ??

  Select * 
  From Vendas.Pedido 
 Where DataPedido = 2008-04-06



-- Apresentar os pedidos que foram realizados em Abril de 2008. Neste caso, 
-- temos um intervalo de data, que podemos realizar de diversos modos.

Select * 
  From Vendas.Pedido 
 Where DataPedido >= '2008-04-01' and DataPedido <= '2008-04-30'

Select * 
  From Vendas.Pedido 
 Where DataPedido between '2008-04-01' and '2008-04-30'

Select * 
  From Vendas.Pedido 
 Where Year(DataPedido) = 2008 and Month(DataPedido) = 4

/*
-- Mostrar o total de vendas por dia para o mês de Abril de 2008.
*/

Select DataPedido, Count(*) as TotalPedido 
  From Vendas.Pedido 
 Where DataPedido >= '2008-04-01' and DataPedido <= '2008-04-30'
 Group by DataPedido
 Order by DataPedido 

 -- OU 

Select DataPedido, Count(*) as TotalPedido 
  From Vendas.Pedido 
 Group by DataPedido
Having DataPedido >= '2008-04-01' and DataPedido <= '2008-04-30'
 Order by DataPedido 

 -- OU

Select DataPedido, Count(*) as TotalPedido 
  From Vendas.Pedido 
 Where Year(DataPedido) = 2008 and Month(DataPedido) = 4
 Group by DataPedido
 Order by DataPedido 

 -- ou 

 Select DataPedido, Count(*) as TotalPedido 
  From Vendas.Pedido 
 Group by DataPedido
Having Year(DataPedido) = 2008 and Month(DataPedido) = 4
Order by DataPedido 

/*
Entre usar o WHERE e HAVING, qual dele voces escolheria? 
Será que faz diferente entre um ou outro?
*/



