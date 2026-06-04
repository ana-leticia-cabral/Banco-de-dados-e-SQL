
/*Nome, sexo, bairro, cidade, tipo, numero*/
SELECT 
	c.nome, 
	c.sexo, 
	e.bairro, 
	e.cidade, 
	t.tipo, 
	t.numero
FROM 
	CLIENTE AS c
INNER JOIN 
	ENDERECO AS e
	ON c.id_cliente = e.cliente_id
INNER JOIN 
	TELEFONE AS t
	ON c.id_cliente = t.cliente_id;