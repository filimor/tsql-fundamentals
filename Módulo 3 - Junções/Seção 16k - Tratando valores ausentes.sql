/*
As próximas aulas, iremos apresentar dicas de como montar as instruções
SELECT com join e evitar os chamados erros de lógica na montagem das instruções
*/

/*
Tratamento com valores ausentes nos dados reais.
------------------------------------------------

Certas pesquisas realizadas em tabelas, requer que você fabrique dados artificiais
para relacionar com dados reais que estão em tabelas. 

O exemplo que utilizaremos é realizado com base na seguinte regra de negócio:

Apresentar uma lista com os pedidos realizados diariamente no ano atual. Na lista
deve constar todos os dias, inclusive os dias que não houve realização de pedido.
Na lista deve contar a data do pedido, o número do pedido, a identificacao do cliente 
e o valor do pedido. 

Exemplo da lista:

Data                    Id          IdCliente   Valor
----------------------- ----------- ----------- -----------
2017-01-01 00:00:00.000 NULL        NULL        NULL
2017-01-02 00:00:00.000 10317310    34868       610.4542
2017-01-03 00:00:00.000 NULL        NULL        NULL
2017-01-04 00:00:00.000 10317372    34868       197.9249
2017-01-05 00:00:00.000 10318331    34868       88.4111
2017-01-06 00:00:00.000 10319443    34883       365.0197
2017-01-06 00:00:00.000 10319444    34883       71.3466
2017-01-07 00:00:00.000 NULL        NULL        NULL
2017-01-08 00:00:00.000 NULL        NULL        NULL
...
2017-09-20 00:00:00.000 10552123    35648       476.1708
2017-09-20 00:00:00.000 10552127    35648       272.6808
2017-09-21 00:00:00.000 NULL        NULL        NULL
2017-09-22 00:00:00.000 NULL        NULL        NULL
2017-09-23 00:00:00.000 NULL        NULL        NULL
2017-09-24 00:00:00.000 NULL        NULL        NULL
2017-09-25 00:00:00.000 NULL        NULL        NULL
2017-09-26 00:00:00.000 10557713    34913       274.8629
2017-09-26 00:00:00.000 10558449    34913       994.2949

*/

USE LojaVirtual
GO

Select DataPedido,Id, IDCliente,Valor  , Operacao 
  From Pedido 
 where DataPedido >= '2017-01-01'
 Order by DataPedido 


/*
1. Precisamos montar um lista com os dias desde 01/01/2017 até 26/09/2017.
2. Depois relacionar a data dessa lista com a data do pedido 
3. Se a data da lista não existir no pedido, mostrar a data da lista.
*/

/*
1. Montar uma lista com os dias desde  01/01/2017 
*/
use LojaVirtual

drop table if exists Numero
go

Create Table Numero (id int) 
insert into Numero (id) values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)

Select * from Numero


select (Cen.id * 100 ) + ( Dez.id*10 ) + uni.id as Dia 
  from Numero as Uni 
 cross join Numero as Dez 
 cross join Numero as Cen
 order by Dia

-- Considerando que 01/01/2017 é o dia 1. 
-- Qual é o dia do ano para a data 26/09/2017 ?

Select datepart(DAYOFYEAR,CAST('2017-09-26' AS DATETIME))

select (Cen.id * 100 ) + ( Dez.id*10 ) + Uni.id  as Dia 
  from Numero as Uni 
 cross join Numero as Dez 
 cross join Numero as Cen
 where (Cen.id * 100 ) + ( Dez.id*10 ) + Uni.id  <= datepart(DAYOFYEAR,CAST('2017-09-26' AS DATETIME))
 order by Dia 

/*
Como transformar o dia que está representado 
por um número em uma data 
*/

Select dateadd(d,1,'20170101')
Select dateadd(d,268,'20170101')


Select dateadd(d, ( Cen.id*100 ) + ( Dez.id*10 ) + Uni.id ,'20170101') as Data 
  From Numero as Uni 
 Cross join Numero as Dez 
 Cross join Numero as Cen
 Where (Cen.id*100) + (Dez.id*10) + Uni.id < datepart(DAYOFYEAR,CAST('2017-09-26' AS DATETIME))
 Order by Data 

/*
Como relacionar essa lista com data com a data do Pedido 
*/

Select dateadd(d, (Cen.id*100) + (Dez.id*10) + Uni.id ,'20170101') as Data ,
      Ped.Id , Ped.IdCliente , Ped.Valor
  From Numero as Uni 
 Cross join Numero as Dez 
 Cross join Numero as Cen
 Inner join Pedido as Ped
    on dateadd(d, (Cen.id*100) + (Dez.id*10) + Uni.id ,'20170101') = Ped.DataPedido
 Where (Cen.id*100) + (Dez.id*10) + Uni.id < datepart(DAYOFYEAR,CAST('2017-09-26' AS DATETIME))
 Order by Data , Ped.Id 


/*
Para mostrar os dias sem pedido, basta incluir as linhas
externas data lista com a data 
*/


Select dateadd(d, (Cen.id*100) + (Dez.id*10) + Uni.id ,'20170101') as Data ,
      Ped.Id , Ped.IdCliente , Ped.Valor
  From Numero as Uni 
 Cross join Numero as Dez 
 Cross join Numero as Cen
  Left Join Pedido as Ped
    on dateadd(d, (Cen.id*100) + (Dez.id*10) + Uni.id ,'20170101') = Ped.DataPedido
 Where (Cen.id*100) + (Dez.id*10) + Uni.id < datepart(DAYOFYEAR,CAST('2017-09-26' AS DATE))
 Order by Data , Ped.Id 




