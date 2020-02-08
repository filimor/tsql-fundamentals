with Importacao  as 
(
   Select 278 as idProduto , 
         '1,4,5' as idFiliais , 
         '10,45,75' as QtdsProdutos
)
select idProduto, Estoque.value  
          from Importacao 
		  cross apply string_split(QtdsProdutos,',') as Estoque
/*
select Importacao.idProduto , Filial.value --, Estoque.value
  from Importacao 
  join (select idProduto, filiais.value  
          from Importacao 
		  cross apply string_split(idFiliais,',') as filiais ) as Filial
   on Importacao.idProduto  = Filial.idProduto 
*/
  select Importacao.idProduto , Estoque.value
  from Importacao 
   join (select idProduto, Estoque.value  
          from Importacao 
		  cross apply string_split(QtdsProdutos,',') as Estoque) as Estoque
   on Importacao.idProduto  = Estoque.idProduto 
     



  
  ) , (string_split(QtdsProdutos,','))) as Filias (idFilial,Qtd) 
  



select p.Titulo , f.Nome , e.EstoqueAtual 
  from Estoque as e
  join Produto as p on e.IdProduto = p.Id 
  join Filial  as f on e.IdFilial = f.id 
  


with texto as (
select p.Titulo+', ' as [text()] 
-- , f.Nome , e.EstoqueAtual 
  from Estoque as e
  join Produto as p on e.IdProduto = p.Id 
  join Filial  as f on e.IdFilial = f.id 
  for xml path('')
)
select * from texto






select id,titulo, '['+split.value+']'
-- , count(1) as Qtd
From produto
 Cross apply string_split(titulo, ' ') as split
 Where titulo like split.value+'%'



Select split.value , count(1) 
  From Fornecedor 
  Cross Apply string_split (nome,' ' ) as split 
  group by split.value
  order by  2 desc 


  Where split.value = 'COMERCIO'

 
