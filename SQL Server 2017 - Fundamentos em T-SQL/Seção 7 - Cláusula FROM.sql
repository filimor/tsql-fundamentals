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
A forma mais simples de uma instrução select 
*/
Select *
  From Vendas.Pedido  

-- Neste caso será processado as 830 linhas da tabela. 

Select *              -- FASE 2
  From Vendas.Pedido  -- FASE 1


/*
Colocando álias ou apelido no nome da tabela.
*/


Select *
  From Vendas.Pedido as P

Select Pedido.iIDPedido  , 
       Pedido.iIDCliente , 
	   Pedido.DataPedido
  From Vendas.Pedido as Pedido


/*
Não existe garantia na ordem de apresentar os dados 
*/

Select iIDPedido , DataPedido
  From Vendas.Pedido as P

Select iIDPedido 
  From Vendas.Pedido as P


/*
Na clausula from somente especifico o nome de tabela?
*/

FROM <Expressão de tabela comum>
FROM <Visão>
FROM <Tabela Derivada>
FROM <Função com tabela embutida>
FROM <Função com tabela multiplos comandos>
FROM <Construtor de valor de tabela>






