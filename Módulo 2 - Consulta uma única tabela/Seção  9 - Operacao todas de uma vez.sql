/*
Operação "Todas de uma vez"

Suporte ANSI que avalia todas as expressões dentro 
de um fase lógica de processamento ao mesmo tempo.

Com isso o T-SQL processa todas as expressões na ordem 
que desejar dentro de cada fase logica de processamento. 

*/

use FundamentosTSQL
go

Select iIDEmpregado,                      
	   year(DataPedido) as AnoPedido, 
	   count(*) as QuantidadePedido
  From Vendas.Pedido                      
 Where iIDCliente = 71                    
 Group by iIDEmpregado,                   
		  year(DataPedido)
Having count(*) > 1                       
 Order by iIDEmpregado,                   
		  AnoPedido

/*
Exemplo 1 
*/


-- Avalia a fase FROM e depois a SELECT 
Select iIDPedido , 
       YEAR(datapedido) as Ano ,  
	   Ano + 1 as ProximoAno 
  From Vendas.Pedido

-- Avalia as fases FROM, SELECT e ORDER BY
select iIDPedido , 
       YEAR(datapedido) as Ano   
  from Vendas.Pedido
 Order by Ano 


/*
Exemplo 2
*/

use DBExemplo
go 

drop table if exists Cargo 

-- A tabela Cargo tem um FK referenciando a PK dela mesma !!
-- Isso é conhecido como autorelacionamento. 
-- Utilizado por exemplo para hierarquia de dados 

Create Table Cargo (
   idCargo int not null,
   idChefe int null,
   NomeCargo varchar(20),
   Constraint PkCargo Primary key (idCargo),
   Constraint FKChefe Foreign Key (idChefe) references Cargo(idCargo)
)

insert into Cargo 
       (idCargo, idChefe, NomeCargo) 
values (      2,       1,   'Caixa'),
       (      1,    null, 'Gerente')

select * from Cargo

delete Cargo

insert into Cargo (idCargo, idChefe, NomeCargo) 
values (      2,       1,   'Caixa')

insert into Cargo (idCargo, idChefe, NomeCargo) 
values (      1,    null, 'Gerente')



insert into Cargo 
       (idCargo, idChefe, NomeCargo) 
values (      2,       3,   'Caixa'),
       (      1,    null, 'Gerente')
	   
insert into Cargo 
       (idCargo, idChefe, NomeCargo) 
values (      2,       1,   'Caixa'),
       (      1,    null, 'Gerente'),
	   (      3,       7, 'Gerente')

Select * from Cargo
       
/*
Exemplo 3
*/

use DBExemplo
go 

Select * from Cargo

update Cargo 
   set idCargo = 3 ,
       idChefe = 3   -- Mas não existe na tabela idCargo = 3 !!!
 where idCargo = 2

select * from Cargo 

/*
Exemplo 4
*/

use DBExemplo
go 

drop table if exists Exemplo2 

Create Table Exemplo2 (
   Quantidade int ,
   PrecoTotal decimal(10,2)
)
insert into Exemplo2 (Quantidade,PrecoTotal) values (10,20)  
insert into Exemplo2 (Quantidade,PrecoTotal) values (10000,25000.00)
insert into Exemplo2 (Quantidade,PrecoTotal) values (5000,12000)
insert into Exemplo2 (Quantidade,PrecoTotal) values (50000,140000)
insert into Exemplo2 (Quantidade,PrecoTotal) values (80000,180000)
 
Select * From Exemplo2

 
Update exemplo2 
   Set precototal = quantidade , 
       quantidade = precototal 

Select * From Exemplo2


/*
Exemplo 5
*/
use DBExemplo
go 

Drop Table if exists Exemplo2 
go

Create Table Exemplo2 (
   id int ,
   Quantidade int ,
   PrecoTotal decimal(10,2)
)
go

insert into Exemplo2 (Id,Quantidade,PrecoTotal) values (1,10,20)  
insert into Exemplo2 (Id,Quantidade,PrecoTotal) values (2,10000,25000.00)
insert into Exemplo2 (Id,Quantidade,PrecoTotal) values (3,5000,12000)
insert into Exemplo2 (Id,Quantidade,PrecoTotal) values (4,50000,140000)
insert into Exemplo2 (Id,Quantidade,PrecoTotal) values (5,80000,180000)
go

Select * from Exemplo2


 --- Avaliação das fases lógicas de processamento de uma só vez.

Select Quantidade ,
       PrecoTotal , 
   	   PrecoTotal / Quantidade as PrecoUnitario 
  From Exemplo2
 Where PrecoTotal / Quantidade >= 2.50


Insert into Exemplo2 (Id,Quantidade,PrecoTotal) values  (6,0,15000) 

Select Quantidade ,
       PrecoTotal  
  From Exemplo2


Select id,                                        -- FASE 3
       Quantidade,
       PrecoTotal, 
   	   PrecoTotal / Quantidade as PrecoUnitario 
  From Exemplo2                                   -- FASE 1
 Where PrecoTotal / Quantidade >= 2.50            -- FASE 2 


Select Quantidade ,
       PrecoTotal , 
       PrecoTotal / Quantidade as PrecoUnitario 
  From Exemplo2
 Where Quantidade <> 0 
   and PrecoTotal / Quantidade >= 2.50
