drop table if exists Receita
drop table if exists Formula
drop table if exists MateriaPrima
go

Create Table Formula (
id int not null primary key,
idProduto int not null ,
Nome char(20) not null
)
go
Create Table MateriaPrima (
id int not null primary key,
Descricao char(50) not null,
Unidade char(3) not null,
Quantidade int  not null 
)
go

Create Table Receita (
  id int not null,
  idFormula int not null ,
  idMateriaPrima int not null,
  Quantidade int  not null check (Quantidade > 0 ),
  DataValidade datetime not null check( DataValidade > Getdate()) ,
  Constraint PKReceita Primary Key (id,idMateriaPrima) ,
  Constraint UNformula Unique(idFormula),
  Constraint FKMateriaPrima Foreign Key (idMateriaPrima) references MateriaPrima (id),
  Constraint FKProduto Foreign Key (idMateriaPrima) references MateriaPrima (id)
)
go

drop table if exists Receita
go 
Create Table Receita (
  idFormula int not null ,
  idMateriaPrima int not null,
  Quantidade int  not null check (Quantidade > 0 ),
  DataValidade datetime not null check( DataValidade > Getdate()) ,
  Constraint PKReceita Primary Key (idFormula,idMateriaPrima) ,
  Constraint UNformula Unique(idFormula),
  Constraint FKMateriaPrima Foreign Key (idMateriaPrima) references MateriaPrima (id),
  Constraint FKProduto Foreign Key (idMateriaPrima) references MateriaPrima (id)
)




drop table if exists Receita
go 
Create Table Receita (
  idFormula int not null ,
  idMateriaPrima int not null,
  Quantidade int not null default 0,
  DataValidade datetime not null default Getdate() ,
  Constraint PKReceita Primary Key (idFormula) ,
  Constraint FKMateriaPrima Foreign Key (idMateriaPrima) references MateriaPrima (id),
  Constraint FKProduto Foreign Key (idMateriaPrima) references MateriaPrima (id)
)




drop table if exists Receita
go 

Create Table Receita (
  id int not null,
  idFormula int not null ,
  idMateriaPrima int not null,
  Quantidade int  not null check (Quantidade > 0 ),
  DataValidade datetime not null check( DataValidade > Getdate()) ,
  Constraint PKReceita Primary Key (id) ,
  Constraint UNformula Unique(idFormula,idMateriaPrima),
  Constraint FKMateriaPrima Foreign Key (idMateriaPrima) references MateriaPrima (id),
  Constraint FKProduto Foreign Key (idMateriaPrima) references MateriaPrima (id)
)
go


Create Table Receita (
  id int not null,
  idFormula int not null ,
  idMateriaPrima int not null,
  Quantidade int  not null check (Quantidade > 0 ),
  DataValidade datetime not null check( DataValidade > Getdate()) ,
  Constraint PKReceita Primary Key (idFormula,idMateriaPrima) ,
  Constraint FKMateriaPrima Foreign Key (idMateriaPrima) references MateriaPrima (id),
  Constraint FKProduto Foreign Key (idMateriaPrima) references MateriaPrima (id)
)
go
