Use FundamentosTSQL
go

select * from vendas.Pedido



select datepart(wk,datapedido) as Semana, 
count(1) as Quantidade
from vendas.Pedido 
where datapedido >= '2007-12-01' and DataPedido <= '2007-12-31'
group by datepart(wk,datapedido)


/*
Eduardo precisa de uma sentença SELECT que retorne os pedidos realizados somente nos finais de semana. Qual das instruções abaixo retorna essa informação?
*/

-- TRUE 
Select Datapedido,iIDPedido
  From vendas.Pedido 
 Where datepart(w,datapedido) in (1,7)

 -- FALSE?
set language portuguese
Select datename(dw,datapedido) as DiaSemana, Datapedido , iIDPedido
  From vendas.Pedido 
 Where datepart(dw,datapedido) <= 1 and datepart(dw,datapedido) >=7

-- TRUE 
set language portuguese
?
Select datename(dw,datapedido) as DiaSemana, datapedido,iIDPedido
  From vendas.Pedido 
 Where datepart(weekday,datapedido) in (1,7)


 -- FALSE 
 
 Select datename(dw,datapedido) as DiaSemana,Datapedido,iIDPedido
  From vendas.Pedido 
 Where datepart(dw,datapedido) >= 1 and datepart(dw,datapedido) <= 7


 -- FALSE 
 Select datename(dw,datapedido) as DiaSemana, Datapedido, iIDPedido
  From vendas.Pedido 
 Where not datepart(dw,datapedido) >= 1 and datepart(dw,datapedido) <= 7



 /*
 Eduardo realizou a concatenação de três colunas da uma determinada tabela. Abaixo segue estrutura.

 ----- 
 Create Table Livro 
 (
    Titulo     char(100)     not null,
    Resenha    varchar(100)  not null,
    Comentario nvarchar(500) not null
 )
  
 insert into Livro (Titulo,Resenha,Comentario) values 
 ('Guerra e Paz', 'O mundo muda quando eu mudo',N'O melhor livro do últimos anos')

 ('Guerra e Paz', 'O mundo muda quando eu mudo',N'O melhor livro do últimos anos')
   ------------    ---------------------------    ------------------------------
        12                    27                           30

Select datalength(Resenha + Comentario) from livro



 Select len(Titulo + Resenha + Comentario) from livro
 -- 157 
 Titulo     100 -- Total da coluna         
 Resenha    27  -- Somente os caracteres
 Comentario 30  -- Somente os caracteres 
 
 Select len(Titulo)+len(Resenha)+len(Comentario) from livro
 -- 69 
 Titulo     12  -- Somente os caracteres 
 Resenha    27  -- Somente os caracteres
 Comentario 30  -- Somente os caracteres 
 
 
 Select datalength(Titulo + Resenha + Comentario) from livro
 -- 314 
 Titulo     100 -- Total da coluna        -- 200
 Resenha    27  -- Somente os caracteres  -- 54
 Comentario 60  -- Somente os caracteres  -- 60
 
 (*) Como existe a concatenação de Caracter Regular com Unicode,
     a preferência na conversão e transformar o REGULAR para UNICODE.


 Select datalength(Titulo), datalength(Resenha ) , datalength(Comentario) from livro
 -- 187
 Titulo     100 -- Total da Coluna 
 Resenha    27  -- Total de bytes armazenados
 Comentario 60  -- Total de bytes armazenados ( 1 caracter, 2 bytes)
 
 select 100+27+60


 Qual foi o valor retornado pela instrução SELECT ? 

 69 -- Todos os caracters inseridos 
 157 -- 
 700
 187
 314



 */


 use FundamentosTSQL


 
 /*
 Um relatório deve ser criado para demonstrar a data de pagamento  que o cliente 
 deve realizar sobre o pedido adquirido. A regra definida pela empresa é que a 
 data de pagamento será realizado sempre no primeiro dia útil, após 15 dias 
 da data de envio.
 
 */
 select dataenvio ,  
 case datepart(dw,dataenvio ) 
      when 1 then dateadd(d,16,dataenvio )
      when 7 then dateadd(d,17,dataenvio) 
	  else dateadd(d,15,dataenvio )
 end ,
 * from vendas.pedido
 where dataenvio is not null 


 select dataenvio ,  
 case datepart(dw,dateadd(d,15,dataenvio ) ) 
      when 1 then dateadd(d,16,dataenvio )
      when 7 then dateadd(d,17,dataenvio) 
	  else dateadd(d,15,dataenvio )
 end ,
 * from vendas.pedido
 where dataenvio is not null 


 /*
 Um voo que sai Japão as 23:20 e chega no Havai as 11:05, demorou quanto tempo em horas?
 
 O Japão está a +09:00 horas de UTC e o Havai está a -10:00 horas de UTC. 
 
 Para simular o voo, utilize a tabela abaixo:
 

  -10                                                                              +9
 --|---------------------------------------UTC -------------------------------------|---
   4                                        14                                     23

 Create Table Voo (
 Partida datetimeoffset(0),
 Chegada datetimeoffset(0)
 )

 truncate table voo 

 select 6355/900.0

 insert into voo (partida,chegada) values ('2017-12-07 23:20:00 +09:00','2017-12-07 11:05:00 -10:00')
 insert into voo (partida,chegada) values ('2017-12-07 23:20:00 +09:00','2017-12-08 11:05:00 -10:00')

 select datediff(MINUTE,Partida,Chegada)/60.0 , * from voo 

 6:45
 6:75 
 30:45 
 30:75 
 1 dia, 6: 45 
 */
 


 */