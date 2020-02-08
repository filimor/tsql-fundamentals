-- SUBCONSULTAS.

-- Introdu��o.

/*
Uma instru��o SELECT realiza um consulta de dados a partir de uma ou v�rias
tabelas aplicando filtros, agrupamento e ordena��o.

O T-SQL tem suporte para realizar uma consulta de dados dentro de instru��es DML ou 
realizar aninhamento de consultas que � uma consulta dentro de outra consulta. 

Esse tipo de consulta � definida como subconsulta ou subquery. 

Uma subconsulta pode ser utilizada em qualquer lugar que permite 
o uso de uma express�o. 

Exemplos:

*/

use LojaVirtual
go


Select Id, 
       IdFornecedor, 
	   Titulo , 
	   CodigoFornecedor 
  From Produto -- Prd1
 Where CodigoFornecedor = (Select CodigoFornecedor 
                             From Produto -- Prd2
							Where id = 172)


/*
- A consulta externa � a instru��o que enviar� os dados ao 
  chamador (SSMS, aplica��o, uma GUI, por exemplo). Somente as 
  express�es da cl�usula SELECT ser�o enviadas.
- A consulta interna � a instru��o cujos os dados ser�o 
  utilizados pela consulta externa.  As express�es da cl�usula 
  SELECT da consulta interna n�o ser�o enviadas ao chamador da instru��o.
*/

							
/*
Algumas observa��es sobre essa consulta.

- A maioria das consultas que tem subconsultas podem ser resolvidas 
  utilizando JOINS.
- Entranto, algumas perguntas somente ser�o respondidas com subconsultas.
- Ambos os casos (JOINS ou subconsultas) apresentam os mesmo resultados 
  para pesquisas equivalentes.
- Em casos espec�ficos, o JOIN tem um melhor desempenho em rela��o a subconsultas.

No exemplo anterior, podemos utiliza o JOIN. 
  
*/

Select Prd1.Id, 
       Prd1.IdFornecedor, 
	   Prd1.Titulo , 
	   Prd1.CodigoFornecedor 
  From Produto as Prd1 
  Join Produto as Prd2
    on Prd1.CodigoFornecedor = Prd2.CodigoFornecedor
 Where Prd2.id = 172

/*
Algumas regras de subconsultas:

- Uma subconsulta � sempre colocada entre par�ntesis
- Pode ser utilizada no lugar de express�es, desde que a subconsulta
  retorne um valor �nico. 
- O aninhamento pode ser feito at� 32 n�veis ou no limite 
  de mem�ria e de complexidade.
- Algumas cl�usulas n�o s�o aceitas na instru��o SELECT quando utilizada
  como subconsultas. 

*/

Select (Select PrimeroNome+' '+SegundoNome+ ' '+ TerceiroNome as Nome 
          From cliente 
		 Where id = 2)


Select (Select PrimeroNome+' '+SegundoNome+ ' '+ TerceiroNome as Nome 
          From cliente 
		 Where id > 2)


Select * 
  From Cliente
 Where id = (Select idCliente 
               From Pedido 
			  Where id = (Select idpedido 
			                From ItemPedido
						   Where PercentualDesc > 0
						     and IdProduto = (Select id 
						                        From Produto 
											    Where IdFornecedor = (Select id 
												                        From Fornecedor 
																		Where id = 141
																	 ) -- Nivel 4 
								             ) -- Nivel 3
						 ) -- Nivel 2
			) -- Nivel 1 


Select * 
  From ItemPedido
 Where idProduto = (Select id 
                      From Produto 
                     Order by id
				   ) 


Select * 
  From ItemPedido
 Where idProduto = (Select top 1 id 
                      From Produto 
                     Order by id
				   ) 



/*
Fim
*/