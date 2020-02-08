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

 -- Agora vamos imaginar que voce precise da seguinte informa��o:
 -- Quantos pedidos foram realizados por cada empregrado ??
 
 /*
 Podemos identificar nesta perguntar que temos um fator de agrupamento que diz : 
 "Quantidade de pedidos por empregado" 
 Em outras palavras, tenho que pegar todos os pedidos, contar e agrupar por empregrado.
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
      mostra o a identificacao do empregado e a contagem acumulada
	  Zerar a contagem acumulada.
 8- Executar o passo 3 
 9- Fim da execu��o

 Se voce tem uma lista de pedidos com 50 pedidos realizados por 10 funcion�rios, 
 No final do processamento acima, voce ter� quantas linhas apresentadas?


 No final teremos um resultado com 10 linhas. 

 */


 Select *
  From Vendas.Pedido   -- (Fase 1) 
 Where iIDCliente = 71 -- (Fase 2) 
 Group by iIDEmpregado -- (Fase 3) 

/*
Fase 1 ser� retornada 830 linas
Fase 2 ser� retornada 31 linhas
Fase 3 ser� retornada 9 linhas
*/


-- Como j� citado, a partir do Group by, voce pode referenciar explicitamente 
-- as colunas ou express�es identificada pelo cl�usula.

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

/*
Realizando agrupamento com duas colunas ou express�o, de acordo com o nosso exemplo
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
-- Utilizaremos a coluna DataPedido que cont�m uma data no formato AAA-MM-DD.
-- Precisamos obter somente o ano dessa data. Vamos usar a fun��o YEAR().

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

