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
  From Rh.Empregado

-- Neste caso ser� processado as 9 linhas da tabela. 

/*
Se desejamos apresentar os empregados com salario menor que 50.000,00
devemos usar um predicado que represente essa express�o.
No caso ser� Salario < 50000 
*/

Select *                 -- FASE 3
  From Rh.Empregado      -- FASE 1
 Where Salario < 50000   -- FASE 2 

 -- Neste caso ser� processado as 5 linhas da tabela. 

 /*
 No caso da tabela de Cliente, temos na tabela 91 linhas 
 */

 Select Contato, Endereco, Regiao 
   from Vendas.Cliente

/*
Se filtramos somente os cliente da regi�o de S�o Paulo, temos 6 linhas.
*/

 Select Contato, Endereco, Regiao 
   from Vendas.Cliente
  where Regiao = 'SP'


/*
Se o total de Clientes � 91 e clientes somente de SP s�o 6, ent�o podemos dizer 
que os clientes diferentes de SP s�o 85??
*/

 Select Contato, Endereco, Regiao 
   from Vendas.Cliente
  where Regiao <> 'SP'

-- Retornou 25 linhas ???

/*
Aqui temos a l�gica do predicado de tr�s valores : Verdadeiro, Falo ou Desconhecido.
Vamos tratar isso quando falarmos de valores NULOS (NULL)
*/


-- No exemplo da tabela de pedidos, ela tem  830 linhas 

Select iIDEmpregado , DataPedido 
  From Vendas.Pedido

-- Quando incluimos a clausula WHERE realizando o filtro do ID do cliente igual a 71

Select iIDEmpregado , DataPedido 
  From Vendas.Pedido
 Where iIDCliente = 71

-- Temos um resultado de 31 linhas. 
-- A leitura que temos � que a fase FROM processou 830 linha e enviu esse dados
-- Para a fase WHERE, que aplicou o predicado e processou 31 linhas que ser� enviada
-- para a pr�xima fase. 

