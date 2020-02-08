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

/*
Após o agrupamento dos dados, talvez voce necessite aplicar alguns filtros 
nos dados agrupados 
*/

-- Analise o resultado da instrução abaixo:

Select YEAR(DataPedido) as AnoPedido,  -- FASE 4
       iIDEmpregado, 
       COUNT(*) as QuantidadePedido
  From Vendas.Pedido                   -- FASE 1
 Where iIDCliente = 71                 -- FASE 2
 Group by YEAR(DataPedido) ,           -- FASE 3
          iIDEmpregado 

-- No caso, vamos precisar analisar somente os empregrados que 
-- realizaram dois ou mais pedidos em cada ano. 
 
Select YEAR(DataPedido) as AnoPedido,  -- FASE 4
       iIDEmpregado, 
       COUNT(*) as QuantidadePedido
  From Vendas.Pedido                   -- FASE 1
 Where iIDCliente = 71                 -- FASE 2
 Group by YEAR(DataPedido) ,           -- FASE 3
          iIDEmpregado 
 Having COUNT(*) > 1    
  
 /*
 Como citado, somente as fases SELECT e FROM são obrigatórios. 
 As demais são opcionais e devem ser utilizadas para 
 atender as regras de negócio.

 No caso do HAVING também, mas tem uma exceção.
 Veja o exemplo abaixo 

 */               

  Select Pais
    From Vendas.Cliente 
  Having COUNT(*) > 1


  Select Pais, Cidade, COUNT(*) as QuantidadeCliente
    From Vendas.Cliente 
  Having COUNT(*) > 1

  
  Select Pais, Cidade, COUNT(*) as QuantidadeCliente
   From Vendas.Cliente 
 Where COUNT(*) > 1


  Select Pais, Cidade, COUNT(*) as QuantidadeCliente
   From Vendas.Cliente 
  Group by Cidade,Pais



 Select Pais, Cidade, COUNT(*) as QuantidadeCliente
   From Vendas.Cliente 
  Group by Cidade,Pais
 Having COUNT(*) > 1
 
 
 /*
 O que deve utilizar como filtro no HAVING ?

 Analisar o que a fase anterior enviou para a próxima fase.

 Colunas agrupadas e funções de agregração. 
 Usar funções normais, operações de matemáticas ou concatenação.

 */

 select * from Vendas.Cliente 

 Select Pais, Cidade, COUNT(*) as QuantidadeCliente
   From Vendas.Cliente 
  Group by Cidade,Pais
 Having Pais = 'Brazil' 
  
    

/*
Vamos utilizar a query da aula de Group by
que apresentar o total de pedido realizado por 
empregado e por ano para o cliente de id = 71. 
Mas somente dos anos 2007 e 2008

Veja que temos algumas váriaveis para determinar a nossa query.
Uma em particular que é somente dos anos 2007 e 2008 

Aqui temos a query que trabalhamos na aula passada.

*/

Select YEAR(Ped.DataPedido) as AnoPedido, 
       Ped.iIDEmpregado, 
       COUNT(*) as QuantidadePedido
  From Vendas.Pedido as Ped
 Where Ped.iIDCliente = 71 
 Group by YEAR(Ped.DataPedido), 
          Ped.iIDEmpregado 

/*
Temos que usar agora uma outra expressão lógica (ou predicado)
que seria Ano >= 2007 ?

Então temos que usar a função YEAR() para montar o predicado
YEAR(DataPedido) >= 2007 ou usar a comparação da coluna 
DataPedido (na aula WHERE) maior ou igual a 2007-01-01 ?

*/


Select YEAR(Ped.DataPedido) as AnoPedido, 
       Ped.iIDEmpregado, 
       COUNT(*) as QuantidadePedido
  From Vendas.Pedido as Ped
 Where Ped.iIDCliente = 71 
 Group by YEAR(Ped.DataPedido), 
          Ped.iIDEmpregado 
 Having YEAR(Ped.DataPedido) >= 2007

 -- OU 

 Select YEAR(Ped.DataPedido) as AnoPedido, 
       Ped.iIDEmpregado, 
       COUNT(*) as QuantidadePedido
  From Vendas.Pedido as Ped
 Where Ped.iIDCliente = 71 
 Group by YEAR(Ped.DataPedido), 
          Ped.iIDEmpregado 
 Having Ped.DataPedido >= '2007-01-01'

/*
Msg 8121, Level 16, State 1, Line 152
Column 'Vendas.Pedido.DataPedido' is invalid in the HAVING 
clause because it is not contained in either 
an aggregate function or the GROUP BY clause.
*/


 Select YEAR(Ped.DataPedido) as AnoPedido, 
       Ped.iIDEmpregado, 
       COUNT(*) as QuantidadePedido
  From Vendas.Pedido as Ped
 Where Ped.iIDCliente = 71 
   and Ped.DataPedido >= '2007-01-01'
 Group by YEAR(Ped.DataPedido), 
          Ped.iIDEmpregado 

