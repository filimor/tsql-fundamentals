/*

Non-Equi JOIN 

- Quando utilizamos no JOIN operadores de igualdade, falamos que os joins s�o
  de equival�ncia ou "Equi-Join", onde os dados de uma lado da tabela tem equival�ncia
  com os outros dados de outra tabela. 

- Quando utilizamos no JOIN outros operadores que n�o s�o o de igualdade, ent�o dizemos
  que temos um "Non-equi Join" ou os joins n�o equivalentes.

  Exemplos

  Tabela1.ColunaA < Tabela2.ColunaA 
  Tabela1.ColunaA >= Tabela2.ColunaA 
  Tabela1.ColunaA <> Tabela2.ColunaA 

- Mant�m todas as caracter�sticas do INNER JOIN.

- O predicado de filtro de linhas entre as duas tabelas
  pode ser realizado com a uma ou mais compara��es. 

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

Exemplo Pr�tico 
*/

/*
Montar uma consulta que apresente os clientes e seus pedidos, mas somente os pedidos cujos valores
s�o maiores que a m�dia do valor utilizado pelo cliente. 

Exemplo, se um cliente tem um valor m�dio de pedido de R$ 50,00, somente apresente os pedidos desse cliente com o 
valor igual ou maior que R$ 50,00

Apresentando a estrutura das tabelas.

Cliente:
id - chave prim�ria que representa a identifica��o do cliente
PrimeiroNome - Nome do cliente
ValorMedio = M�dia dos valores dos pedidos com os descontos aplicados relacionados com o cliente.
DataUltPedido - Data do �ltimo pedido realizado pelo cliente. 

Pedido:
id - chave prim�ria que representa a identifica��o do Pedido 
DataPedido - Data que o pedido foi criado.
Valor - Valor do pedido, sem a aplica��o dos descontos. 
Desconto - Valor do desconto n�o aplicado sobre o valor do pedido. 

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
Processamento L�gico.
*/


Select c.id            as idCliente  ,       -- (3) Apresenta��o  
       c.PrimeiroNome  as Nome , 
	   c.DataUltPedido as DataUltPedido, 
	   c.ValorMedio    as ValorMedio ,   
	   p.id            as idPedido , 
	   p.DataPedido    as DataPedido, 
	   p.Valor         as Valor 
  From Cliente as c                          -- (1) Produto Cartesiano
  Join Pedido as p
    On c.id = p.idCliente                    -- (2) Filtro de linhas 
   And p.Valor >= c.ValorMedio                  --     Compara��o n�o equivalente      
 Order by c.id, p.id                         -- (4) Ordena��o 
