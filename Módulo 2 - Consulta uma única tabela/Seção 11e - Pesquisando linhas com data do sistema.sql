/*
Para simularmos uma pesquisa com data e hora, vamos criar um massa de dado 
com base na data atual do seu computador para criar a data de pedido. 

Como desejo que voce simule os dados com base na data que voce está vendo esse vídeo, não tenho
outro opção se não de  executar os script abaixo para fazer essa simulação. 
Com isso, os dados estarão na data e hora que voce executar as instruções abaixo.
*/

select getdate()

/*
Inicio da Geração 
*/

use DBExemplo
go
drop table if exists dbo.Pedido
go

-- Inicio

Select iIDPedido, iIDCliente, iIDEmpregado, 
       cast( null as datetime) as DataPedido, 
	   cast( null as datetime) as DataRequisicao ,  
	   cast( null as datetime) as DataEnvio,   
	   iIDRemetente, Frete, shipname, shipaddress, shipCidade, shipregion, shipCEP, shipPais 
  into Pedido 
  From Fundamentostsql.Vendas.Pedido 
go

declare @DataReferencia datetime = cast(cast(getdate() as decimal(12,6) ) - rand()/2 as datetime)

update top(1) pedido 
   set DataPedido     = @DataReferencia ,
       DataRequisicao = @DataReferencia - (rand()*5)-1 ,
       DataEnvio      = @DataReferencia + (rand()*10)+1 
 where DataPedido is null
go 5

declare @DataReferencia datetime = cast( cast(getdate() as int)-2 + rand()*1 as datetime)

update top(1) pedido 
   set DataPedido     = @DataReferencia ,
       DataRequisicao = @DataReferencia - (rand()*5)-1 ,
       DataEnvio      = @DataReferencia + (rand()*10)+1 
 where DataPedido is null
go 5


declare @DataReferencia datetime = cast((cast(getdate() as int)-31)+ rand()*31 as datetime)

update top(1) pedido 
   set DataPedido     = @DataReferencia ,
       DataRequisicao = @DataReferencia - (rand()*5)-1 ,
       DataEnvio      = @DataReferencia + (rand()*10)+1 
 where DataPedido is null
go 100

declare @DataReferencia datetime = cast((cast(getdate() as int)-731)+ rand()*731 as datetime)

update top(1) pedido 
   set DataPedido     = @DataReferencia ,
       DataRequisicao = @DataReferencia - (rand()*5)-1 ,
       DataEnvio      = @DataReferencia + (rand()*10)+1 
 where DataPedido is null
go 720

update Pedido set DataEnvio = null 
   where DataEnvio >= getdate()
update Pedido set DataPedido = dateadd(second, -datediff(SECOND,getdate(),DataPedido) , datapedido)
     where DataPedido >= getdate()

go

/*
Fim da Geração 
*/

Select cast(datapedido as date) as DataPedido, 
       count(*) as Quantidade 
  From Pedido
 Group by cast (datapedido as date) 
 Order by 1 desc 

Select *
  From Pedido
 Order by DataPedido desc 


/*

Vamos aprender como selecionar linhas de uma tabela, onde o filtro tem as condições
especificadas com valores não fixos ou não determinados. Exemplos como:


1. Mostrar todos os pedidos de Ontem.
2. Total de vendas da semana passada.
3. A quantidade de pedidos diários do mês atual.
4. Quantidade de pedidos mensais desse ano.
5. As vendas mensais com quantidade de pedidos do último trimestre.


Todas esses exemplos, utilizam com base a data atual que voce está
realizando a pesquisa. Não temos neste caso uma data fixa como base das pesquisas.

*/
select getdate()

use DBExemplo

Select * 
  From Pedido
  Order by DataPedido Desc 


/*
----------------------------------------------------------------------------------------
-- 1. Mostrar todos os pedidos de Ontem
*/

-- Demonstre como obter a data de ontem.

select dateadd(d,-1,getdate()) as Ontem -- Calcula o dia de Ontem 

/*
 O dia de ontem ocorre desde as 00:00:00 até 23:59:59.997

 AAAA-MM-DD 00:00:00 ate AAA-MM-DD 23:59:59
 2017-12-11 00:00:00 ate 2017-12-11 23:59:59

 2017-12-11 00:00:00.000 = 2017-12-11
 2017-12-11 23:59:59.999 < 2017-12-12

*/

select cast(dateadd(d,-1,getdate()) as date)  -- Calcula o dia de Ontem 
select cast(getdate() as date)  -- Calcula o dia de hoje 

Select * 
  From Pedido 
 Where DataPedido >= cast( dateadd(d,-1, getdate() ) as date) 
   and DataPedido < cast(getdate() as date) 
 Order by DataPedido Desc 


/*
----------------------------------------------------------------------------------------
-- 2. Total de vendas da semana passada.

*/

Select * 
  From Pedido
  Order by DataPedido Desc 

select datepart(week,getdate())     as NumeroSemana
select datepart(week,getdate()) - 1 as NumeroSemanaPassada
 
Select * 
  From Pedido 
 Where datepart(week,DataPedido) = datepart(week,getdate())-1
   and year(DataPedido) = year(getdate())
  Order by DataPedido 

-- Qual o problema que podemos ter no exemplo acima? 

-- Será que ele funciona para a data, por exemplo, 2017-01-05 ??


Select * 
  From Pedido 
 Where datepart(week,DataPedido) = datepart(week, cast('2017-01-05' as datetime) )-1
   and year(DataPedido) = year(cast('2017-01-05' as datetime))
  Order by DataPedido 


select cast('2017-01-05' as datetime)
 
select datepart(week , cast('2017-01-05' as datetime))   as NumeroSenama 
select datepart(week , cast('2017-01-05' as datetime))-1 as NumeroSenamaPassada

-- Existe semana zero ?!? 

-- Considerando a minha data atual 

select getdate()


Select * 
  From Pedido 
 Where DataPedido >= '2017-12-03' -- Domingo 
   and DataPedido <  '2017-12-10' -- Sábado 
  Order by DataPedido 


select getdate()  as DataAtual, NULL as DataInicial , NULL as DataFinal 

-- Data Inicial
select cast( dateadd(d,-6,dateadd(d, -datepart(dw,getdate()), getdate())) as date)

-- Data Final 
select cast( dateadd(d,-datepart(dw,getdate()), getdate()) as date)

-- Data Final ajusta,
select cast( dateadd(d,1-datepart(dw,getdate()), getdate()) as date)

Select * 
  From Pedido 
 Where DataPedido >= cast(dateadd(d, -6,dateadd( d, -datepart(dw,getdate()) , getdate())) as date)
   and DataPedido < cast( dateadd( d, 1-datepart(dw,getdate()) , getdate()) as date)
  Order by DataPedido 



/*
----------------------------------------------------------------------------------------
-- 3. A quantidade de pedidos diários do mês atual.
*/

Select cast(DataPedido as date) as Data, 
       count(*) as QtdPedido
  From Pedido
 Group by cast(DataPedido as date)


Select cast(DataPedido as date) as Data, 
       count(*) as QtdPedido
  From Pedido
 Where month(DataPedido) = month(getdate()) 
   and year(DataPedido) = year(getdate())
 Group by cast(DataPedido as date)
 
select EOMONTH(getdate()) as FimDoMes

select dateadd(d,1, EOMONTH(dateadd(m,-1,getdate()))) as ComecoDoMes
-- ou
select dateadd(m,-1,dateadd(d, 1, EOMONTH(getdate()))) as ComecoDoMes


Select cast(DataPedido as date) as Data, count(1) as Quantidade
 From Pedido
  where DataPedido >= dateadd(d,1,EOMONTH(dateadd(m,-1,getdate())))
    and DataPedido < EOMONTH(getdate())
  Group by cast(DataPedido as date)


/*
----------------------------------------------------------------------------------------
-- 4. Quantidade de pedidos mensais desse ano.
*/

Select Datename(MONTH,DataPedido) as Mes , count(*) as Quantidade
  From Pedido
 Where year(DataPedido) = year(getdate())
 Group by Datename(MONTH,DataPedido) 
 
--- Ordenação 

Select Datename(MONTH,DataPedido) as Mes , count(*) as Quantidade
  From Pedido
 Where year(DataPedido) = year(getdate())
 Group by Datename(MONTH,DataPedido) , month(datapedido)
 Order by month(datapedido)

select datepart(dayofyear,getdate())

select cast(dateadd(d, 1-datepart(dayofyear,getdate()), getdate()) as date) as PrimeiroDiaAno
select cast(cast(year(getdate()) as char(4))+'-01-01' as date)

Select Datename(MONTH,DataPedido) as Mes , count(*) as Quantidade
  From Pedido
 Where DataPedido >= cast(cast(year(getdate()) as char(4))+'-01-01' as date)
 Group by Datename(MONTH,DataPedido) , month(datapedido)
 Order by month(datapedido)



/*
----------------------------------------------------------------------------------------
-- 5. As vendas mensais com quantidade de pedidos no mes do último trimestre.
*/
 

Select * 
  From Pedido
  Order by DataPedido Desc 

select datepart(quarter,getdate())  --- Numero do trimestre atual 
select datepart(quarter,getdate())-1   -- Numero do trimestre anterior


Select month(DataPedido)as mes, 
       count(1) as Quantidade
  From Pedido
 Where datepart(quarter,DataPedido) = datepart(q,getdate())-1 
   and year(DataPedido) = year(getdate())
 Group by month(DataPedido)

-- Incluindo o nome do Mês

Select datename(m,DataPedido) as mes, 
       count(1) as Quantidade
  From Pedido
 Where datepart(q,DataPedido) = datepart(q,getdate())-1 
   and year(DataPedido) = year(getdate())
 Group by datename(m,DataPedido)

 
 -- Como será que voce resolve esse caso, sem usar o YEAR e 
 -- usando o raciocínio dos exemplos anteriores??


 Select datename(m,DataPedido) as mes, 
       count(1) as Quantidade
  From Pedido
 Where DataPedido >= '???'
   and DataPedido <= '???'
 Group by datename(m,DataPedido)

  
 -- Fim 
