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
*/

Select iIDEmpregado , DataPedido 
  From Vendas.Pedido
 Where iIDCliente = 71

 -- Repare que os dados n�o est�o ordenados !!!

 /*
 Uma das formas de trabalhar com as inform��es pode ser uma an�lise 
 mais consolidada dos dados para obter novas informa��es. 
 */

 -- Agora vamos imaginar que voce precise da seguinte informa��o:
 -- Quantos pedidos foram realizados por cada empregrado para o cliente 71 ??
 
 /*
 Podemos identificar nesta perguntar um fator de agrupamento que diz : 
 "Quantidade de pedidos por empregado"  ou 
 "N�mero total de pedidos que cada empregado realizou"

 A identifica��o de um fator de agrupamento, indica que os dados devem 
 se consolidados por um grupo espec�fico de colunas (ou mesmo de dados).

 No exemplo acima, o fator de agrupamento � o empregado. Temos que agrupar 
 o empregado para identificar a quantidade ou contagem de pedidos. 
 
 Em outras palavras, tenho que pegar todos os pedidos, agrupar por 
 empregrado e realizar a contagem de pedidos por empregado.

 Como seria realizar essa atividades sem usar o SQL???

 1- Obter uma lista dos pedidos com a identifica��o do empregado.
 2- Ordenar a lista de forma crescente pela identifica��o do empregado.
 3- Posiciar na primeira linha da lista.
 3- Come�ar a contar os pedidos para o pr�ximo empregado.
 4- Acumular a contagem para o empregado atual.
 5- Ir para a pr�xima linha.
 6- Se n�o existir a proxima linha,
       mostra a identifica��o do empregado e a contagem acumulada
	   ir para o passo 9.
 7- Se a identifica��o do empregado mudou, 
      mostra a identifica��o do empregado e a contagem acumulada
	  Zerar a contagem acumulada.
 8- Executar o passo 3 
 9- Fim da execu��o


 Se voce tem uma lista de pedidos com 50 pedidos realizados por 10 funcion�rios, 
 No final do processamento acima, voce ter� quantas linhas apresentadas?
 
 No final teremos um resultado com 10 linhas. 

 */

 -- Vamos usar a Cl�usula GROUP BY 

 
 Select iIDEmpregado
  From Vendas.Pedido   -- (Fase 1) 
 Where iIDCliente = 71 -- (Fase 2) 
 Group by iIDEmpregado -- (Fase 3) 

/*
Fase 1 ser� retornada 830 linas
Fase 2 ser� retornada 31 linhas
Fase 3 ser� retornada 9 linhas
*/


 Select iIDEmpregado 
   From Vendas.Pedido 
  Where iIDCliente = 71 
  Group by iIDEmpregado 

-- Veja que os dados est�o ordenados pela coluna identificacao do empregado.
-- Mas como dito, isso n�o � regra e por outros motivos, os dados podem vir em
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

-- COUNT(*) � uma fun��o de agrega��o que retorna a contagem de linhas
-- realizadas dentro do agrupamento. 

/*
Realizando agrupamento com duas colunas ou express�o, 
de acordo com o nosso exemplo inicial.
*/

 -- Vamos mudar a pergunta:
 -- Quantos pedidos foram realizados por cada empregrado em cada ano??
 -- Qual ou quais s�o os fatores de agrupamento?




 -- Quantos pedidos por ano foram realizados por cada empregado??
 -- Vamos usar a coluna "DataPedido" para os exemplos.

 Select iIDEmpregado, COUNT(*) as QuantidadePedido
   From Vendas.Pedido 
  Where iIDCliente = 71 
  Group by iIDEmpregado 

-- Vamos responder pergunta. Total de pedidos por empregado e ano.
-- Utilizaremos a coluna DataPedido que cont�m uma data no formato AAA-MM-DD.
-- Precisamos obter somente o ano dessa data. Vamos usar a fun��o YEAR().

Select CURRENT_TIMESTAMP , YEAR(CURRENT_TIMESTAMP)

--

Select iIDEmpregado, 
       YEAR(DataPedido) as AnoPedido, 
       COUNT(*) as QuantidadePedido
   From Vendas.Pedido 
  Where iIDCliente = 71 
  Group by iIDEmpregado , YEAR(DataPedido) 

/*
No exemplo anterior que agrupamos somente pela identifica��o do empregado,
o resultado apresentado foi de 9 linhas.
Agora incluindo mais uma coluna no agrupamento, 
o resultado de linhas ser� de quanto?
*/


Select YEAR(DataPedido) as AnoPedido, 
       iIDEmpregado, 
       COUNT(*) as QuantidadePedido
  From Vendas.Pedido 
 Where iIDCliente = 71 
 Group by YEAR(DataPedido), 
          iIDEmpregado 

  -- 16 linhas.

-- Exemplo utilizando o alias 

Select YEAR(Ped.DataPedido) as AnoPedido, 
       Ped.iIDEmpregado, 
       COUNT(*) as QuantidadePedido
  From Vendas.Pedido as Ped
 Where Ped.iIDCliente = 71 
 Group by YEAR(Ped.DataPedido), 
          Ped.iIDEmpregado 


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



/*
Fun��es de agrega��o 
S�o fun��es utilizada em processo de agrega��o de dados, utilizada na 
grande maioria dos casos com a fase GROUP BY.

SUM
COUNT
MAX
MIN 
AVG
... 

*/

Select YEAR(DataPedido) as AnoPedido, 
       iIDEmpregado, 
       COUNT(*) as QuantidadePedido,
	   MIN(DataPedido) as	,
	   MAX(DataPedido) as UltimaDataPedido,
	   AVG(Frete) as ValorMedioFrete
  From Vendas.Pedido 
 Where iIDCliente = 71 
 Group by YEAR(DataPedido), 
          iIDEmpregado 
