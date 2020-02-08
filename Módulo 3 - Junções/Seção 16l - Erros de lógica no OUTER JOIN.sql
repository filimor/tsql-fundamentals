-- Erros de l�gica no OUTER JOIN 

/*
Quando estamos trabalhando com OUTER JOIN, podemos cair em v�rios  
erros de l�gica como quando montamos um instru��o e sua execu��o n�o apresenta
erro, mas os dados retornados n�o era o esperado. 

Ou quando montamos uma instru��o SELECT, mas quando aplicamos um filtro no 
WHERE, fazemos com que o uso do OUTER JOIN fosse desnecess�rio.

Vamos para alguns exemplos:
*/


/*
PRIMEIRO EXEMPLO: 
------------------

Filtrando linhas usando colunas do lado n�o preservado.

Para demonstrar um erro comum no desenvolvimento de instru��es SELECT com OUTER JOIN,
vamos utilizar um exemplo onde temos que extrair as informa��es dos clientes que nunca
fizeram um pedido.

A consulta deve mostrar os dados de clientes e para saber se ele tem ou n�o pedido,
temos que montar a instru��o SELECT da tabela cliente com a tabela Pedido. 

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
 No caso acima, a montagem da senten�a parece correta. 

 O filtro aplicado foi 

     Where p.DataEntrega is null 

 Estamos usando um fitro de uma coluna do lado direito do JOIN (no caso a tabela Pedido) 
 e vimos que se a coluna do lado direto estiver com NULL, significa que as linha 
 externas (no caso LEFT, tabela CLIENTE) que foram inclu�das n�o tem rela��o com as linhas
 da tabela do lado direito.

 Ent�o fa�o uma pergunta para voc�s. 
 
 A coluna DataEntrega da tabela Pedido somente ter� NULL no 
 resultado do SELECT e nunca ter� NULL armazenado na tabela? 
 */

 select * from pedido where DataEntrega is  null


 /*
 Quais s�o as colunas que devemos utilizar para filtrar linhas do lado direito?

 - Chave Prim�ria
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
 Where p.Id is null -- ID do Pedido que � PK


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
 Where p.operacao is null  -- Operacao que n�o aceita valor NULL.
 

 /*

 */

 
 -- 1. Criar um relat�rio com todos os clientes e para os que tem pedido a data de entrega e valor.

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

Um relat�rio que apresente os todos clientes cidade de S�o Paulo e seus pedidos, 
foi criado por um programador a mais de 5 anos. Na �poca esse relat�rio
atendia a necessidade solicitada. 
Esse programador j� n�o trabalha mais na empresa por um bom tempo. 

Foi solicitado para um outro programador novato que realizasse a altera��o no 
c�digo para mostrar somente os clientes com os pedidos feito nos �ltimos 5 anos.

*/


-- Abaixo voce tem o c�digo original criado a 5 anos atr�s.

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


-- Esse c�digo foi o alterador pelo programador novato para atender a nova regra de neg�cio


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
Existe um erro na l�gica na escrita do c�digo acima.

Quando o programador novato realizou a altera��o no c�digo, ele simples fez que foi pedido e claro, 
atingiu o objetivo.  Na apresenta��o dos dados n�o tem erro, j� que os dados s�o realmente os dos 
�ltimo cinco anos.

Mas ent�o, o que est� errado no c�digo??
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
 Fase FROM     - Primeira fase da instru��o, carrega a tabela Cliente.
 Fase JOIN     - Efetua o produto cartesiano com a tabela Pedido.

 Fase ON       - Efetua a jun��o interna entre as linhas de Cliente e Pedido.
               - Como � um left, ele inclui as linhas de CLIENTES que n�o
		       - foram identificadas em Pedidos. Com isso ele preserva as linhas 
			   - da tabela a esquerda, que � a tabela CLIENTE. 
			   - As linhas da tabela a DIRETA, as colunas s�o apresentas 
			   - com valores NULL.

 Fase WHERE    - Aplica o conceito de curto-circuito. As express�es de compara��o
               - que consume o menor recurso s�o executas primeiro. 
			   - Uma das express�es e DataPedido dos ultimo 5 anos.

 Fase SELECT   - Apresenta o dados
 Fase ORDER BY - Ordena os dados apresentados

 O erro l�gico est� justamente onde o novato efetuou a altera��o.
 A express�o: 

 p.DataPedido >= dateadd(year,-5,getdate())

 Est� filtrando as linhas que tem uma data na coluna DataPedido. 
 Mas para as linhas preservadas do lado LEFT (tabela cliente), essas linhas tem 
 o valor NULL para a coluna DataPedido !!!

 Esse � o erro l�gico.

 A partir do momento em que se coloca uma express�o de compara��o no 
 WHERE que filtra uma coluna do lado n�o preservado, o OUTER JOIN 
 perde totalmente o sentido. 
 

 */


-- Forma correta de corre��o ser� : 

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

Mas � se fosse solicitado para um outro programador novato que realizasse 
a altera��o no c�digo para continuar a mostrar "todos" os clientes 
com os pedidos feito nos �ltimos 5 anos??

Tem um aula somente desse assunto : Quando usar o ON ou o WHERE como filtro de linha. 

L� explico isso com detalhes!!

*/ 
 



