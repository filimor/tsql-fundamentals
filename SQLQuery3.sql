drop table if exists TabelaVerdade

Create Table TabelaVerdade
(Operador char(12),
 Valor char(12),
 Verdadeiro char(12),
 Falso char(12) ,
 Desconhecido char(12)
 )

 insert into TabelaVerdade values 
 ('AND', 'Verdadeiro','Verdadeiro','Falso','Desconhecido'),
 ('AND', 'Falso','Falso','Falso','Falso'),
 ('AND', 'Desconhecido','Desconhecido','Falso','Desconhecido')

 select Valor as ' ' , Verdadeiro , Falso, Desconhecido from TabelaVerdade
 where operador = 'AND'