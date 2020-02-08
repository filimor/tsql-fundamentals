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

/*
Ap�s o agrupamento dos dados, talvez voce necessite aplicar alguns filtros 
nos dados agrupados 
*/

-- Analise o resultado da instru��o abaixo:

Select YEAR(DataPedido) as AnoPedido,  -- FASE 4
       iIDEmpregado, 
       COUNT(*) as QuantidadePedido
  From Vendas.Pedido                   -- FASE 1
 Where iIDCliente = 71                 -- FASE 2
 Group by YEAR(DataPedido) ,           -- FASE 3
          iIDEmpregado 

-- No caso, vamos precisar analisar somente os empregrados que realizaram dois 
-- ou mais pedidos em cada ano. 
 
Select YEAR(DataPedido) as AnoPedido,  -- FASE 4
       iIDEmpregado, 
       COUNT(*) as QuantidadePedido
  From Vendas.Pedido                   -- FASE 1
 Where iIDCliente = 71                 -- FASE 2
 Group by YEAR(DataPedido) ,           -- FASE 3
          iIDEmpregado 
 Having COUNT(*) > 1    
  
 /*
 Como citado, somente as fases SELECT e FROM s�o obrigat�rios. As demais s�o
 opcionais e devem ser utilizadas para atender as regras de neg�cio.

 No caso do HAVING tamb�m, mas tem uma excess�o.
 Veja o exemplo abaixo 
 */               

  Select Pais, Cidade, COUNT(*) as QuantidadeCliente
   From Vendas.Cliente 
 Having COUNT(*) > 1



  Select Pais, Cidade, COUNT(*) as QuantidadeCliente
   From Vendas.Cliente 
 Where COUNT(*) > 1



 Select Pais, Cidade, COUNT(*) as QuantidadeCliente
   From Vendas.Cliente 
  Group by Cidade,Pais
 Having COUNT(*) > 1
   

