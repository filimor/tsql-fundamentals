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
A forma mais simples de uma instru��o select 
*/
Select *
  From Vendas.Pedido  

-- Neste caso ser� processado as 830 linhas da tabela. 

Select *              -- FASE 2
  From Vendas.Pedido  -- FASE 1


/*
Colocando �lias ou apelido no nome da tabela.
*/


Select *
  From Vendas.Pedido as P

Select Pedido.iIDPedido  , 
       Pedido.iIDCliente , 
	   Pedido.DataPedido
  From Vendas.Pedido as Pedido


/*
N�o existe garantia na ordem de apresentar os dados 
*/

Select iIDPedido , DataPedido
  From Vendas.Pedido as P

Select iIDPedido 
  From Vendas.Pedido as P


/*
Na clausula from somente especifico o nome de tabela?
*/

FROM <Express�o de tabela comum>
FROM <Vis�o>
FROM <Tabela Derivada>
FROM <Fun��o com tabela embutida>
FROM <Fun��o com tabela multiplos comandos>
FROM <Construtor de valor de tabela>






