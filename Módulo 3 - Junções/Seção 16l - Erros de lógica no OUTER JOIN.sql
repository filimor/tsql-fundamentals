-- Erros de lógica no OUTER JOIN 

/*
Quando estamos trabalhando com OUTER JOIN, podemos cair em vários  
erros de lógica como quando montamos um instrução e sua execução não apresenta
erro, mas os dados retornados não era o esperado. 

Ou quando montamos uma instrução SELECT, mas quando aplicamos um filtro no 
WHERE, fazemos com que o uso do OUTER JOIN fosse desnecessário.

Vamos para alguns exemplos:
*/


/*
PRIMEIRO EXEMPLO: 
------------------

Filtrando linhas usando colunas do lado não preservado.

Para demonstrar um erro comum no desenvolvimento de instruções SELECT com OUTER JOIN,
vamos utilizar um exemplo onde temos que extrair as informações dos clientes que nunca
fizeram um pedido.

A consulta deve mostrar os dados de clientes e para saber se ele tem ou não pedido,
temos que montar a instrução SELECT da tabela cliente com a tabela Pedido. 

*/


Use LojaVirtual
go

Select c.id            as idCliente  , 
       c.PrimeiroNome  as Nome , 
	   c.CPF           as CPF, 
	   c.Endereco      as Endereco,   
	   c.CEP           as CEP ,
	   p.id            as idPedido , 
	   p.DataEntrega   as DataEntrega, 
	   p.Valor         as Valor 
  From Cliente as c 
  Left Join Pedido as p
    On c.id = p.idCliente 
 Where p.DataEntrega is null 
 Order by p.id 

 select count(*) from cliente

 

 /*
 No caso acima, a montagem da sentença parece correta. 

 O filtro aplicado foi 

     Where p.DataEntrega is null 

 Estamos usando um fitro de uma coluna do lado direito do JOIN (no caso a tabela Pedido) 
 e vimos que se a coluna do lado direto estiver com NULL, significa que as linha 
 externas (no caso LEFT, tabela CLIENTE) que foram incluídas não tem relação com as linhas
 da tabela do lado direito.

 Então faço uma pergunta para vocês. 
 
 A coluna DataEntrega da tabela Pedido somente terá NULL no 
 resultado do SELECT e nunca terá NULL armazenado na tabela? 
 */

 select * from pedido where DataEntrega is  null


 /*
 Quais são as colunas que devemos utilizar para filtrar linhas do lado direito?

 - Chave Primária
 - Coluna que fazem parte do ON
 - Coluna definida como NOT NULL
 */


 
Select c.id            as idCliente  , 
       c.PrimeiroNome   as Nome , 
	   c.CPF           as CPF, 
	   c.Endereco      as Endereco ,   
	   c.CEP           as CEP ,
	   p.id            as idPedido , 
	   p.DataEntrega   as DataEntrega, 
	   p.Valor         as Valor 
  From Cliente as c
  Left Outer Join Pedido as p
    On c.id = p.idCliente 
 Where p.Id is null -- ID do Pedido que é PK


Select c.id            as idCliente  , 
       c.PrimeiroNome   as Nome , 
	   c.CPF           as CPF, 
	   c.Endereco      as Endereco ,   
       c.CEP           as CEP ,
	   p.id            as idPedido , 
	   p.DataEntrega   as DataEntrega, 
	   p.Valor         as Valor 
  From Cliente as c
  Left Outer Join Pedido as p
    On c.id = p.idCliente 
 Where p.idCliente  is null -- iDCliente que faz parte do ON 


Select c.id            as idCliente  , 
       c.PrimeiroNome   as Nome , 
	   c.CPF           as CPF, 
	   c.Endereco      as Endereco ,   
	   c.CEP           as CEP ,
	   p.id            as idPedido , 
	   p.DataEntrega   as DataEntrega, 
	   p.Valor         as Valor 
  From Cliente as c
  Left Outer Join Pedido as p
    On c.id = p.idCliente 
 Where p.operacao is null  -- Operacao que não aceita valor NULL.
 

 /*

 */

 
 -- 1. Criar um relatório com todos os clientes e para os que tem pedido a data de entrega e valor.

Select c.id            as idCliente  , 
       c.PrimeiroNome   as Nome , 
	   c.CPF           as CPF, 
	   c.Endereco      as Endereco ,   
	   c.CEP           as CEP ,
	   p.id            as idPedido , 
	   p.DataEntrega   as DataEntrega, 
	   p.Valor         as Valor 
  From Cliente as c
  Left Outer Join Pedido as p
    On c.id = p.idCliente 

/*
SEGUNDO EXEMPLO:

Um relatório que apresente os todos clientes cidade de São Paulo e seus pedidos, 
foi criado por um programador a mais de 5 anos. Na época esse relatório
atendia a necessidade solicitada. 
Esse programador já não trabalha mais na empresa por um bom tempo. 

Foi solicitado para um outro programador novato que realizasse a alteração no 
código para mostrar somente os clientes com os pedidos feito nos últimos 5 anos.

*/


-- Abaixo voce tem o código original criado a 5 anos atrás.

Use LojaVirtual
go


Select c.id as idCliente , 
       c.PrimeiroNome as Nome , 
	   c.CPF as CPF, 
	   c.Endereco as Endereco ,   
	   c.CEP as CEP ,
	   p.id  as idPedido , 
	   p.DataPedido as DataPedido, 
	   p.Valor  as Valor 
  From Cliente as c
  Left Join Pedido as p
    On c.id = p.idCliente 
 Where c.UF = 'SP'
   and Substring(c.cep,1,1) = '0'
 order by Nome 


-- Esse código foi o alterador pelo programador novato para atender a nova regra de negócio


Select c.id as idCliente  , 
       c.PrimeiroNome as Nome , 
	   c.CPF as CPF, 
	   c.Endereco as Endereco ,   
	   c.CEP as CEP ,
	   p.id  as idPedido , 
	   p.DataPedido as DataPedido, 
	   p.Valor  as Valor 
  From Cliente as c
  Left Join Pedido as p
    On c.id = p.idCliente 
 Where UF = 'SP'
   and Substring(cep,1,1) = '0'
   and p.DataPedido >= dateadd(year,-5,getdate())
 Order by Nome

 

/*
Existe um erro na lógica na escrita do código acima.

Quando o programador novato realizou a alteração no código, ele simples fez que foi pedido e claro, 
atingiu o objetivo.  Na apresentação dos dados não tem erro, já que os dados são realmente os dos 
último cinco anos.

Mas então, o que está errado no código??
*/



Select c.id as idCliente  ,        c.PrimeiroNome as Nome , 
	   c.CPF as CPF, 	   c.Endereco as Endereco ,   
	   c.CEP as CEP ,	   p.id  as idPedido , 
	   p.DataPedido as DataPedido, 	   p.Valor  as Valor 
  From Cliente as c
  Left Outer Join Pedido as p
    On c.id = p.idCliente 
 Where UF = 'SP'
   and Substring(cep,1,1) = '0'
   and p.DataPedido >= dateadd(year,-5,getdate())
 Order by Nome

 /*
 Fase FROM     - Primeira fase da instrução, carrega a tabela Cliente.
 Fase JOIN     - Efetua o produto cartesiano com a tabela Pedido.

 Fase ON       - Efetua a junção interna entre as linhas de Cliente e Pedido.
               - Como é um left, ele inclui as linhas de CLIENTES que não
		       - foram identificadas em Pedidos. Com isso ele preserva as linhas 
			   - da tabela a esquerda, que é a tabela CLIENTE. 
			   - As linhas da tabela a DIRETA, as colunas são apresentas 
			   - com valores NULL.

 Fase WHERE    - Aplica o conceito de curto-circuito. As expressões de comparação
               - que consume o menor recurso são executas primeiro. 
			   - Uma das expressões e DataPedido dos ultimo 5 anos.

 Fase SELECT   - Apresenta o dados
 Fase ORDER BY - Ordena os dados apresentados

 O erro lógico está justamente onde o novato efetuou a alteração.
 A expressão: 

 p.DataPedido >= dateadd(year,-5,getdate())

 Está filtrando as linhas que tem uma data na coluna DataPedido. 
 Mas para as linhas preservadas do lado LEFT (tabela cliente), essas linhas tem 
 o valor NULL para a coluna DataPedido !!!

 Esse é o erro lógico.

 A partir do momento em que se coloca uma expressão de comparação no 
 WHERE que filtra uma coluna do lado não preservado, o OUTER JOIN 
 perde totalmente o sentido. 
 

 */


-- Forma correta de correção será : 

 Select c.id as idCliente  , 
       c.PrimeiroNome as Nome , 
	   c.CPF as CPF, 
	   c.Endereco as Endereco ,   
	   c.CEP as CEP ,
	   p.id  as idPedido , 
	   p.DataPedido as DataPedido, 
	   p.Valor  as Valor 
  From Cliente as c
  Join Pedido as p
    On c.id = p.idCliente 
 Where UF = 'SP'
   and Substring(cep,1,1) = '0'
   and p.DataPedido >= dateadd(year,-5,getdate())
 Order by Nome



/*
Ai voce pode perguntar : 

Mas é se fosse solicitado para um outro programador novato que realizasse 
a alteração no código para continuar a mostrar "todos" os clientes 
com os pedidos feito nos últimos 5 anos??

Tem um aula somente desse assunto : Quando usar o ON ou o WHERE como filtro de linha. 

Lá explico isso com detalhes!!

*/ 
 



