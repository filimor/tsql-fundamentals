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
*/

Select iIDEmpregado , DataPedido 
  From Vendas.Pedido
 Where iIDCliente = 71

 -- Repare que os dados não estão ordenados !!!

 -- Agora vamos imaginar que voce precise da seguinte informação:
 -- Quantos pedidos foram realizados por cada empregrado ??
 
 /*
 Podemos identificar nesta perguntar que temos um fator de agrupamento que diz : 
 "Quantidade de pedidos por empregado" 
 Em outras palavras, tenho que pegar todos os pedidos, contar e agrupar por empregrado.
 Como seria realizar essa atividades sem usar o SQL???

 1- Obter uma lista dos pedidos com a identificação do empregado.
 2- Ordenar a lista de forma crescente pela identificação do empregado.
 3- Posiciar na primeira linha da lista.
 3- Começar a contar os pedidos para o próximo empregado.
 4- Acumular a contagem para o empregado atual.
 5- Ir para a próxima linha.
 6- Se não existir a proxima linha,
       mostra a identificação do empregado e a contagem acumulada
	   ir para o passo 9.
 7- Se a identificação do empregado mudou, 
      mostra o a identificacao do empregado e a contagem acumulada
	  Zerar a contagem acumulada.
 8- Executar o passo 3 
 9- Fim da execução

 Se voce tem uma lista de pedidos com 50 pedidos realizados por 10 funcionários, 
 No final do processamento acima, voce terá quantas linhas apresentadas?


 No final teremos um resultado com 10 linhas. 

 */


 Select *
  From Vendas.Pedido   -- (Fase 1) 
 Where iIDCliente = 71 -- (Fase 2) 
 Group by iIDEmpregado -- (Fase 3) 

/*
Fase 1 será retornada 830 linas
Fase 2 será retornada 31 linhas
Fase 3 será retornada 9 linhas
*/


-- Como já citado, a partir do Group by, voce pode referenciar explicitamente 
-- as colunas ou expressões identificada pelo cláusula.

 Select iIDEmpregado 
   From Vendas.Pedido 
  Where iIDCliente = 71 
  Group by iIDEmpregado 

-- Veja que os dados estão ordenados pela coluna identificacao do empregado.
-- Mas como dito, isso não é regra e por outros motivos, os dados podem vir em
-- outra ordem !!! 

 Select iIDEmpregado, Datapedido
   From Vendas.Pedido 
  Where iIDCliente = 71 
  Group by iIDEmpregado 


/*
Msg 8120, Level 16, State 1, Line 81
Column 'Vendas.Pedido.DataPedido' is invalid in the select list 
because it is not contained in either 
an aggregate function or the GROUP BY clause.
*/

 Select iIDEmpregado, COUNT(*) as QuantidadePedido
   From Vendas.Pedido 
  Where iIDCliente = 71 
  Group by iIDEmpregado 

/*
Realizando agrupamento com duas colunas ou expressão, de acordo com o nosso exemplo
inicial.
*/

 -- Vamos mudar a pergunta:
 -- Quantos pedidos foram realizados por cada empregrado em cada ano??
 -- Quantos pedidos por ano foram realizados por cada empregado??
 -- Vamos usar a coluna "DataPedido" para os exemplos.

 Select iIDEmpregado, COUNT(*) as QuantidadePedido
   From Vendas.Pedido 
  Where iIDCliente = 71 
  Group by iIDEmpregado 

-- Vamos responder pergunta. Total de pedidos por empregado e ano.
-- Utilizaremos a coluna DataPedido que contém uma data no formato AAA-MM-DD.
-- Precisamos obter somente o ano dessa data. Vamos usar a função YEAR().

Select CURRENT_TIMESTAMP , YEAR(CURRENT_TIMESTAMP)

--

Select iIDEmpregado, 
       YEAR(DataPedido) as AnoPedido, 
       COUNT(*) as QuantidadePedido
   From Vendas.Pedido 
  Where iIDCliente = 71 
  Group by iIDEmpregado , 
           YEAR(DataPedido) 

/*
No exemplo anterior que agrupamos somente pela identificação do empregado,
o resultado apresentado foi de 9 linhas.
Agora incluindo mais uma coluna no agrupamento, 
o resultado de linhas será de quanto?
*/


Select YEAR(DataPedido) as AnoPedido, 
       iIDEmpregado, 
       COUNT(*) as QuantidadePedido
  From Vendas.Pedido 
 Where iIDCliente = 71 
 Group by YEAR(DataPedido), 
          iIDEmpregado 

  -- 16 linhas.

/*

*/

Select YEAR(DataPedido)  as AnoPedido, 
       COUNT(*)          as QuantidadePedido1  ,
       COUNT(DataPedido) as QuantidadePedido2  ,
	   COUNT(DataEnvio)  as QuantidadePedido3  
  From Vendas.Pedido
  group by YEAR(DataPedido)

/*
*/
Select DataPedido, DataEnvio
  From Vendas.Pedido

