/*

INNER JOIN 

COMPOSITE-JOIN 

- Mantém todas as características do INNER JOIN.

- O predicado de filtro de linhas entre as duas tabelas
  é realizado com a duas ou mais comparações 

  Tabela1.ColunaA = Tabela2.ColunaA 
  AND 
  Tabela1.ColunaB = Tabela2.ColunaB

- Quando tratamos de relacionamente entre tabelas pelas PK e FK, mesmo elas sendo
  Compostas, voce tem que garantir que todas as expressões de comparação
  são verdadeiras, visto que uma relação entre duas tabelas realizada por duas ou 
  mais colunas são totalmente verdadeiras. 

  Por isso devemos usar sempre o operador AND para esse tipo particular de JOIN 

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
   id int not null,
   Grupo char(2) not null , 
   Nome varchar(20) not null,  
   Constraint PKMontadora Primary Key (id,Grupo) )
go

insert into dbo.Montadora values (1,'FT','Fiat'),(2,'FO','Ford'),(3,'GM', 'General Motors'),
                                 (4,'FT','Jeep'),(5,'FO','Volvo'),(6,'GM', 'Cadillac')
go


Create Table dbo.Carro
(
   id int not null,
   Modelo varchar(20) not null,
   idMontadora int ,
   GrupoMontadora char(2) ,
   Constraint FKMontadora Foreign Key (idMontadora,GrupoMontadora) 
   references Montadora (id,Grupo)
)
go

insert into dbo.Carro values (1,'Uno',1,'FT') ,(2,'Onix',3,'GM')  ,(3,'KA',2,'FO'),
                             (4,'Mobi',1,'FT'),(5,'Prisma',3,'GM'),(6,'Fiesta',2,'FO'),
							 (7,'Renegede',4,'FT'),(8,'XC90',5,'FO'),(9,'Escalade',6,'GM')

select * from dbo.Montadora
select * from dbo.Carro

Select * 
  From Montadora 
  Join Carro
    On Montadora.id = Carro.idMontadora
   And Montadora.Grupo = Carro.GrupoMontadora
 Order by Montadora.id
 
/*
Exemplo Prático 
*/

/*
Monstrar a relação de fornecedores e seu produtos. 
*/
use LojaVirtual
go

Select * from Produto
Select * from Fornecedor

Select Fornecedor.id,
       Fornecedor.CodigoFornecedor,
       Fornecedor.Nome , 
       Produto.id, 
	   Produto.Titulo 
  From Fornecedor -- PK
  Join Produto    -- FK
    On Fornecedor.id = Produto.iDfornecedor  
   And Fornecedor.CodigoFornecedor = Produto.CodigoFornecedor
 Order by Fornecedor.Nome


 -- Erro quando utilizamos o OR.

 Select Fornecedor.id,
        Fornecedor.CodigoFornecedor,
        Fornecedor.Nome , 
        Produto.id, 
	    Produto.Titulo ,
		Produto.iDfornecedor
  From Fornecedor -- PK
  Join Produto    -- FK
    on Fornecedor.id = Produto.iDfornecedor  
    or Fornecedor.CodigoFornecedor = Produto.CodigoFornecedor
 Order by Fornecedor.Nome
 
 Select * from Produto where id = 12




/*
Aplicando filtro de linhas 
*/

Select Fornecedor.id,
       Fornecedor.CodigoFornecedor,
       Fornecedor.Nome , 
       Produto.id, 
	   Produto.Titulo 
  From Fornecedor -- PK
  Join Produto    -- FK
    on Fornecedor.id = Produto.iDfornecedor  
   And Fornecedor.CodigoFornecedor = Produto.CodigoFornecedor
 Where Fornecedor.CodigoFornecedor = 'F-1324LM'
 
