/*
Funções para conversão explícitas CAST e CONVERT
*/

------------------------------------------------------------------
-- CAST - Converte uma expressão de um tipo de dado para outro.
-- Neste contexto, estamos convertendo para tipo de dados data.
-- CAST( expressão AS tipo de dados)
-- CONVERT (tipo de dados, expressão, estilo)


select cast('2017-01-01' as date) as Date 
select cast('2017-01-01' as datetime) as DateTime 

-- Convertendo para caracter.

select cast(getdate() as varchar(12)) -- ???
select cast(getdate() as varchar(20)) -- ???

select convert(varchar(20), getdate() , 103) -- Britanico /Frances 
select convert(varchar(20), getdate() , 120) -- Formato padrão
select convert(varchar(20), getdate() , 101) -- Padrão Americano
select convert(varchar(20), getdate() , 111) -- Japonês


https://docs.microsoft.com/pt-br/sql/t-sql/functions/cast-and-convert-transact-sql


/*
Convertendo data e hora em número 
*/

select cast(getdate() as int) as DataNumero 
select cast(getdate() as decimal(12,6)) as DataHoraNumero

-- Retorna um número inteiro acima de 43000 !! 
-- Mas qual é a data para o número 1 ??

select cast( 1 as datetime)
select cast( 0 as datetime)

select cast(43000 as datetime)         -- O dia 24/09/2017 a meia-noite
select cast(43000.5 as datetime)       -- O dia 24/09/2017 ao meio-dia
select cast(43000.25 as datetime)      -- O dia 24/09/2017 às 06:00 
select cast(43000.75 as datetime)      -- O dia 24/09/2017 às 18:00 

select datediff(DAY,'1900-01-01', getdate())
select cast (getdate() as numeric(12,6))

-- Como representar as horas em número. 

select getdate() as DataAtual, 
      cast(getdate() as numeric(12,6)) as DataHoraNumero

-- 00:46:54.9 = 0.032580 !!!

SELECT 00/24.0    -- Hora em decimal 
SELECT 46/60.0    -- Minuto em decimal
SELECT 54.9/60.0  -- Segundos em decimal

SELECT (00+(46+(54.9/60.0))/60.0)/24.0

-- Como representar um TIME em número  

select getdate()

select cast ( getdate() as time(0)) -- Isto é um TIME(0)

select cast (  cast ( getdate() as time(0))  as numeric(9,4))

-- Como converter um TIME para Numérico?? 

-- Converter o TIME em DATETIME ou DATETIME2 
-- Converter o DATETIME em NUMERIC 

select cast ( cast (  cast ( getdate() as time(0))  as datetime ) as numeric(12,6))

/*
*/

use DBExemplo
go
drop table if exists dbo.MarcacaoPonto
go

Create Table dbo.MarcacaoPonto(
id int not null primary key,
idFuncionario int not null ,
Operacao varchar(10) not null check (Operacao in('Saida','Entrada')),
Data date not null,
Hora time not null
-- Constraint FKEmpregado foreign key (iDFuncionario) references Empregado(id) 
)
go

Insert into dbo.MarcacaoPonto (id, idFuncionario, Operacao, Data, hora)
values (1,1,'Entrada' ,'2017-10-20' ,'09:00:00'),
       (2,2,'Entrada' ,'2017-10-20' ,'09:13:00'),
       (3,3,'Entrada' ,'2017-10-20' ,'09:31:25')


Select Hora 
  From MarcacaoPonto 

Select cast(Hora  as numeric(9,4))
  From MarcacaoPonto 

Select Hora, cast( cast(Hora as datetime) as numeric(12,6))
  From MarcacaoPonto 


------------------------------------------------------------------
-- ISDATE - Avalia se uma expressão qualquer é uma data 
-- ISDATE( expressao )
-- Retorna 1 se for verdadeira ou 0 se for falsa 

-- Validando datas 
select ISDATE(GETDATE())     -- Tipo Data
select ISDATE('2017-01-01')  -- Tipo Caracter
select ISDATE('20170131')    -- Tipo Caracter 
select ISDATE(20170131)      -- Tipo Númerico.
select ISDATE(20171131)      -- Tipo Númerico.

select ISDATE(NULL)
select ISDATE(43068)
select ISDATE('2017-15-01')

select ISDATE('10/01/2017') 
-- ?? Mas é 10 de Janeiro ou 01 de Outubro? 

select datename(month,'10/01/2017') 

-- 10/01/2017, formato americano, MM/DD/AAAA 

set language portuguese

select datename(month,'10/01/2017') 

set language english 

-- Por isso que voce deve usar esses formatos 'AAAA-MM-DD' ou 'AAAAMMDD' !!!!


/*
Exemplos
*/

--- Voce deve fazer uma impressão de etiquetas para entrega do pedidos 
--- e entre alguns dados que devem ser impresso, uma das linhas 
--- da etiqueta deve constar : "Data do pedido : DD/MM/AAAA"
--- Faça um SELECT que monte essa expressão.

Select 'Data de Pedido : ' + convert(varchar(10), DataPedido,103) 
  From vendas.pedido





