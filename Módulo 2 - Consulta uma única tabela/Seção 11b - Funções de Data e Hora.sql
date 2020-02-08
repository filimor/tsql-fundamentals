/*
Funções de Data Completa, Data e Hora.
*/

------------------------------------------------------------------
-- Funções de retorno de dados sem parâmetros.
-- GETDATE()			- Data e hora Atual, formato DATETIME
-- CURRENT_TIMESTAMP	- Padrão ANSI, Igual ao GETDATE() 
-- GETUTCDATE()			- Data e Hora em UTC
-- SYSDATETIME()		- Data e hora atual, formato DATETIME2
-- SYSUTCDATETIME()		- Data e Hora em UTC, formato DATETIME2
-- SYSDATETIMEOFFSET()	- Data e hora atual, no formato DATETIMEOFFSET


 SELECT GETDATE()            AS 'GETDATE()',
        CURRENT_TIMESTAMP    AS 'CURRENT_TIMESTAMP',
        GETUTCDATE()         AS 'GETUTCDATE()', 			
        SYSDATETIME()        AS 'SYSDATETIME()',		
        SYSUTCDATETIME()     AS 'SYSUTCDATETIME()',
        SYSDATETIMEOFFSET()	 AS 'SYSDATETIMEOFFSET()'


/*

Parte de uma data.

Dentro de um valor do tipo DATA pode conter subpartes ou partes menores
de um data.

Se observarmos a data atual :
*/

SELECT GETDATE()

/*
Voce pode observar quais partes menores?

De imediato podemos ver : Ano, Mes, Dia , Hora , Minuto, Segundo e 1/3

Mas podemos ter outras partes subentendidos? 





Parte da Data	Abreviações       Descrição 
-------------   ----------------  ------------------------------- 
ano				year, AA, aaaa    
trimestre		quarter,qq, q     Trimestre (Quarter) (1-JAN,FEV,MAR 2-ABR,MAI,JUN 3-JUL,AGO,SET 4-OUT,NOV,DEZ)
mês				month , mm, m
dia do ano 		dayofyear ,dy, y  Número do dia no ano 
dia				day, dd, d        Número do dia 
semana			week,wk, ww       Número da semana no ano (1-Primeira semana ate 53-Última Semana (*) )
dia da semana	weekday, dw, w    Número do dia na semana (1-Domingo até 7-Sábado)
hora			hour,hh
minuto			minute, mi,n
segundo			second ,SS, s
milissegundos	millisecond ,MS
microssegundos	microsecond ,MCS
nanossegundos	nanosecond, NS
TZoffset	    TZoffset,tz
*/



------------------------------------------------------------------
-- YEAR(Data)	- Retorna o ano. Valor inteiro
-- MONTH(Data)	- Retorna o mês. Valor inteiro
-- DAY(Data)	- Retorna o dia. Valor Interiro


select getdate() as Hoje , 
       year( getdate() ) as Ano, 
	   month( getdate() ) as Mes, 
	   day( getdate() ) as Dia


------------------------------------------------------------------
-- DATEADD - Adiciona um valor inteiro de uma parte da data em uma 
-- data específica.
-- DATEADD(parte, unidade, data completa ou data)


Select getdate() as Hoje , 
       dateadd( DAY ,  1 ,getdate()) as Amanha ,
	   dateadd( DAY , -1 ,getdate()) as Ontem


Select getdate() as Hoje , 
       dateadd( MONTH ,  1 ,getdate()) as ProximoMes,
	   dateadd( M, -1 ,getdate()) as MesAnterior

Select getdate() as DataPedido,
       dateadd(WEEK, 1, getdate()) as DataPagamento 

-- Qual é o primeiro dia do mes da data atual? 

select   1-day(getdate())

select dateadd( day , 1-day(getdate()) , getdate())


------------------------------------------------------------------
-- DATEDIFF - Calcula a diferenca entre duas datas e retorna um
-- um valor inteiro de uma parte da data
-- DATEDIFF(parte, Data1, Data2)
--
-- Data1 deve ser menor que Data2 para retornar um número positivo 
-- 

select getdate() as Hoje , 
       datediff(DAY, '2017-01-01' ,GETDATE()) as DiasCorridos

select getdate() as Hoje , 
       datediff(MONTH,'2017-01-01',GETDATE()) as MesesCorridos


-- Quais os pedidos que mais demoraram para serem entregues.
-- Mostre apenas os 5 maiores.
-- 
use FundamentostSQL

select * from vendas.pedido


Select Top 5 with ties datediff(d,DataPedido,DataEnvio) as DiasParaEnviar ,  *
  From vendas.pedido
  Order by DiasParaEnviar desc 

-- No cadastro de Empregado, precisamos identificar com quantos
-- cada empregado foi admitido.  

select * from rh.empregado

Select DataAniversario,DataAdmissao, 
       datediff(year,DataAniversario,DataAdmissao) as IdadeAdmissao , *
  From rh.Empregado


------------------------------------------------------------------
-- DATEPART - Retorna um valor inteiro que representa parte de uma data
-- DATEPART(parte, Data)

select getdate() as Hoje , datepart(DAY,GETDATE())  as DiaMes 
select getdate() as Hoje , datepart(DAYOFYEAR,GETDATE())  as DiaAno
select getdate() as Hoje , datepart(DW,GETDATE())  as DiaSemana

select SYSDATETIMEOFFSET()
select datepart(tz, SYSDATETIMEOFFSET())


-- Como descobrir o domigo da semana de um data qualquer?

select datepart(dw,getdate()) as DiaSemana

select 1-datepart(dw,getdate()) -- Quantos dias teremos que voltar? 

select dateadd(d, 1-datepart(dw,getdate()) ,getdate())

-- Mostrar a quantidade de vendas por trimestre em cada ano 

Select year(DataPedido) as Ano ,
       datepart(q,DataPedido) as Trimestre, 
	   count(1) as Quantidade
  From Vendas.Pedido
  Group by year(DataPedido) ,
           datepart(q,DataPedido) 
  Order by Ano, Trimestre 



------------------------------------------------------------------
-- DATENAME - Retorna nome que representa parte de uma data
-- DATENAME(parte, Data)
-- DATENAME somente terá sentido o seu uso para retornar o nome do Mes 
-- e do dia da semana. 

select getdate() as Hoje, 
       datename(month,getdate()) as Mes

set language Portuguese

select getdate() as Hoje, 
       upper( datename(month,getdate()) )as Mes

--- Como escrever a data por extenso ?

select 'Hoje é ' + 
        datename(dw,getdate()) + ', ' + 
		cast(day(getdate()) as char(2) ) + ' de ' + 
		upper( datename(month,getdate()) )+ ' de ' + 
		cast(year(getdate()) as char(4))+'.' as Hoje

set language english 

------------------------------------------------------------------
-- EOMONTH- Retorna o último dia do mês da data informada. 
-- EOMONTH(data)

select eomonth(getdate()) 

-- Qual é o primeiro e último dia do mes atual?


select dateadd(m,-1,dateadd(d,1,eomonth(getdate()))) as PrimeiroDia,
       eomonth(getdate())  as UltimoDia 


-- Exemplo 

-- Precisamos programar as entrega dos pedidos com data de envio sem preenchar.
-- A regra é que a entrega seja realizada entre 10 a 12 dias depois da data do pedido.
-- As entregas devem ocorrem em dias úteis. Se a previsão for no final de semana,
-- a entrega deve ser programada para segunda-feira próxima.

use FundamentosTSQL
go

Select * 
  From vendas.Pedido
 Where DataEnvio is null



Select DataPedido, 
       dateadd(d,10,DataPedido) as EnvioPrevisto,
	   iIDPedido
  From vendas.Pedido
 Where DataEnvio is null




Select DataPedido, 
       dateadd(d,10,DataPedido) as EnvioPrevisto,
       datename(dw,  dateadd(d,10,DataPedido) ) as DiaSemana ,
	   iIDPedido  
  From vendas.Pedido
 Where DataEnvio is null




----
Select DataPedido, 
       case datepart(dw,dateadd(d,10,DataPedido) ) 
	        when 7 then dateadd(d,12,DataPedido)
			when 1 then dateadd(d,11,DataPedido)
			else dateadd(d,10,DataPedido) 
	   end as EnvioPrevisto,
	   * 
  From vendas.Pedido
 Where DataEnvio is null



