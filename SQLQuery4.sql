use DBExemplo
go

drop table if exists Teste1 

Create table Teste1 (id int, Tipo char(1), data date , valor money)


insert into Teste1 values 
(1,'S', '2017-01-05', null),
(2,'C', '2017-01-17', 101.00),
(3,'C', '2017-01-25', 252.00),
(4,'D', '2017-01-25', -25.00),
(5,'C', '2017-02-12', 353.00),
(6,'C', '2017-02-20', 156.00),
(7,'D', '2017-02-21', -75.00),
(8,'D', '2017-02-21', -10.00),
(9,'D', '2017-04-05', -51.00),
(10,'D', '2017-04-11', -78.00)

SELECT sum(abs(valor)) FROM Teste1 where id > 2

ALTER TABLE TESTE1 ADD  TE INT 

use FundamentosTSQL
go


/*
*/
Select iIDPedido , 
       MONTH(datapedido) as Mes, 
       YEAR(datapedido) as Ano ,  
	   Case When Mes = 1 
	        Then 'Entregar Imposto' 
			else '' 
	   end as Mensagem 
  From Vendas.Pedido


Select NomeProduto, 
       PrecoUnitario,
	   NovoPreco = PrecoUnitario *1.25 
  From Producao.Produto
 Where NovoPreco > 100.00 

Select PrimeiroNome, 
       UltimoNome, 
	   PrimeiroNome+' '+UltimoNome   ,
	   Cortesia + ' '+ PrimeiroNome+' '+UltimoNome   
  From RH.Empregado
  

Select TOP 10 
       iIDPedido, 
       iIDProduto, 
       Sum(PrecoUnitario * Quantidade) as TotalPedido
  From Vendas.ItensPedido
 Where iIDProduto = 59 
 Group by iIDPedido, iIDProduto
Having TotalPedido >= 5000.00
 Order by TotalPedido Desc 


 Select Cidade,Regiao,Pais ,*
   From vendas.Cliente
  Where Regiao = 'NULL' 

 
 /*
 */

 use DBExemplo

 drop table if exists Equacao 
 go 
 Create Table Equacao (
 Valor1 numeric(10,2) ,
 Valor2 numeric(10,2),
 Valor3 numeric(10,2),
 Peso1 numeric(10,2), 
 Peso2 numeric(10,2), 
 Peso3 numeric(10,2)
 )
 go
 insert into Equacao values
 (1,1,1,1,1,1),
 (20,30,40,1,2,3),
 (5,2,1,1,2,5),
 (10,20,30,1,0,0),
 (10,20,30,0,0,0)



 O calculo de uma formula é realizada pela expressão:

/*

 ((Valor1*Peso1) + (Valor1*Peso1) + (Valor1*Peso1))
 __________________________________________________
              (Peso1+Peso2+Peso3)

*/

 Na tabela Equacao, temos as colunas da equação acima. Essa colunas foram 
 definida como a restrição de não aceitar nulo. 

 Mas por um problema da aplicação, algumas colunas aceitaram o 
 valor 0 zero para algumas linhas.

 Qual e a expressão correta para utilizar na cláusula WHERE
 para não apresentar o erro de divisão por zero.

 Peso1 > 0 and peso2 > 0 and peso3 > 0 
 Peso1 > 0 OR peso2 > 0 OR peso3 > 0 
 Peso1*Peso2*Peso3 > 0 
 Peso1+Peso2+Peso3 > 0
 


 select * , 
      ((Valor1*Peso1) + (Valor2*Peso2) + (Valor3*Peso3))/(peso1+peso2+peso3)
  from equacao 
  where Peso1 > 0 and peso2 > 0 and peso3 > 0 

	select * , 
      ((Valor1*Peso1) + (Valor1*Peso1) + (Valor1*Peso1))/ (peso1+peso2+peso3)
  from equacao 
  where Peso1+peso2+peso3 > 0 

  	select * , 
      ((Valor1*Peso1) + (Valor1*Peso1) + (Valor1*Peso1))/ (peso1+peso2+peso3)
  from equacao 
  where Peso1*peso2*peso3 > 0 

  	select * , 
      ((Valor1*Peso1) + (Valor1*Peso1) + (Valor1*Peso1))/ (peso1+peso2+peso3)
  from equacao 
  where not 0 in (Peso1,peso2,peso3)



  use DBExemplo
  go
  drop table if exists ImportTXT  
  go
  Create Table ImportTXT 
  (Saldo varchar(20) ,    
   Valor int,
   Data varchar(12),
   Fator varchar(2) ,
   Titulo varchar(5400) ,
   Ignore bit default 0 
   )
   go
   insert into ImportTXT (Saldo,Valor,Data,Fator,Titulo) values 
   ( format(rand()*1000000 ,'0000.00'),
     cast(rand()*10000 as int ),
     format((rand()*17)+2000,'0000') +'-'+
	 format(rand()*12 ,'00') +'-'+
	 format(rand()*31 ,'00'),
	 format(rand()*10,'00') ,
     replace(replicate(newid(),(rand()*149) + 1),'-',' ')
	 )
	 go 10000
	  
	 
	 select cast(saldo as numeric(10,3)) as d , saldo,valor,data,fator from ImportTXT
	 where --saldo < 1000.000	   and 
	       --cast(data as date) > '2008-01-01'	   and 
		   (valor  / fator) > 1

	 select saldo,valor,data,fator from ImportTXT
	  where valor / fator > 1000                           -- 4 
		and cast(fator as int) <> '000'                    -- 3 
		and cast(saldo as numeric(10,3)) < 100000.000 	   -- 2
	    and data > '2008-01-01'                            -- 1


	 select saldo, valor, data, fator from ImportTXT
	  where fator*2/2 > 0 
	    and valor / fator > 1000.0                            
		and saldo < 100000 	                       
	    and cast(data as date)> '2008-01-01'                           


    select saldo, valor, data, fator from ImportTXT
	  where fator > 0 
	    and valor / fator > 1000.0                            
		and cast(saldo as numeric(10,3)) < 100000 	                       
	    and try_parse(data as date) > '2008-01-01'                           

