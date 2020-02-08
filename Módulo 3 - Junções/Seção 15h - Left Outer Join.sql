/*

LEFT OUTER JOIN (Jun��o Externa a Esquerda)

- LEFT OUTER JOIN preserva as linhas da tabelas a esquerda 
  do JOIN quando a condi��o do filtro � falsa ou desconhecida. 

- Exemplos. 
   
  FROM Tabela1                                 
  LEFT OUTER JOIN Tabela2                      (1) 
    ON Tabela1.ColunaA = Tabela2.ColunaA       (2), (3) 
  Where ....                                   (4)

  (1) Ocorre o produto cartesiano entre Tabela1 e Tabela2 ;
  (2) Ocorre o filtro de linhas entre Tabela1 e Tabela2 
      (o resultado vou chamar de V1) ;
  (3) Ocorre a inclus�o das linhas de Tabela1 (LEFT TABLE) 
      que n�o satisfazem a condi��o do filtro de linhas 
  (4) Os dados s�o enviados para a pr�xima fase. 

*/

/*
Exemplo 
*/

use DBExemplo
go

drop table if exists dbo.Carro 
go

drop table if exists dbo.Montadora 
go

Create Table dbo.Montadora 
(
   id int not null primary key ,
   Nome varchar(20) not null
)
go   

insert into dbo.Montadora values (1,'Fiat'),(2,'Ford'),(3,'GM') , (4,'VW')
go

Create Table dbo.Carro(
   id int not null,
   Modelo varchar(20) not null,
idMontadora int foreign key references Montadora(id) )
go

insert into dbo.Carro values (1,'Uno',1),(2,'Onix',3),(3,'KA',2),
                             (4,'Mobi',1),(5,'Prisma',3),(6,'Fiesta',2)

select * from dbo.Montadora order by id 
select * from dbo.Carro order by idMontadora

Select Montadora.id, 
       Montadora.Nome  , 
	   Carro.id , 
	   Carro.Modelo , 
	   Carro.idMontadora
  From Montadora 
  Join Carro
    on Montadora.id = Carro.idMontadora

Select id , Nome
  From Montadora 
  where id = 4


/*
- Aten��o. O resultado final da fase JOIN ser� sempre as colunas das duas tabelas 
  que participam da jun��o � ser�o enviados para a pr�xima fase, independente de 
  serem apresentadas ou n�o na fase do SELECT.
  
  Est� claro isso?

- Ent�o, se a tabela do lado ESQUERDO do JOIN tem os dados preseservados ( ou inclu�dos ) no 
  resultado que foram enviados para a pr�xima fase, quais ser�o os valores das 
  colunas recuperadas da tabela que est� do lado DIREITO, cujo os dados n�o foram encontrados??

  Isso � muito importante que voc�s entendam!!!

*/
waitfor delay '00:00:10' 


Select Montadora.*  ,
       Carro.* 
  From Montadora 
  Left Outer Join Carro
    On Montadora.id = carro.idMontadora
 Order by Montadora.id
 


 -- Simplificando : LEFT OUTER JOIN = LEFT JOIN.

 Select * 
  From Montadora 
  Left Join Carro
    On Montadora.id = carro.idMontadora
 Order by Montadora.id



/*
Exemplo Pr�tico 
*/

/*
Exemplo 1

Montar uma consulta que apresente todos os clientes e seus pedidos. A rela��o deve 
apresentar tamb�m os clientes que n�o tiveram pedidos. 

Apresentando a estrutura das tabelas.

Cliente:
id - chave prim�ria que representa a identifica��o do cliente
PrimeiroNome - Nome do cliente
CPF - CPF
Endereco - Endere�o simples do cliente ,
Cep - Cep do Endereco 

Pedido:
id - chave prim�ria que representa a identifica��o do Pedido 
DataPedido - Data que o pedido foi criado.
Valor - Valor do pedido, sem a aplica��o dos descontos. 
Desconto - Valor do desconto n�o aplicado sobre o valor do pedido. 

Fazendo o mapeamente de PK e FK das tabelas com base do modelo, temos:

Tabela			PK		-->		Tabela			FK
--------------------------------------------------------------
Cliente			id		-->		Pedido			idCliente


*/

use LojaVirtual
go

-- Vamos estudar um caso de um cliente para entendermos o processo. 

select PrimeiroNome, CPF, Endereco, CEP  from cliente where id = 33 
select Valor , desconto  from pedido where idcliente = 33

select PrimeiroNome, CPF, Endereco, CEP  from cliente where id = 15 
select Valor , desconto  from pedido where idcliente = 15


Select c.id            as idCliente  , 
       c.PrimeiroNome  as Nome , 
	   c.CPF           as CPF, 
	   c.Endereco      as Endereco ,   
	   c.CEP           as CEP ,
	   p.id            as idPedido , 
	   p.DataPedido    as DataPedido, 
	   p.Valor         as Valor 
  From Cliente as c
  Left Outer Join Pedido as p
    On c.id = p.idCliente 


/*
Ordenando pelo ID do cliente para ajudar na pesquisa. 
*/

Select c.id            as idCliente  , 
       c.PrimeiroNome  as Nome , 
	   c.CPF           as CPF, 
	   c.Endereco      as Endereco ,   
	   c.CEP           as CEP ,
	   p.id            as idPedido , 
	   p.DataPedido    as DataPedido, 
	   p.Valor         as Valor 
  From Cliente as c
  Left Outer Join Pedido as p
    On c.id = p.idCliente 
  Order by c.id 

/*
Filtrando somente os cliente de ID  15 e 33. 
*/
Select c.id            as idCliente  , 
       c.PrimeiroNome   as Nome , 
	   c.CPF           as CPF, 
	   c.Endereco      as Endereco ,   
	   c.CEP           as CEP ,
	   p.id            as idPedido , 
	   p.DataPedido    as DataPedido, 
	   p.Valor         as Valor 
  From Cliente as c
  Left Outer Join Pedido as p
    On c.id = p.idCliente 
	where c.id in ( 33,15) 



/*
Processamento l�gico 
*/

Select c.id            as idCliente  ,       -- (4) Apresenta��o  
       c.PrimeiroNome   as Nome , 
	   c.CPF           as CPF, 
	   c.Endereco      as Endereco ,   
	   c.CEP           as CEP ,
	   p.id            as idPedido , 
	   p.DataPedido    as DataPedido, 
	   p.Valor         as Valor 
  From Cliente as c                           -- (1) Produto Cartesiano entre Cliente e Pedido  
  Left Outer Join Pedido as p                 
    On c.id = p.idCliente                     -- (2) Filtro de linhas, compara��o equi-join 
	                                          -- (3) Inclus�o das linhas da tabela Cliente que 
											  --     n�o satisfaz o filtro de linha. 


/*
Aten��o!!! Importante voc�s saberem as tr�s fases de processamento l�gico
           do OUTER JOIN. Nas aulas "Mais do que conceitos do JOIN" vamos entender
		   essa import�ncia e como elas v�o ajudar voce a criar JUN��ES corretas.
*/