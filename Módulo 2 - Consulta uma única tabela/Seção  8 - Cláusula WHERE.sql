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





 -- Composi��o do predicado na linguagem SQL : 
 --      Coluna Operador Valor  --> Salario < 50000 
 --      Valor Operador Coluna  --> 50000 >= Salario 

 -- Valor pode ser um dado escalar, uma opera��o matem�tica, uma fun��o ou at� mesmo uma 
 -- Conjunto de dados  

 -- Sentido l�gico de usar a coluna no predicado � em fun��o 
 -- do local onde os dados est�o armazenados e o que 
 -- desejamos filtrar de linhas da fase FROM. 

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

Select 91 - 6 as Linhas

/*
Se o total de Clientes � 91 e clientes somente de SP s�o 6, ent�o podemos dizer 
que os clientes diferentes de SP s�o 85??
*/

 Select Contato, Endereco, Regiao 
   from Vendas.Cliente
  where Regiao <> 'SP'

-- Retornou 25 linhas ???

/*
Aqui temos a l�gica do predicado de tr�s valores : 
Verdadeiro, Falso ou Desconhecido.
Vamos tratar isso quando falarmos de valores NULOS (NULL)
*/

-- No exemplo da tabela de pedidos, ela tem  830 linhas 

Select Pedido.iIDEmpregado , Pedido.DataPedido 
  From Vendas.Pedido 

Select Vendas.Pedido.iIDEmpregado , 
       Vendas.Pedido.DataPedido 
  From Vendas.Pedido 

Select Ped.iIDEmpregado , 
       Ped.DataPedido 
  From Vendas.Pedido as Ped

-- Para os mais radicais,...

Select P.iIDEmpregado , 
       P.DataPedido 
  From Vendas.Pedido as P

  

-- Neste caso, o que acontecer�? 

Select Ped.iIDEmpregado , 
       Ped.DataPedido 
  From Vendas.Pedido as Ped
 Where iIDCliente = 71


-- Quando incluimos a clausula WHERE realizando o filtro do ID 
-- idcliente igual a 71

Select Ped.iIDEmpregado , Ped.DataPedido 
  From Vendas.Pedido as Ped
 Where Ped.iIDCliente = 71


-- Temos um resultado de 31 linhas. 
-- A leitura que temos � que a fase FROM processou 830 linha 
-- e enviou esse dados para a fase WHERE, que aplicou 
-- o predicado e processou 31 linhas que ser� enviada
-- para a pr�xima fase. 


--- Exemplos de predicado com Data 

Select Ped.iIDEmpregado , Ped.DataPedido , Ped.DataEnvio 
  From Vendas.Pedido as Ped
 Where Ped.DataEnvio >= '2008-01-01'

 Select Ped.iIDEmpregado , Ped.DataPedido , Ped.DataEnvio 
  From Vendas.Pedido as Ped
 Where Ped.DataEnvio >= '01/01/2008'


 -- Exemplos de predicado com numero 

 
 Select Ped.iIDEmpregado , Ped.DataPedido , Ped.DataEnvio  , Ped.Frete 
  From Vendas.Pedido as Ped
 Where Ped.Frete >= 750.00 




