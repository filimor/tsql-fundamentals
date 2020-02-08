-- SUBCONSULTAS.

-- Introdução.

/*
Uma instrução SELECT realiza um consulta de dados a partir de uma ou várias
tabelas aplicando filtros, agrupamento e ordenação.

O T-SQL tem suporte para realizar uma consulta de dados dentro de instruções DML ou 
realizar aninhamento de consultas que é uma consulta dentro de outra consulta. 

Esse tipo de consulta é definida como subconsulta ou subquery. 

Uma subconsulta pode ser utilizada em qualquer lugar que permite 
o uso de uma expressão. 

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
- A consulta externa é a instrução que enviará os dados ao 
  chamador (SSMS, aplicação, uma GUI, por exemplo). Somente as 
  expressões da cláusula SELECT serão enviadas.
- A consulta interna é a instrução cujos os dados serão 
  utilizados pela consulta externa.  As expressões da cláusula 
  SELECT da consulta interna não serão enviadas ao chamador da instrução.
*/

							
/*
Algumas observações sobre essa consulta.

- A maioria das consultas que tem subconsultas podem ser resolvidas 
  utilizando JOINS.
- Entranto, algumas perguntas somente serão respondidas com subconsultas.
- Ambos os casos (JOINS ou subconsultas) apresentam os mesmo resultados 
  para pesquisas equivalentes.
- Em casos específicos, o JOIN tem um melhor desempenho em relação a subconsultas.

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

- Uma subconsulta é sempre colocada entre parêntesis
- Pode ser utilizada no lugar de expressões, desde que a subconsulta
  retorne um valor único. 
- O aninhamento pode ser feito até 32 níveis ou no limite 
  de memória e de complexidade.
- Algumas cláusulas não são aceitas na instrução SELECT quando utilizada
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