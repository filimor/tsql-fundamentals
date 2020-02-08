USE FundamentosTSQL;

	Select iIDEmpregado,                      
		   year(DataPedido) as AnoPedido, 
		   count(*) as QuantidadePedido
	  From Vendas.Pedido                      
	 Where iIDCliente = 71                    
	 Group by iIDEmpregado,                   
			  year(DataPedido)
	Having count(*) > 1                       
	 Order by iIDEmpregado,                   
			  AnoPedido

/*
A montagem do comando segue com as seguintes cl�usulas
*/

SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY 

/*
Vamos identificar a ordem do processamento l�gico
quebrando a instru��o SELECT em partes para entender como funciona.
*/

	Select iIDEmpregado

	Select iIDEmpregado
	  From Vendas.Pedido

	Select NumeroEmpregado
	  From Vendas.Pedido
	  
/*
De acordo com padr�o ANSI, existe uma forma conceitual de como a instru��o deve ser 
processada logicamente. Essa forma ajuda a entender como a instru��o funciona, 
Como devemos resolver problemas de execu��o e construir a instru��o da melhor 
forma.
*/

-- A ordem de execu��o �  

1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY 

-- E para efeito de explica��o, cada uma das cl�usulas ser� chamada de "fase"


/*
Se escrevermos a instru��o SELECT de acordo o processamento l�gico, seria:
*/

	  From Vendas.Pedido
	 Where iIDCliente = 71
	 Group by iIDEmpregado, 
			  year(DataPedido)
	Having count(*) > 1 
	Select iIDEmpregado, 
		   year(DataPedido) as AnoPedido, 
		   count(*) as QuantidadePedido
	 Order by iIDEmpregado, 
			  AnoPedido


/*
Considerando a instru��o SELECT completa para o SQL Server 2017,
a ordem de execu��o l�gica de cada fase ser�:
*/

1.  FROM
2.  ON
3.  JOIN
4.  WHERE
5.  GROUP BY
6.  WITH CUBE or WITH ROLLUP
7.  HAVING
8.  SELECT
    <lista de colunas>
9.  DISTINCT
10. ORDER BY
11. TOP
    OFFSET ROWS FETCH NEXT ROWS ONLY 

/*
De todas as fases que foram identificadas, passaremos por algumas delas com 
mais �nfase do que as outras.

E algumas delas pode se opcionais ou obrigat�rias. 
No caso do SELECT e com o objetivo prim�rio de recuperar dados, 
ent�o as fase SELECT e FROM s�o obrigat�rios para execu��o. 
As demais s�o opcionais e somente ser� utilizadas para atender uma regra (proposi��o).

*/

Select Cliente.iIDCliente , 
       count(Pedido.iIDPedido) as QuantidadePedido  
  From Vendas.Cliente Cliente
  Left Join Vendas.Pedido Pedido
    on Cliente.iIDCliente = Pedido.iIDCliente
  Where Cliente.Cidade = 'London'
  Group by Cliente.iIDCliente 
  Having count(Pedido.iIDPedido) < 4
  Order by QuantidadePedido


