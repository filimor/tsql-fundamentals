/*
Neste outro exemplo, vamos mostrar um erro na l�gica que afeta a apresenta��o do dados.
Quando usamos a varia��o do join MULTI-TABLE JOIN com OUTER JOIN e INNER JOIN em sequ�ncia.

Vamos mostrar isso com um exemplo:

Existe uma instru��o SELECT que deve mostrar os clientes (Nome,CPF e Endereco) do munic�pio do 
RIO DE JANEIRO e os itens de pedidos que eles adquiriram. Deve constar o ID do produto, 
quantidade e o preco unit�rio.

Todos os clientes do RIO DE JANEIRO devem ser mostrados, mesmo os que n�o fizeram pedido !!

Fazendo o mapeamente de PK e FK das tabelas com base do modelo, temos:

Tabela			PK		-->		Tabela			FK
--------------------------------------------------------------
Cliente			id		-->		Pedido			idCliente
Pedido			id		-->		ItemPedido		idPedido 

Temos 3 tabelas e 2 jun��es 

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

   
-- Como citei no come�o, existe um erro de l�gica aqui. 
-- Veja o resultado dos dados com a montagem da instru��o.
-- O que pede a instru��o est� correto na apresenta��o dos dados?

WAITFOR DELAY '00:00:20'





/*
Veja que temos um OUTER JOIN entre Cliente e Pedido. 
Se temos um OUTER, temos que ter junto com a rela��o 
os clientes sem pedidos. 

Mas ser� que tem Clientes do Rio de Janeiro sem pedido? 

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
Sim, temos 8 clientes do Rio de Janeiro que n�o fizeram pedidos.
Mas por que ent�o a consulta acima n�o mostra esses clientes? 

Vamos analisar somente o FROM... 

*/

select * 
  From Cliente as Cli           
  Left Join Pedido as Ped
    On Cli.id = Ped.idCliente 
  Join ItemPedido as Item
    On Ped.id = Item.IdPedido

/*
 Fase FROM        - Primeira fase da instru��o, carrega a tabela Cliente.
 Fase LEFT JOIN   - Efetua o produto cartesiano com a tabela Pedido.

 Fase ON          - Efetua a jun��o interna entre as linhas de Cliente e Pedido.
                  - Como � um left, ele inclui as linhas de CLIENTES que n�o
		          - foram identificadas em Pedidos. Com isso ele preserva as linhas 
			      - da tabela a esquerda, que � a tabela CLIENTE. 
			      - As linhas da tabela a DIRETA, as colunas s�o apresentas 
			      - com valores NULL.
				  - Para fins did�tico, vou chamar os dados dessa fase de V1.
				  - Em V1 temos todas as colunas de clientes e todas as colunas de Pedido

 Fase  JOIN       - Efetua o produto cartesiano com resultado da fase anterior, 
                  - que s�o os dados em V1.

 Fase ON          - Efetua a jun��o interna entre as linhas de V1 e ItemPedido.
                  - Ent�o � feito a compara��o da coluna ID que est� em V1 c
				  - com a columa IDPEDIDO que est� na tabela ITEMPEDIDO. 
				  - Como � uma jun��o interna, o que est� em V1 deve se
				  - relacionar com ITEMPEDIDO. 
 
 Veja que no final da fase ON (logo acima), os dados n�o apresentam mais os clientes
 que n�o tem pedido. 

 O motivo � que no segundo JOIN, foi realizado o INNER JOIN que obrigatoriamente
 deve encontrar as linhas que est�o em V1 na tabela ITEMPEDIDO.

 Acontece que em V1, algumas linhas est�o com NULL para a coluna PEDIDO.ID, 
 pois foi o resultado do primeiro JOIN ( do OUTER JOIN). 
 E elas n�o s�o encontradas em ItemPedido. 

 Com isso, os clientes sem pedidos n�o aparecem. 

 Novamente o efeito do OUTER JOIN foi eliminado pelo segundo JOIN. 
  
*/


/*
Mas como posso resolver isso !?! 

Vamos mostrar tr�s formas de fazer isso !!!

Para resolver, podemos:

1. Um JOIN entre a tabela Pedido e a tabela ItemPedido e com o resultado 
   um OUTER JOIN com a tabela Cliente. 
   Neste caso o resultado da jun��o entre Pedido e ItemPedido fica 
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
2. Fazer � um LEFT OUTER JOIN da tabela Cliente com a tabela Pedido e esse 
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
3. Utilizamos a defini��o de prioridade na execu��o do join com par�ntesis. 

Lembre-se que vimos na Aula "Multi-table join" que cada JOIN ser� executado da
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
Mas voc� pode definir a prioridade de execu��o utilizando o par�ntesis.
Podemos ent�o executar primeiro o JOIN entre Pedido e ItemPedido e
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
