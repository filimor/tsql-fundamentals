/*

Multi-table JOIN 

- Join � um operador para realizar a jun��o de duas tabelas. 

- Quando desejamos realizar a jun��o de tr�s tabelas, temos que primeiro realizar
  a jun��o de duas tabelas e o resultado dessa jun��o, realizamos a jun��o 
  com a terceira tabela. Dessa forma, temos duas jun��es para unir tr�s tabelas. 

- Seguindo essa regras, utilizaremos para N tabelas, N-1 jun��es.

- Essas jun��es, dizemos que ocorrem da esquerda para a direita. Desde o FROM at� 
  chegar no WHERE.

- Para cada uma das jun��o utilizada (INNER JOIN), sempre temos que colocar uma 
  senten�a ON para realizar o filtro entre as tabelas. 

- Exemplos. Vamos utilizar tr�s tabelas como exemplo 
   
  FROM Tabela1 
  JOIN Tabela2 ON Tabela1.ColunaA = Tabela2.ColunaA 
  JOIN Tabela3 ON Tabela2.ColunaB = Tabela3.ColunaB 

  (1) Ocorre o produto cartesiano entre Tabela1 e Tabela2 ;
  (2) Ocorre o filtro de linhas entre Tabela1 e Tabela2 ( o resultado vou chamar de V1) ;
  (3) Ocorre o produto cartesiano entre o V1 e a Tabela3;
  (4) Ocorre o filtro de linhas entre V1 e Tabela3 ;
  (5) Os dados s�o enviados para a pr�xima fase. 

*/

/*
Exemplo 
*/



/*
Exemplo Pr�tico 
*/

/*
Exemplo 1

- Apresentar a rela��o completa de produtos, com os nomes das categorias 
  e fornecedores. A apresenta��o dos dados dese suprimir os ID das tabelas.
  No caso do forencedor, apresenta tamb�m o codigo do fornecedor. 

Apresentando a estrutura das tabelas.

Produtos 
id - Chave prim�ria que representa a identifica��o do Produto
idFornecedor - Chave estrangeira que representa a identifica��o do Fornecedor
Titulo - Descri��o do Produto.
idCategoria - Chave estrangeira que representa a identificacao da Categoria 

Categoria :
id - chave prim�ria que representa a identifica��o da Categoria 
Descricao - Descri��o da Categoria 

Fornecedor :
id - chave prim�ria que representa a identifica��o do Fornecedor  
Nome - Razao Social do Fornecedor. 
CodigoFornecedor - C�digo externo do fornecedor.
*/

use LojaVirtual

select id,IdFornecedor, Titulo , IdCategoria from Produto where id = 1 
select * from Categoria where id = 1
select * from Fornecedor where id = 141

Select Prod.Titulo , 
       Cat.Descricao, 
	   Forn.Nome, 
	   Forn.CodigoFornecedor
  From Produto as Prod
  Join Categoria as Cat 
    on Prod.idCategoria = Cat.id 
  Join Fornecedor as Forn
    on Prod.idFornecedor = Forn.id  
 Where Prod.DataExclusao is null




/*
Processamento L�gico.
*/



Select Prod.Titulo ,                     -- (6) Apresenta��o dos dados. 
       Cat.Descricao, 
	   Forn.Nome, 
	   Forn.CodigoFornecedor
  From Produto as Prod                   -- (1) Produto Cartesiano entre Produto e Categoria 
  Join Categoria as Cat 
    on Prod.idCategoria = Cat.id         -- (2) Filtro de linhas, resultado em V1 
  Join Fornecedor as Forn                -- (3) Produto Cartesiano entre V1 e Fornecedor 
    on Prod.idFornecedor = Forn.id       -- (4) Filtro de linhas, resultado em V2.
 Where Prod.DataExclusao is null         -- (5) Filtro de linhas 

/*
*/

/*
Exemplo 2

Apresentar uma rela��o dos clientes e os produtos que foram comprados por cada um dos clientes. 

Neste caso e para ajudar a entender como os dados est�o relacionados, voce dever�
ver o modelo de dados para ajudar a encontrar as rela��es.

Ent�o temos que utilizar 4 tabelas e para isso vamos realizar 3 joins.

Fazendo o mapeamente de PK e FK das tabelas com base do modelo, temos:

Tabela			PK		-->		Tabela			FK
--------------------------------------------------------------
Cliente			id		-->		Pedido			idCliente
Pedido			id		-->		ItemPedido		idPedido 
Produto         id      -->     ItemPedido      idProduto 		

*/


Select Cliente.PrimeiroNome ,
       Produto.Titulo 
  From Cliente
  Join Pedido
    on Cliente.id = Pedido.IdCliente
  Join ItemPedido 
    on Pedido.id = ItemPedido.IdPedido
  Join Produto
    on ItemPedido.IdProduto = Produto.id

/*
- Veja que as tabelas Pedido e ItemPedido est�o na instru��o somente para 
  permitir a rela��o entre o Cliente e os Produtos que foram comprados. 

- A nomenclatura das colunas ajuda no processo de entendimento da rela��es. 
*/


/*
Exemplo 3

Apresentar a mesma rela��o utilizada no exemplo anterior, mas incluir o nome
do fornecedor do produto.  

Ent�o temos que utilizar 5 tabelas e para isso vamos realizar 4 joins.

Fazendo o mapeamente de PK e FK das tabelas com base do modelo, temos:

Tabela			PK		           -->		Tabela			FK
-----------------------------------------------------------------------------
Cliente			id		           -->		Pedido			idCliente
Pedido			id		           -->		ItemPedido		idPedido 
Produto         id                 -->      ItemPedido      idProduto 		
Fornecedor      id                 -->      Produto         idForncedor 
                CodigoFornecedor   -->      Produto         CodigoFornecedor 

*/

Select Cliente.PrimeiroNome ,
       Produto.Titulo ,
	   Fornecedor.Nome
  From Cliente
  Join Pedido
    on Cliente.id = Pedido.IdCliente
  Join ItemPedido 
    on Pedido.id = ItemPedido.IdPedido
  Join Produto
    on ItemPedido.IdProduto = Produto.id
  Join Fornecedor
    on Fornecedor.id = Produto.IdFornecedor
   and Fornecedor.CodigoFornecedor = Produto.CodigoFornecedor 



Select Distinct 
       Cliente.PrimeiroNome+' '+ Cliente.SegundoNome as Cliente ,
       Produto.Titulo as Produto ,
	   Fornecedor.Nome as Fornecedor 
  From Cliente
  Join Pedido
    on Cliente.id = Pedido.IdCliente
  Join ItemPedido 
    on Pedido.id = ItemPedido.IdPedido
  Join Produto
    on ItemPedido.IdProduto = Produto.id
  Join Fornecedor
    on Fornecedor.id = Produto.IdFornecedor
   and Fornecedor.CodigoFornecedor = Produto.CodigoFornecedor 
 Order by Cliente, Produto, Fornecedor 

/*
Processamento L�gico.
*/

Select Distinct                                                  -- (10) Elimina as linhas duplicadas 
       Cliente.PrimeroNome+' '+ Cliente.SegundoNome as Cliente , -- (9)  Apresenta��o dos dados 
       Produto.Titulo as Produto ,
	   Fornecedor.Nome as Fornecedor 
  From Cliente                                                    -- (1) Produto Cartesiano entre Cliente e Pedido 
  Join Pedido                                                     --     
    on Cliente.id = Pedido.IdCliente                              -- (2) Filtro de Linhas e gera os dados em V1
  Join ItemPedido                                                 -- (3) Produto Cartesiano entre V1 e ItemPedido
    on Pedido.id = ItemPedido.IdPedido                            -- (4) Filtro de Linhas e gera os dados em V2
  Join Produto                                                    -- (5) Produto Cartesiano entre V2 e Produto 
    on ItemPedido.IdProduto = Produto.id                          -- (6) Filtro de Linhas e gera os dados em V3
  Join Fornecedor                                                 -- (7) Produto Cartesiano entre V3 e Fornecedor 
    on Fornecedor.id = Produto.IdFornecedor                       -- (8) Filtro de Linhas e gera os dados em V4
   and Fornecedor.CodigoFornecedor = Produto.CodigoFornecedor     --     Temos um Composite Join 
 Order by Cliente, Produto, Fornecedor                            -- (11) Mostra os dados ordenados

  
