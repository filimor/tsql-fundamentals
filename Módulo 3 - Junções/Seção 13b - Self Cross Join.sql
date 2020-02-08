/*

SELF CROSS JOIN 

- As mesmas características do CROSS JOIN.
- Utiliza a mesma tabela como operadores no JOIN.

*/


 /*
 Produzindo números em tempo de execução 
 */

 use DBExemplo
 go

Create Table Numero (id int) 

insert into Numero (id) values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)

Select id as Numero from Numero 

Select Dez.id as Dezena , 
       Unid.id as Unidade 
  From Numero as Dez 
 Cross Join Numero as Unid
 Order by Dezena, Unidade 
  



Select  Dez.id as Fator, 
        'x' as Op   , 
		uni.id + 1 as Fator, 
		'=' as Sinal, 
		Dez.id * (Uni.id + 1) as Produto 
   From Numero as Uni 
  Cross Join Numero as Dez 
  where Dez.id = 7
   


 Select Cen.id as Centena,
        Dez.id as Dezena, 
		Uni.id as Unidade 
   From Numero as Uni 
   Cross join Numero as Dez 
   Cross join Numero as Cen
   Order by 1 ,2,3

 
 Select ( Cen.id*100 ) + ( Dez.id * 10 ) + ( Uni.id  + 1) as Numeros 
   From Numero as Uni 
  Cross Join Numero as Dez 
  Cross Join Numero as Cen
  Order by 1 


-- Guarde bem esses conceitos para utilizarmos na secão 15 - Além dos Joins. 

/*
Exemplo 2 
*/

use DBExemplo
go

Select * from Equipe 


Select E1.Time , 
       'x' as Vs, 
	   E2.Time  
  From Equipe E1 
 Cross join Equipe E2
 Where E1.Time <> E2.Time 





/*
Exemplo Prático 
*/

use LojaVirtual
go

select chefe.PrimeiroNome, chefe.UltimoNome, chefe.Cargo  ,
       Empregado.PrimeiroNome, Empregado.UltimoNome, Empregado.Cargo  
  From Empregado as Chefe 
 Cross Join Empregado 
 Where Chefe.id = Empregado.idSupervisor
 Order by Chefe.id



 /*
 */
 