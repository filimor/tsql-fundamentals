USE FundamentosTSQL;

	Select                                    -- FASE 5
	       TOP 10                             -- FASE 7                             
	       iIDEmpregado,                      
		   year(DataPedido) as AnoPedido, 
		   count(*) as QuantidadePedido
	  From Vendas.Pedido                      -- FASE 1
	 Where iIDCliente = 71                    -- FASE 2
	 Group by iIDEmpregado,                   -- FASE 3
			  year(DataPedido)
	Having count(*) > 1                       -- FASE 4
	 Order by iIDEmpregado,                   -- FASE 6
			  AnoPedido


/*
Uma op��o exclusiva da T-SQL, a op��o TOP permite definir o limite 
de apresenta��o dos dados. 

Voce pode pensar que o TOP filtrar linhas como se fosse um WHERE ou HAVING

Mas o TOP n�o trabalha com o predicado. 

O TOP ser� avaliado depois do ORDER BY !!!

*/

SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
TOP 



-- Com um numero inteiro.

select NomeProduto from Producao.Produto

select top (3) NomeProduto 
  from Producao.Produto      -- N�o faz sentido TOP sem ORDER BY !!!!

select top (3) NomeProduto,iIDFornecedor 
  from Producao.Produto

select top (3) NomeProduto 
  from Producao.Produto 
 order by NomeProduto

select top (3) NomeProduto,iIDFornecedor 
  from Producao.Produto 
 order by NomeProduto

/*
Com um valor percentual 
*/

select top (10) NomeProduto 
  from Producao.Produto

select top (10) PERCENT NomeProduto 
  from Producao.Produto

select *
  from Producao.Produto

/*
Quais os 10 produtos com o maior pre�o unitario
*/

select top (10) NomeProduto , PrecoUnitario
  from Producao.Produto
  order by PrecoUnitario Desc 

/*
Deseje visualizar os 5 pedidos mais recentes 

Os 5 pedidos que foram cadastrados recentes ou
Os 5 pedidos que tem a data de pedido com a data mais nova

*/

select iIDPedido,
       iIDCliente , 
	   DataPedido 
  From Vendas.Pedido
 Order by DataPedido desc 

-- Inclu�ndo o TOP 5
Select TOP (5)
       iIDPedido,
       iIDCliente , 
	   DataPedido 
  From Vendas.Pedido
 Order by DataPedido desc 

-- Ser� que a �ltima linha � realmente a mais recente ???








-- Observe que temos, se podemos dizer assim, um empate com data do pedido de 
-- 2008-05-05. Temos 4 pedidos com a mesma data.
-- Mas o pedido que foi apresetando no TOP 5 para a data 2008-05-05
-- foi o  11070, sendo que o pedido 11073 � o mais recente.

-- Para resolver isso, podemos incluir uma coluna na ordena��o 
-- que possa garantir que, no caso de empate de uma coluna 
-- na ordena��o, esse nova coluna possa fazer o desempate. 

-- Inclu�ndo o TOP 5
select TOP 5  
       iIDPedido,
       iIDCliente , 
	   DataPedido 
  From Vendas.Pedido
 Order by DataPedido desc , iIDPedido desc 
  

-- Uma outra forma de desempatar, seria considerar todos os pedidos 
-- que tem a mesma data do quinto pedido mais recente. 
-- Seria algo que considerar tamb�m as linhas com empate (with tie)!!

-- Inclu�ndo o TOP 5

select TOP 5 with ties
       iIDPedido,
       iIDCliente , 
	   DataPedido 
  From Vendas.Pedido
 Order by DataPedido desc




