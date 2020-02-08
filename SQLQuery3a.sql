drop table if exists Extrato 
go

Create Table Extrato
(
   Id       int identity not null,
   Data     datetime not null,
   Valor    money not null 
)
go

insert into extrato (Data,Valor)
values ( getdate()-rand()*1000,
        case when rand()+1 <= 1.5 then rand()*100 else rand()*-100 end )
go 1000000

select sum(Valor) as Saldo , count(1) from extrato 

select rand() +1

with ctex as(
select id, 
       Data , 
	   valor , 
	   sum(valor) over (order by data) as saldo 
  from extrato 
)
select * from ctex 
where saldo = 0

order by Data 

select cast(data as date) as data , sum(valor)
from extrato
group by cast(data as date) 
having sum(valor) < 0
order by 2 




