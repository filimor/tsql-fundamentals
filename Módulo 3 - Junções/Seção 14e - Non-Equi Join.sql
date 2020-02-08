/*

Non-Equi JOIN 

- Quando utilizamos no JOIN operadores de igualdade, falamos que os joins são
  de equivalência ou "Equi-Join", onde os dados de uma lado da tabela tem equivalência
  com os outros dados de outra tabela. 

- Quando utilizamos no JOIN outros operadores que não são o de igualdade, então dizemos
  que temos um "Non-equi Join" ou os joins não equivalentes.

  Exemplos

  Tabela1.ColunaA < Tabela2.ColunaA 
  Tabela1.ColunaA >= Tabela2.ColunaA 
  Tabela1.ColunaA <> Tabela2.ColunaA 

- Mantém todas as características do INNER JOIN.

- O predicado de filtro de linhas entre as duas tabelas
  pode ser realizado com a uma ou mais comparações. 

*/

/*
Exemplo 
*/

use dbExemplo
go


Select * 
  From Equipe as e1
  Join Equipe as e2
    on e1.time <> e2.time

select E1.Time , 
       'x' as Vs, 
	   E2.Time  
  from Equipe E1 
  join Equipe E2
    on E1.Time <> E2.Time 



select E1.Time , 
       'x' as Vs, 
	   E2.Time  
  from Equipe E1 
 cross join Equipe E2
 where E1.Time <> E2.Time 

 /*
 */

   

/*

Exemplo Prático 
*/

/*
Montar uma consulta que apresente os clientes e seus pedidos, mas somente os pedidos cujos valores
são maiores que a média do valor utilizado pelo cliente. 

Exemplo, se um cliente tem um valor médio de pedido de R$ 50,00, somente apresente os pedidos desse cliente com o 
valor igual ou maior que R$ 50,00

Apresentando a estrutura das tabelas.

Cliente:
id - chave primária que representa a identificação do cliente
PrimeiroNome - Nome do cliente
ValorMedio = Média dos valores dos pedidos com os descontos aplicados relacionados com o cliente.
DataUltPedido - Data do último pedido realizado pelo cliente. 

Pedido:
id - chave primária que representa a identificação do Pedido 
DataPedido - Data que o pedido foi criado.
Valor - Valor do pedido, sem a aplicação dos descontos. 
Desconto - Valor do desconto não aplicado sobre o valor do pedido. 

*/

use LojaVirtual
go

-- Vamos estudar um caso de um cliente para entendermos o processo. 

select PrimeiroNome, ValorMedio  from cliente where id = 33 
select Valor , desconto  from pedido where idcliente = 33

Select c.id            as idCliente  , 
       c.PrimeiroNome   as Nome , 
	   c.DataUltPedido as DataUltPedido, 
	   c.ValorMedio    as ValorMedio ,   
	   p.id            as idPedido , 
	   p.DataPedido    as DataPedido, 
	   p.Valor         as Valor 
  From Cliente as c
  Join Pedido as p
    On c.id = p.idCliente 
   And p.Valor  >= c.ValorMedio  
 Order by c.id, p.id 




/*
Processamento Lógico.
*/


Select c.id            as idCliente  ,       -- (3) Apresentação  
       c.PrimeiroNome  as Nome , 
	   c.DataUltPedido as DataUltPedido, 
	   c.ValorMedio    as ValorMedio ,   
	   p.id            as idPedido , 
	   p.DataPedido    as DataPedido, 
	   p.Valor         as Valor 
  From Cliente as c                          -- (1) Produto Cartesiano
  Join Pedido as p
    On c.id = p.idCliente                    -- (2) Filtro de linhas 
   And p.Valor >= c.ValorMedio                  --     Comparação não equivalente      
 Order by c.id, p.id                         -- (4) Ordenação 
