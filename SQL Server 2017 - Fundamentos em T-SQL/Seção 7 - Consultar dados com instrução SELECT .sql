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
A montagem do comando segue com as seguintes cláusulas
*/

SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY 

/*
Vamos identificar a ordem do processamento lógico
quebrando a instrução SELECT em partes para entender como funciona.
*/

	Select iIDEmpregado

	Select iIDEmpregado
	  From Vendas.Pedido

	Select NumeroEmpregado
	  From Vendas.Pedido
	  
/*
De acordo com padrão ANSI, existe uma forma conceitual de como a instrução deve ser 
processada logicamente. Essa forma ajuda a entender como a instrução funciona, 
Como devemos resolver problemas de execução e construir a instrução da melhor 
forma.
*/

-- A ordem de execução é  

1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY 

-- E para efeito de explicação, cada uma das cláusulas será chamada de "fase"


/*
Se escrevermos a instrução SELECT de acordo o processamento lógico, seria:
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
Considerando a instrução SELECT completa para o SQL Server 2017,
a ordem de execução lógica de cada fase será:
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
mais ênfase do que as outras.

E algumas delas pode se opcionais ou obrigatórias. 
No caso do SELECT e com o objetivo primário de recuperar dados, 
então as fase SELECT e FROM são obrigatórios para execução. 
As demais são opcionais e somente será utilizadas para atender uma regra (proposição).

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


