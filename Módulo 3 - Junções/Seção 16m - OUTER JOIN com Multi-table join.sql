/*
Neste outro exemplo, vamos mostrar um erro na lógica que afeta a apresentação do dados.
Quando usamos a variação do join MULTI-TABLE JOIN com OUTER JOIN e INNER JOIN em sequência.

Vamos mostrar isso com um exemplo:

Existe uma instrução SELECT que deve mostrar os clientes (Nome,CPF e Endereco) do município do 
RIO DE JANEIRO e os itens de pedidos que eles adquiriram. Deve constar o ID do produto, 
quantidade e o preco unitário.

Todos os clientes do RIO DE JANEIRO devem ser mostrados, mesmo os que não fizeram pedido !!

Fazendo o mapeamente de PK e FK das tabelas com base do modelo, temos:

Tabela			PK		-->		Tabela			FK
--------------------------------------------------------------
Cliente			id		-->		Pedido			idCliente
Pedido			id		-->		ItemPedido		idPedido 

Temos 3 tabelas e 2 junções 

*/


use LojaVirtual
go

Select Cli.id as idCliente , 
       Cli.PrimeiroNome as Nome , 
	   Cli.CPF as CPF, 
	   Cli.Endereco as Endereco ,   
	   Cli.CEP as CEP ,
	   Cli.Municipio,
	   ----------------
	   Item.IdPedido ,
	   Item.Quantidade ,
	   Item.PrecoUnitario
  From Cliente as Cli
  Left Join Pedido as Ped
    On Cli.id = Ped.idCliente 
  Join ItemPedido as Item
    On Ped.id = Item.IdPedido
 Where Cli.Municipio = 'Rio de Janeiro'

 -- row : 153 

   
-- Como citei no começo, existe um erro de lógica aqui. 
-- Veja o resultado dos dados com a montagem da instrução.
-- O que pede a instrução está correto na apresentação dos dados?

WAITFOR DELAY '00:00:20'





/*
Veja que temos um OUTER JOIN entre Cliente e Pedido. 
Se temos um OUTER, temos que ter junto com a relação 
os clientes sem pedidos. 

Mas será que tem Clientes do Rio de Janeiro sem pedido? 

Vamos testar!!!

*/

Select Cli.id as idCliente , 
       Cli.PrimeiroNome as Nome , 
	   Cli.CPF as CPF, 
	   Cli.Endereco as Endereco ,   
	   Cli.CEP as CEP ,
	   Cli.Municipio,
	   Ped.id as idPedido 
  From Cliente as Cli
  Left Join Pedido as Ped
    On Cli.id = Ped.idCliente 
 Where Municipio = 'Rio de Janeiro'
   and ped.Id is null

/*
Sim, temos 8 clientes do Rio de Janeiro que não fizeram pedidos.
Mas por que então a consulta acima não mostra esses clientes? 

Vamos analisar somente o FROM... 

*/

select * 
  From Cliente as Cli           
  Left Join Pedido as Ped
    On Cli.id = Ped.idCliente 
  Join ItemPedido as Item
    On Ped.id = Item.IdPedido

/*
 Fase FROM        - Primeira fase da instrução, carrega a tabela Cliente.
 Fase LEFT JOIN   - Efetua o produto cartesiano com a tabela Pedido.

 Fase ON          - Efetua a junção interna entre as linhas de Cliente e Pedido.
                  - Como é um left, ele inclui as linhas de CLIENTES que não
		          - foram identificadas em Pedidos. Com isso ele preserva as linhas 
			      - da tabela a esquerda, que é a tabela CLIENTE. 
			      - As linhas da tabela a DIRETA, as colunas são apresentas 
			      - com valores NULL.
				  - Para fins didático, vou chamar os dados dessa fase de V1.
				  - Em V1 temos todas as colunas de clientes e todas as colunas de Pedido

 Fase  JOIN       - Efetua o produto cartesiano com resultado da fase anterior, 
                  - que são os dados em V1.

 Fase ON          - Efetua a junção interna entre as linhas de V1 e ItemPedido.
                  - Então é feito a comparação da coluna ID que está em V1 c
				  - com a columa IDPEDIDO que está na tabela ITEMPEDIDO. 
				  - Como é uma junção interna, o que está em V1 deve se
				  - relacionar com ITEMPEDIDO. 
 
 Veja que no final da fase ON (logo acima), os dados não apresentam mais os clientes
 que não tem pedido. 

 O motivo é que no segundo JOIN, foi realizado o INNER JOIN que obrigatoriamente
 deve encontrar as linhas que estão em V1 na tabela ITEMPEDIDO.

 Acontece que em V1, algumas linhas estão com NULL para a coluna PEDIDO.ID, 
 pois foi o resultado do primeiro JOIN ( do OUTER JOIN). 
 E elas não são encontradas em ItemPedido. 

 Com isso, os clientes sem pedidos não aparecem. 

 Novamente o efeito do OUTER JOIN foi eliminado pelo segundo JOIN. 
  
*/


/*
Mas como posso resolver isso !?! 

Vamos mostrar três formas de fazer isso !!!

Para resolver, podemos:

1. Um JOIN entre a tabela Pedido e a tabela ItemPedido e com o resultado 
   um OUTER JOIN com a tabela Cliente. 
   Neste caso o resultado da junção entre Pedido e ItemPedido fica 
   do lado LEFT do OUTER JOIN e a tabela Cliente fica do lado RIGHT do OUTER JOIN. 
   Como desejamos preservar os dados de Clientes, vamos usar 
   um Join MULTI-TABLE com INNER JOIN e RIGHT JOIN. 

*/

Select Cli.id as idCliente , 
       Cli.PrimeiroNome as Nome , 
	   Cli.CPF as CPF, 
	   Cli.Endereco as Endereco ,   
	   Cli.CEP as CEP ,
	   Cli.Municipio,
	   ----------------
	   Item.IdPedido ,
	   Item.Quantidade ,
	   Item.PrecoUnitario
  From Pedido as Ped
  Join ItemPedido as Item
    on Ped.id = Item.IdPedido
 Right Join Cliente as cli
    On Ped.idCliente = Cli.id  
 Where Municipio = 'Rio de Janeiro'


/*
2. Fazer é um LEFT OUTER JOIN da tabela Cliente com a tabela Pedido e esse 
   resultado, realizamos um outro LEFT OUTER JOIN com a tabela ItemPedido 
*/


Select Cli.id as idCliente , 
       Cli.PrimeiroNome as Nome , 
	   Cli.CPF as CPF, 
	   Cli.Endereco as Endereco ,   
	   Cli.CEP as CEP ,
	   Cli.Municipio,
	   ----------------
	   Item.IdPedido ,
	   Item.Quantidade ,
	   Item.PrecoUnitario
  From Cliente as Cli
  Left Join Pedido as Ped
    On Cli.id = Ped.idCliente 
  Left Join ItemPedido as Item
    On Ped.id = Item.IdPedido
 Where Municipio = 'Rio de Janeiro'


/*
3. Utilizamos a definição de prioridade na execução do join com parêntesis. 

Lembre-se que vimos na Aula "Multi-table join" que cada JOIN será executado da
esquerda para a direta. 

No nosso exemplo temos : 

*/
select * 

From Cliente as Cli
  Left Outer Join Pedido as Ped
    On Cli.id = Ped.idCliente 
 Inner Join ItemPedido as Item
    On Ped.id = Item.IdPedido

/*
Mas você pode definir a prioridade de execução utilizando o parêntesis.
Podemos então executar primeiro o JOIN entre Pedido e ItemPedido e
depois executar o JOIN com Cliente.

*/

Select Cli.id as idCliente , 
       Cli.PrimeiroNome as Nome , 
	   Cli.CPF as CPF, 
	   Cli.Endereco as Endereco ,   
	   Cli.CEP as CEP ,
	   Cli.Municipio,
	   ----------------
	   Item.IdPedido ,
	   Item.Quantidade ,
	   Item.PrecoUnitario
  From Cliente as Cli                     
  Left Join 
       (                                -- (1) Define a prioridade. 
          Pedido as Ped           
            Join ItemPedido as Item
              On Ped.id = Item.IdPedido
	   )
	On Cli.id = Ped.idCliente 
 Where Municipio = 'Rio de Janeiro'
  
/*
*/


 Select Cli.id as idCliente , 
       Cli.PrimeiroNome as Nome , 
	   Cli.CPF as CPF, 
	   Cli.Endereco as Endereco ,   
	   Cli.CEP as CEP ,
	   Cli.Municipio,
	   ----------------
	   Item.IdPedido ,
	   Item.Quantidade ,
	   Item.PrecoUnitario
   From Cliente as Cli                     
   Left Join Pedido as Ped           
   Join ItemPedido as Item
     On Ped.id = Item.IdPedido
	 On Cli.id = Ped.idCliente 
  Where Municipio = 'Rio de Janeiro'
