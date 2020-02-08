/*
Agora vamos ver o uso de fun��es de agrega��o com a instru��o
GROUP BY e utilizando o OUTER JOIN. 

Sim, teremos aqui mais erros de l�gica na montagem da instru��o.

Em muitos casos de montarmos uma instru��o SELECT, podemos atender
a solicita��o de totaliza��o por algum grupo. Alguns exemplos:

1. A quantidade de clientes em cada Estado 
2. Uma rela��o de todos os clientes e a quantidade de pedidos.

*/
use LojaVirtual
go

/*
1. A quantidade de clientes em cada Estado.

- Vamos lembrar ent�o como montar a instru��o com agrupamento. 

*/

Select * from Cliente


Select UF , 
       Count(*) as Quantidade -- Contagem de linhas dentro do agrupamento.
  From Cliente 
 Group by UF   -- Coluna UF utilizada para fazer o agrupamento.
 Order by Quantidade Desc 

-- COUNT(*) conta a linha inteira. Conta a exist�ncia da linha,
--          n�o importa a quantidade de colunas e o conte�do delas !!!

/*
2. Uma rela��o de todos os clientes e a quantidade de pedidos.

Primeiro vamos realizar a jun��o com OUTER JOIN, para apresentar
todos os clientes, conforme solicitado e os pedidos. 

*/

Select Cliente.PrimeiroNome as Nome , CPF , 
       Pedido.Id as idPedido 
  From Cliente 
  Left Join Pedido 
    on Cliente.ID = Pedido.IdCliente 

-- Resposta 

Select Cliente.PrimeiroNome as Nome , CPF , 
       count(*) as QuantidadePedido 
  From Cliente 
  Left Join Pedido 
    on Cliente.ID = Pedido.IdCliente 
 Group by Cliente.PrimeiroNome, Cliente.CPF 
 Order by Nome 
 
	
/*
O Resultado apresentado pode ser o correto, j� que para cada cliente ele mostrou
a quantidade de pedidos que cada um est� relacionado. 

Mas � os clientes que n�o tiveram pedidos? Como deve aparecer a quantidade?

Voce deve pensar, como � um LEFT OUTER JOIN, a quantidade de pedidos deve ser null !!

Vamos validar! � s� testar se a quantidade de pedido "is null"
*/

Select Cliente.PrimeiroNome as Nome , CPF , 
       count(*) as QuantidadePedido 
  From Cliente 
  Left Outer Join Pedido 
    on Cliente.ID = Pedido.IdCliente 

 Group by Cliente.PrimeiroNome , CPF 

 Having count(*) = 0

/*
Vamos ent�o analisar um cliente espec�fico que n�o tem pedido
e ver como ele se comportou. 

*/

Select Cliente.PrimeiroNome as Nome , CPF , 
       Pedido.Id as idPedido 
  From Cliente 
  Left Outer Join Pedido 
    on Cliente.ID = Pedido.IdCliente 

Select Cliente.PrimeiroNome as Nome , CPF , 
       count(*) as QuantidadePedido 
  From Cliente 
  Left Outer Join Pedido 
    on Cliente.ID = Pedido.IdCliente 
Where Cliente.CPF = '193.311.748-89'
 Group by Cliente.PrimeiroNome , CPF  


/*
Mas pelo SELECT anterior, esse cliente n�o tem pedido
e no �ltimo SELECT mostra que tem 1 pedido ???
*/



/*
O erro de l�gica est� no uso do COUNT.

COUNT(*) conta a linha inteira. Conta a exist�ncia da linha,
n�o importa a quantidade de colunas e o conte�do delas !!!

O Correto ent�o neste caso � utilizar o COUNT para contar o
conte�do de uma coluna. COUNT(<Coluna>) 

Se corrigirmos a instru��o, com o c�digo abaixo:

*/

Select Cliente.PrimeiroNome as Nome , CPF  ,
       count(Cliente.ID) as QuantidadePedido 
  From Cliente 
  Left Join Pedido 
    on Cliente.ID = Pedido.IdCliente 
Where  Cliente.CPF = '193.311.748-89'
 Group by Cliente.PrimeiroNome , CPF  


-- Mas continua apresentando 1 para a quantidade de Pedido !!!!

/*
Quando usamos o COUNT(<Coluna>), ele considera o valor da coluna 
como verdadeiro para efeito de contagem. No caso de COUNT(Cliente.ID), 
a coluna Cliente.ID tem o valor 27591.
Ent�o a fun��o fez a contagem dessa linha.

A solu��o correta � realizar a contagem com uma coluna que informar que o cliente
n�o tem pedido. Ent�o, o correto seria COUNT(Pedido.ID) 
*/

Select Cliente.PrimeiroNome as Nome , CPF  ,
       count(Pedido.ID) as QuantidadePedido 
  From Cliente 
  Left Outer Join Pedido 
    on Cliente.ID = Pedido.IdCliente 
Where  Cliente.CPF = '193.311.748-89'
 Group by Cliente.PrimeiroNome , CPF  

--- Solu��o correta !!

Select Cliente.PrimeiroNome as Nome , CPF , 
       count(Pedido.ID) as QuantidadePedido 
  From Cliente 
  Left Join Pedido 
    on Cliente.ID = Pedido.IdCliente 
 Group by Cliente.PrimeiroNome, CPF 
 Order by Nome 

/*
Pergunta : 
Quais s�o as colunas v�lidas para colocar em um COUNT() quando utilizamos
OUTER JOIN e desejamos totalizar uma agrega��o e apresentar esses valores 
corretamente? 


 - Chave Prim�ria
 - Coluna que fazem parte do ON
 - Coluna definida como NOT NULL

Por exemplo, com uma coluna definida com NULL 
do lado direito do OUTER JOIN (lado n�o preservado) 

*/


Select Cliente.PrimeiroNome as Nome , CPF , 
       Pedido.Id as idPedido  , DataEntrega
  From Cliente 
  Left Outer Join Pedido 
    on Cliente.ID = Pedido.IdCliente 
 Where Cliente.CPF = '992.867.868-23'


 Select Cliente.PrimeiroNome as Nome , CPF  ,
       count(Pedido.DataEntrega ) as QuantidadePedido 
  From Cliente 
  Left Outer Join Pedido 
    on Cliente.ID = Pedido.IdCliente 
Where Cliente.CPF = '992.867.868-23'
 Group by Cliente.PrimeiroNome , CPF  

  Select Cliente.PrimeiroNome as Nome , CPF  ,
       count(Pedido.Id) as QuantidadePedido 
  From Cliente 
  Left Outer Join Pedido 
    on Cliente.ID = Pedido.IdCliente 
Where Cliente.CPF = '992.867.868-23'
 Group by Cliente.PrimeiroNome , CPF  

