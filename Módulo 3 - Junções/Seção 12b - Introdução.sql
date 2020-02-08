
/*
Introdução - JOIN 
*/

USE FundamentosTSQL;
GO


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

-- A ordem de execução é  

1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY 


-- Quando conversamos sobre SELECT na aula 31, explicamos as fases de processamento lógico.
-- citamos a fase JOIN e ON.


/*
JOIN é um operador de tabela utilizado no FROM para unir dados de duas tabelas
realizando uma junção vertical. 

Esse junção entre duas tabelas deverá ser realizado comparando valores de colunas
comumns nas tabelas e que (de alguma forma) mantêm uma relação entre elas.
*/


/*
FROM <tabela1> <Tipo Join> <tabela2> ON <Filtro de linhas>


FROM <Tabela1> 
     <Tipo Join> <tabela2> 
	ON <Filtro de linhas>

Filtro de Linhas - Quando voce utiliza um expressão de comparação com 
a coluna da tabela do lado esquerdo com outra coluna da tabela do lado direto. 

Tabela1.Coluna = Tabela2.Coluna 

Geralmente e como manda a boa prática, essas colunas são as chaves primárias e 
chaves estrangeiras.

FROM Tabela1 
     <Tipo Join> Tabela2 
	ON Tabela1.Coluna = Tabela2.Coluna 


*/ 
go

Use FundamentosTSQL
go

/*
Eduardo necessita de um relatório que apresente os pedidos do cliente de ID igual a 1, mas você
deve apresentar os dados do cliente e dos pedidos. 

Do cliente, voce deve apresentar o nome e o endereço dele.
E do pedido, voce deve apresentar o número, a data do pedido e o frete, por exemplo.
*/

Select iIDCliente , RazaoSocial, Endereco  
  From Vendas.Cliente 
  Where iIDCliente = 1 

Select iIDCliente , iIDPedido,DataPedido,Frete  
  From Vendas.Pedido 
 Where iIDCliente = 1 

Select RazaoSocial, Endereco , iIDPedido , DataPedido , Frete  
  From Vendas.Cliente 
 INNER JOIN Vendas.Pedido 
   ON Cliente.iidCliente = Pedido.iIDCliente
  Where Cliente.iidCliente = 1
    

/*
Fases de processamento lógicos do JOIN.
*/

/*
Se o tipo de JOIN é o CROSS JOIN, não utilizamos o ON
*/


1. FROM 
2.     CROSS JOIN 
3. WHERE
4. GROUP BY
5. HAVING
6. SELECT
7. ORDER BY 

/*
Se o tipo de JOIN é o INNER JOIN (Junção Interna), utilizamos o ON
*/


1. FROM 
2.     INNER JOIN 
3.     ON 
4. WHERE
5. GROUP BY
6. HAVING
7. SELECT
8. ORDER BY 

/*
Se o tipo de JOIN é o OUTER JOIN (Junção Externa), utilizamos o ON 
e depois existe o processo interno do SQL Server que será
a adição das linhas externas ao resultado. 
*/

1. FROM 
2.     OUTER JOIN 
3.     ON 
4.     <adição de linhas externas>
5. WHERE
6. GROUP BY
7. HAVING
8. SELECT
9. ORDER BY 

/*
Tabelas exemplos para demonstração 
*/

Use FundamentosTSQL
go


Select RazaoSocial, Endereco, iidPedido, DataPedido 
  From Vendas.Cliente 
 Inner Join Vendas.Pedido
    on Cliente.iIDCliente = Pedido.iIDCliente
 Where Cliente.iIDCliente = 68
 Order by iIDPedido

 use LojaVirtual
 go

Select * 
  From Cliente 
  Inner Join Pedido 
     on Cliente.id = Pedido.idCliente
  where cliente.id = 7177
  Order by PrimeiroNome

