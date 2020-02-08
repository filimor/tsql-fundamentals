/*
1. Grafos 
---------

Pela teoria, grafos é uma ramo da matemática que estuda a relação entre objetos 
de um determinado conjunto.

Estruturas são determinadas para esse estudo, como:

- Grafo (G)
- Vértices (V)
- Arestas (E)

Onde um grafo e formado por Vértices e Arestas : G(V,E)

Um vértice representa um conjunto de objetos e a aresta representa a conexão entre os vértices. 

Os grafos são utilizados para manter relação entre objetos como por exemplos:

- Relação de pessoas em um rede social.
- Loja Online onde pessoas curtem os itens e dão opniões.
- Site de viagens, onde pessoas pontual cidades e restaurantes. 

Ou algo mais complexo:

- Empresa de logística determina o melhor caminho de um veículo.
- Construções de redes de transmissão de energia. 
- Estudos de redes neurais.

Banco de dados de grafos

Um banco de dados de grafos é uma coleção de tabelas NODE (nós - vértices) e tabelas 
EDGE (bordas - arestas).

No banco, as tabelas NODE se relacionam com cardinalidade N:N e utilizam as tabelas EDGE
para construir essa relação.

*/

/*
2. Criandos tabelas 
--------------------
*/

-- Criando uma tabela NODE (NÓ) 

/*
Tabela NODE que representa um conjunto de objetos em um grafo. 
*/

use DBExemplo
go 

drop table if exists Pessoa

Create Table Pessoa 
(
   id int primary key,
   Nome char(20) not null 
) as Node 

go

sp_help Pessoa

select * from sys.columns where is_hidden = 1


/*
COLUNA $node_id_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

- Coluna implícita do tipo nvarchar(1000);
- Coluna criada automaticamente pelo SQL Server para identificar a linha exclusiva em um nó;
- Os valores dessa coluna para um nova linha são gerados também automaticamente e contém
  o ID do objeto e um valor gerando internamente;
*/

insert into Pessoa (id,Nome) values (1,'Jose da Silva') , (2,'Maria Souza') ,(3,'Joaquim Moura')

Select * from Pessoa

/*

Somente no momento de visualizar conteúdo da coluna $node_id_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX, 
é transformado e apresentado uma cadeia de caracters no forma JSON. 

{"type":"node","schema":"dbo","table":"Pessoa","id":0}

Ela identifica:

- O tipo da tabela grafo : Node ou Edge
- O schema da tabela.
- O nome da tabela.
- O id da linha. Sempre começa com zero. 

Voce pode referenciar a coluna $node_id_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX simplesmente 
pelo nome da pseudocoluna $node_id.
*/


Select $node_id, id, nome from Pessoa

select * from Pessoa where $node_id = '{"type":"node","schema":"dbo","table":"Pessoa","id":0}'

go

declare @node_id varchar(max) 
select @node_id = $node_id from Pessoa where id = 1 

select @node_id


select * from openjson(@node_id)


sp_help Pessoa

select graph_id_07D90147EB134331B43A822E34AACE85 from Pessoa

select * from sys.columns where is_hidden = 1

/*
COLUNA graph_id_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

- Coluna do tipo Bigint e não aceita nulos.
- Coluna não acessível no momento da visualização dos dados. 

*/


/*
Em uma tabela NODE, obrigatoriamente deve existir um índice ÚNICO para a coluna $node_id.
Se voce não criar o índice, o SQL Server criará um indice não cluster unico.

*/

sp_helpindex2 Pessoa


use DBExemplo
go 

drop table if exists Pessoa
go

Create Table Pessoa 
(
   id int primary key ,
   Nome char(20) not null ,
   Constraint UNNode Unique ($node_id) 
) as Node 
go

insert into Pessoa (id,Nome) values (1,'Jose da Silva') , (2,'Maria Souza') ,(3,'Joaquim Moura')

go
sp_helpindex2 Pessoa
go


-- Criando uma tabela EDGE (Borda) 

/*
Tabela que representa a relação entre os nós de um grafo. 
Essas tabelas podem ser criadas sem especificar colunas de uso das regras de negócios.

*/

-- Tabela EDGE sem colunas adicionais. 

use DBExemplo
go 

drop table if exists Amizade

Create Table Amizade as Edge 

go

sp_help Amizade


/*
COLUNA $edge_id_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

- Coluna criada automaticamente pelo SQL Server para identifica a linha exclusiva em uma borda.
- Sempre será do tipo NVARCHAR(1000). 
- Os valores dessa coluna para um nova linha são gerados também automaticamente e contém
  o ID do objeto e um valor gerando internamente. 
- Tem as mesmas características e funcionalidades da $node_id.

COLUNA $from_id_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

- Coluna do tipo NVARCHAR(1000), ele armazenará o $node_id do NODE de origem.

COLUNA $to_id_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

- Coluna do tipo NVARCHAR(1000), ele armazenará o $node_id do NODE de destino.


COLUNAS : 
graph_id_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
from_obj_id_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
from_id_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
to_obj_id_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
to_id_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

São de controles internos e do tipo INT ou BIGINT. 
Não são acessíveis na visualização.

*/


/*
Em uma tabela EDGE, obrigatoriamente deve existir um índice ÚNICO para a coluna $edge_id.
Se voce não criar o índice, o SQL Server criará um indice não cluster unico.

É recomendável a criação de indices para as colunas $from_id e $to_id.

*/

-- Tabela EDGE com colunas adicionais. 

use DBExemplo
go 

drop table if exists Amizade

Create Table Amizade 
(
   DataRelacao datetime2 not null 
)
as Edge 

go

sp_help Amizade

Select * from Amizade

/*
Incluir dados em uma tabela EDGE - Borda 

As colunas $from_id e $to_id deve ser preenchidas com a referencia $node_id das 
tabelas NODE de Origem e Destino. 

No nosso exemplos, vamos retratar a amizade entre as pessoas. Então, a table NODE
Pessoa será tanto a nossa Origem como o nosso Destino. 

*/

-- Exemplo com um código legível

declare @from_id nvarchar(100)
declare @to_id nvarchar(100)

select @from_id = $node_id from Pessoa where id=1
select @to_id   = $node_id from Pessoa where id=2

Insert into Amizade ($from_id, $to_id, DataRelacao) 
values (@from_id, @to_id, getdate())

-- Exemplo com código resumido 

Insert into Amizade ($from_id, $to_id, DataRelacao) 
values ( (Select $node_id from Pessoa where id=2), (Select $node_id from Pessoa where id=3) , getdate()) 


Insert into Amizade ($from_id, $to_id, DataRelacao) 
select  (Select $node_id from Pessoa where id=3), (Select $node_id from Pessoa where id=1) , getdate()
 
-- 

/*
Alguns pontos que devem ser considerados na manutenção de dados nas 
tabelas NODE e EDGE. 

- Não existe uma consistência na validação dos dados das colunas $from_id e $to_id.
  
*/

Insert into Amizade ($from_id, $to_id, DataRelacao) 
values ('{"type":"node","schema":"dbo","table":"Pessoa","id":158}',  
        '{"type":"node","schema":"dbo","table":"Pessoa","id":5487}', 
	    getdate()
	   )

/*
- Não existe restrição de exclusão. Voce consegue excluir um item da tabela NODE 
  que tem relação com uma tabela EDGE.
*/

Select * from Pessoa where id=3

Select * from Amizade

Delete  from Pessoa where id=3


/*
- Uma linha de uma tabela NODE se relaciona coma ela mesma na tabelas EDGE.
*/

select * from Amizade


Insert into Amizade ($from_id, $to_id, DataRelacao) 
values ('{"type":"node","schema":"dbo","table":"Pessoa","id":2}',  
        '{"type":"node","schema":"dbo","table":"Pessoa","id":2}', 
	    getdate()
	   )

/*
3. Exemplos
*/


/*
- Para exemplificar esse banco e detalharmos os recursos de pesquisa, vamos como um prática. 
*/
-----------------------------------------------------------------------------------

use master
go
drop database if exists SocialNet


Create Database SocialNet
go
use SocialNet
go
drop table if exists Conta
go

Create Table Conta 
(
   idConta int not null primary key,
   PrimeiroNome varchar(50) not null,
   SegundoNome varchar(50) not null,
   Usuario varchar(25) not null ,
   Status varchar(20) not null default 'Publico' check ( status in ('Publico','Amigos','Seleção')),
   Constraint UNNode Unique ($node_id) 
) as Node 
go

drop Sequence seqConta
go

Create Sequence seqConta start with 6 increment by 1
go

drop table if exists Amigo 
go

Create Table Amigo 
(
   DataAmizade datetime2 default getdate(),
   Constraint UNNode01 Unique ($edge_id) 
)as edge
go

Create Index to_id on Amigo($to_id) 

drop table if exists Postagem
go

Create Table Postagem 
(
   iIDPost int not null primary key,
   Post varchar(max) not null ,
   Criado datetime default getdate()
) as Node 
go
Drop sequence seqPostagem 
go
Create Sequence seqPostagem start with 1 increment by  1
go


Create Table PublicouPost 
(
   Publicado datetime2 default getdate()
)
as edge
go

Create Table CurtiPost  as edge
go

Create Table ComentouPost (Comentario varchar(max)) as edge 
go

Create Table CompartilhouPost as edge 
go


/*
Voce efetuou o cadastro no site 
*/

Insert into Conta (idConta,PrimeiroNome,SegundoNome, Usuario)
values(1,'Jose','da Silva', 'JSilva')

select * from Conta

Insert into Conta (idConta,PrimeiroNome,SegundoNome, Usuario)
values(2,'Maria','Dutra', 'MDutra'),
      (3,'Eduardo','da Cunha', 'ECunha'),
      (4,'Carlos','Moderato', 'CModerato'),
      (5,'Paula','Ribeiro', 'PRibeiro')

Select * from Conta

/*
Outros cadatros no site 
*/

Insert into Conta (idConta,PrimeiroNome,SegundoNome, Usuario)
select next value for seqConta , 
       substring(PrimeroNome,1,1)+lower(substring(PrimeroNome,2,100)),
       substring(SegundoNome,1,1)+lower(substring(SegundoNome,2,100))+' '+ substring(TerceiroNome,1,1)+lower(substring(TerceiroNome,2,100)) ,
	   substring(PrimeroNome,1,1)+substring(SegundoNome,1,1)+substring(TerceiroNome,1,1)+lower(substring(TerceiroNome,2,100))
	   From lojavirtual.dbo.cliente

/*
Voce faz amizades 
*/

declare @from_id nvarchar(100) 
declare @to_id nvarchar(100) 

select @from_id = $node_id from Conta where idConta = 1 
select @to_id = $node_id from Conta where idConta = 2 

insert into Amigo ($from_id, $to_id) values (@from_id,@to_id )

select @to_id = $node_id from Conta where idConta = 3

insert into Amigo ($from_id, $to_id) values (@from_id,@to_id )

select * from Amigo


/*
Outra amizades que foram acontecendo. 
*/

declare @from_id nvarchar(100) 
declare @nAmigos int = rand()* 25

Select Top 1 @from_id = $Node_id 
  From Conta 
 Order by newid()

insert into Amigo ($from_id,$to_id)
Select Top (@nAmigos) @from_id , $node_id 
  From Conta 
 Where $node_id <> @from_id 
   and $node_id not in (select $to_id from Amigo where $from_id = @from_id )
 Order by newid() 
go 1000



/*
Voce fazendo o seu post 
*/

insert into Postagem (iIDPost,Post) values (1,'O que voce está pensando')

insert into PublicouPost values (
(select $node_id from Conta where idConta = 1),
(select $node_id from Postagem where iIDPost = 1))

select * from PublicouPost

/*
Outras Publicações 
*/
declare @idPost int 
declare @to_id nvarchar(100)
declare @from_id nvarchar(100)
declare @npost int = rand()*25 

Select top 1 @from_id = $node_id 
  From Conta 
 Order by newid() 

while @npost >= 0 begin 

   set @idPost = next value for seqPostagem

   insert into Postagem (iIDPost,Post) values (@idPost, 'O que voce está pensando')

   Select @to_id = $node_id 
     From Postagem 
    Where iIDPost = @idPost

   insert into PublicouPost ($from_id, $to_id) values (@from_id ,@to_id) 

   set @nPost -= 1

end
go 1000


select * from postagem 

select * from PublicouPost

/*
Alguem curtiu seu post 
*/

insert into CurtiPost 



Select * 
  From Conta as Pessoa, 
       Amigo as Amizade , 
	   Conta as Amigo 
 Where Match ( Pessoa-(Amizade)->Amigo )

select Conta.PrimeiroNome, Conta.Usuario , count(Postagem.iidpost)
from Conta ,PublicouPost  ,Postagem  
where match (Conta-(PublicouPost)->Postagem)
group by Conta.PrimeiroNome,Conta.Usuario
order by 3 desc 






/*
Extra
*/

select * from Pessoa
cross apply string_split ($node_id,',') as node 

select * from Pessoa
cross apply openjson ($node_id) as node 
where pessoa.id = 1

Select * from Amizade 

*/

/*
Vamos criar um banco de dados para atender um livraria virtual, 
onde um dos requisitos é identificar os livros e autores 
que os clientes mais gostam. 




if db_id('BookVirtual') is null
   Create Database BookVirtual 
go
use BookVirtual
go

Create Table Livro (
   iIDLivro int not null primary key,
   Titulo varchar(100) not null,
   Resenha varchar(max) not null,
   Cadastro date not null ,
   Tags varchar(250) null,
   ISBN char(20) not null
) as Node
 
go

Create Table Cliente (
   iIDCliente int not null primary key ,
   Nome varchar(50) not null,
   Nascimento date not null 
) as Node 

go

Create Table Autor (
   iIDAutor int not null primary key,
   Nome varchar(50) not null,
   DataNascimento date not null
)


Create Table Conexao as edge

Create Table ClienteCurtiAutor as edge

Create Table ClienteCurtiLivro as edge

Create Table AutorEscreveLivro as edge
*/
