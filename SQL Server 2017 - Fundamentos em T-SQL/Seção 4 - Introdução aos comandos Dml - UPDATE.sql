use Agenda
go

Select * 
  From Contato

insert into Contato (Numero, Nome, Telefone, Aniversario , Sexo) 
values (40,'eDDDUArdo', '(AB) 5555-8','1097-01-31' , 'X')

Select * 
  From Contato
go

Update Contato 
   set Nome = 'Eduardo' 
  Where Numero = 40

Select * 
  From Contato

Update Contato 
   set Telefone = '(11) 5555-6666' ,
       Aniversario = '1997-01-31'
  Where Numero = 40

/*
Cuidado 
*/

Update Contato 
   set Sexo = 'M' 

Select * 
  From Contato


