/*
Agora vamos ver o uso de funções de agregação com a instrução
GROUP BY e utilizando o OUTER JOIN. 

Sim, teremos aqui mais erros de lógica na montagem da instrução.

Em muitos casos de montarmos uma instrução SELECT, podemos atender
a solicitação de totalização por algum grupo. Alguns exemplos:

1. A quantidade de clientes em cada Estado 
2. Uma relação de todos os clientes e a quantidade de pedidos.

*/
use LojaVirtual
go

/*
1. A quantidade de clientes em cada Estado.

- Vamos lembrar então como montar a instrução com agrupamento. 

*/

Select * from Cliente


Select UF , 
       Count(*) as Quantidade -- Contagem de linhas dentro do agrupamento.
  From Cliente 
 Group by UF   -- Coluna UF utilizada para fazer o agrupamento.
 Order by Quantidade Desc 

-- COUNT(*) conta a linha inteira. Conta a existência da linha,
--          não importa a quantidade de colunas e o conteúdo delas !!!

/*
2. Uma relação de todos os clientes e a quantidade de pedidos.

Primeiro vamos realizar a junção com OUTER JOIN, para apresentar
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
O Resultado apresentado pode ser o correto, já que para cada cliente ele mostrou
a quantidade de pedidos que cada um está relacionado. 

Mas é os clientes que não tiveram pedidos? Como deve aparecer a quantidade?

Voce deve pensar, como é um LEFT OUTER JOIN, a quantidade de pedidos deve ser null !!

Vamos validar! É só testar se a quantidade de pedido "is null"
*/

Select Cliente.PrimeiroNome as Nome , CPF , 
       count(*) as QuantidadePedido 
  From Cliente 
  Left Outer Join Pedido 
    on Cliente.ID = Pedido.IdCliente 

 Group by Cliente.PrimeiroNome , CPF 

 Having count(*) = 0

/*
Vamos então analisar um cliente específico que não tem pedido
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
Mas pelo SELECT anterior, esse cliente não tem pedido
e no último SELECT mostra que tem 1 pedido ???
*/



/*
O erro de lógica está no uso do COUNT.

COUNT(*) conta a linha inteira. Conta a existência da linha,
não importa a quantidade de colunas e o conteúdo delas !!!

O Correto então neste caso é utilizar o COUNT para contar o
conteúdo de uma coluna. COUNT(<Coluna>) 

Se corrigirmos a instrução, com o código abaixo:

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
Então a função fez a contagem dessa linha.

A solução correta é realizar a contagem com uma coluna que informar que o cliente
não tem pedido. Então, o correto seria COUNT(Pedido.ID) 
*/

Select Cliente.PrimeiroNome as Nome , CPF  ,
       count(Pedido.ID) as QuantidadePedido 
  From Cliente 
  Left Outer Join Pedido 
    on Cliente.ID = Pedido.IdCliente 
Where  Cliente.CPF = '193.311.748-89'
 Group by Cliente.PrimeiroNome , CPF  

--- Solução correta !!

Select Cliente.PrimeiroNome as Nome , CPF , 
       count(Pedido.ID) as QuantidadePedido 
  From Cliente 
  Left Join Pedido 
    on Cliente.ID = Pedido.IdCliente 
 Group by Cliente.PrimeiroNome, CPF 
 Order by Nome 

/*
Pergunta : 
Quais são as colunas válidas para colocar em um COUNT() quando utilizamos
OUTER JOIN e desejamos totalizar uma agregação e apresentar esses valores 
corretamente? 


 - Chave Primária
 - Coluna que fazem parte do ON
 - Coluna definida como NOT NULL

Por exemplo, com uma coluna definida com NULL 
do lado direito do OUTER JOIN (lado não preservado) 

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

