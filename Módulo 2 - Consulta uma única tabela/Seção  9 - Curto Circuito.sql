/*
O T-SQL da suporte ao conceito curto-circuito. 

O recurso de short-circuit avalia uma expressão lógica 
(predicado e operadores lógicos) da esquerda para a 
direta dentro de uma precendência. 
Isso é o padrão para a maior parte das linguagens de programação. 

Se dentro de uma expressão lógica, temos dois predicados e um 
operador lógico, o segundo predicado somente será avalidado se 
o primeiro predicado não determinar o valor da expressão.

Salario > 1000 and DataDemissao > '2017-01-01'

Salario > 1000 or DataDemissao > '2017-01-01'

Mas,

O SQL Server não segue o padrão do curto-circuito, avaliando as expressões
da esquerda para a direita. 

Como ele tem o conceito de todas de uma vez, o SQL Server escolhe a melhor
forma de processar as expressões considerando entre diversos fatores,
o custo de processamento de cada expressão.



*/

use DBExemplo
go

Select Quantidade ,
       PrecoTotal 
  From Exemplo2


Select Quantidade ,
       PrecoTotal , 
       PrecoTotal / Quantidade as PrecoUnitario 
  From Exemplo2
 Where Quantidade <> 0 
   and PrecoTotal / Quantidade >= 2.50 



Select Quantidade ,
       PrecoTotal , 
       PrecoTotal / Quantidade as PrecoUnitario 
  From Exemplo2
 Where Quantidade <> 0 -- (1)
   and PrecoTotal / Quantidade >= 2.50 --(1)(2)
--  ^----- And !! 


/*
Além do conceito de curto-circuito, o SQL Server considera também 
o custo de processamento de cada predicado.

No primeira predicado, temos a operação de comparação (1)
No segundo predicado, temos o operação de divisão (1) 
e a operação de comparação (2)

Neste caso o SQL Server elege a expressão que utilizará menos 
recursos de processamento. No caso, o primeiro predicado tem 
somente 1 custo de operação enquanto que o segundo
predicado tem 2 custos de operação para realizar.

Neste exemplo, o SQL Server avalia o primeiro predicado. 
Como existe um único operador lógico AND, se uma expressão for falsa, 
toda a sentença é falsa. Se a primeira expressão for falsa, 
o SQL não avalia a segunda expressão.

*/

Select Quantidade ,
       PrecoTotal , 
       PrecoTotal / Quantidade as PrecoUnitario 
  From Exemplo2
 Where Quantidade / 2 * 2 <> 0 -- (1)(2)(3)
   and PrecoTotal / Quantidade >= 2.50 --(1)(2)

/*
E neste caso, voce consegue explicar?
*/

Select Quantidade ,
       PrecoTotal , 
       PrecoTotal / Quantidade as PrecoUnitario 
  From Exemplo2
 Where Quantidade / 2 * 2 <> 0 
   and POWER(SQRT(PrecoTotal),2) / POWER(SQRT(Quantidade),2) >= 2.50 


/*
Se o SQL tem suporte ao curto-circuto, qual o motivo dele mostrar 
o erro no EXEMPLO 3

A resposta está no all-at-once. 

O T-SQL processa cada fase de uma vez. Neste caso o SQL Server avalia 
a expressão logica considerando o custo de processamento. 

Em outrar palavras, ele irá processar a expressão de menor custo de 
processamento.

*/   

drop table if exists Exemplo3
go

Create Table Exemplo3 (
   id         int not null,          
   Quantidade int not null,            -- Quantidade de Itens por Caixa
   Caixa      int not null,            -- Quantidade de Caixas
   Emissao    varchar(10) not null,    -- Tipo Caracter. Proposital. 
   Desativado bit not null 
)
go

Insert into Exemplo3
       (id,Quantidade,Caixa,Emissao,Desativado) 
values (1,10, 5, '2018-01-01',0),
       (2,20, 4, '2019-01-01',0),
	   (3,30,10, '2020-01-01',0),
       (4,40,20, '2021-01-01',0),
	   (5,50, 0, '1977-99-99',1), -- Tem uma data com erro e caixa com zero !!!
	   (6,60,12, '2022-01-01',0)

select * from Exemplo3

Select Id,Quantidade,Caixa , Emissao  
  From Exemplo3
 Where Desativado = 0 
   and (Quantidade / Caixa)  > 2
   and CAST(emissao as date) > GETDATE()

-- Não apresentou erro !!! Motivo ??

Insert into Exemplo3
       (id,Quantidade,Caixa,Emissao,Desativado) 
values (1000,200, 0, '2018-19-19',0)

select * from Exemplo3


Select Id,
       Quantidade,
	   Caixa , 
	   Emissao  
  From Exemplo3
 Where Desativado = 0 
   and Quantidade / Caixa  > 2
   and CAST(Emissao as date) > GETDATE() 
       
/*
No exemplo acima, O SQL Server avaliou os tres predicados 
O primeiro (Desativado = 0 ) é que tem o menor custo. 
Então ele é o primeiro avaliado. Como o predicado é falso para 
a linha 5 (id = 5), toda a expressão é falsa e os demais 
predicados não são avaliados.

Quando ele processa a linha 7 (id= 1000), o primeiro predicado é verdadeiro. 
Então o SQL Server passa a avaliar o próximo predicado. 

O SQL avalia os dois predicados e determina que o terceiro 
(CAST(Emissao as date) > GETDATE() ) tem um custo menor que o segundo.  

Então ele executa o terceiro predicado e encontra um erro de conversão.

*/


Select Id,
       Quantidade,
	   Caixa , 
	   Emissao  
  From Exemplo3
 Where Desativado = 0                     -- (1)
   and Quantidade / Caixa  > 2.0          -- (3) 
   and CAST(Emissao as date) > GETDATE()  -- (2) 

Select Id,
       Quantidade,
	   Caixa , 
	   Emissao  
  From Exemplo3
 Where Desativado = 0                     -- (1)
   and Quantidade / Caixa  > 2            -- (2) 
   and CAST(dateadd(y,1,Emissao) as date) > CAST(dateadd(y,1,GETDATE()) as date)  -- (3) 

/*

*/

