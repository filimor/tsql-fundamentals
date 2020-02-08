USE FundamentosTSQL;

	Select iIDEmpregado,                      -- FASE 5
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
Uma opção exclusiva da T-SQL, a opção TOP permite definir o limite 
de apresentação dos dados
*/

-- Com um numero inteiro.

select NomeProduto from Producao.Produto

select top (3) NomeProduto 
  from Producao.Produto

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

/*
Deseje visualizar os 5 pedidos mais recentes 
*/

select iIDPedido,
       iIDCliente , 
	   DataPedido 
  From Vendas.Pedido
 Order by DataPedido desc 

-- Incluíndo o TOP 5
select TOP 5  
       iIDPedido,
       iIDCliente , 
	   DataPedido 
  From Vendas.Pedido
 Order by DataPedido desc 

-- Será que a última linha é realmente a mais recente ???








-- Observe que temos, se podemos dizer assim, um empate com data do pedido de 
-- 2008-05-05. Temos 4 pedidos com a mesma data.
-- Mas o pedido que foi apresetando no TOP 5 para a data 2008-05-05
-- foi o  11072, sendo que o pedido 11073 é o mais recente.

-- Para resolver isso, podemos incluir uma coluna na ordenação que possa garantir
-- que, no caso de empate de uma coluna na ordenação, esse nova coluna possa
-- fazer o desempate. 

-- Incluíndo o TOP 5
select TOP 5  
       iIDPedido,
       iIDCliente , 
	   DataPedido 
  From Vendas.Pedido
 Order by DataPedido desc , iIDPedido desc 
  

-- Uma outra forma de desempatar, seria considerar todos os pedidos que tem a mesma
-- Data do quinto pedido mais recente. 
-- Seria algo que considerar também as linhas com empate (with tie)!!

-- Incluíndo o TOP 5
select TOP 5  with ties
       iIDPedido,
       iIDCliente , 
	   DataPedido 
  From Vendas.Pedido
 Order by DataPedido desc 
