USE momento;

SELECT * FROM departamentos;

INSERT INTO funcionarios(primeiro_nome, sobrenome, email, senha, telefone, data_contratacao, cargo_id, salario, gerente_id, departamento_id)
VALUES ('Taylor', 'Swift', 'taylor.swift@momento.org', '@t@a@y@l@o@r', '555.123.4567', '2010-05-01', 21, 9000.00, 100, 6);

SELECT COUNT(*) FROM funcionarios;
 
SELECT COUNT(*) FROM funcionarios 
WHERE departamento_id = (
SELECT departamento_id 
FROM departamentos 
WHERE departamento_nome = "Tecnologia"
);
 
SELECT COUNT(*) FROM funcionarios 
WHERE departamento_id = (
SELECT departamento_id 
FROM departamentos 
WHERE departamento_nome = "Vendas"
);
 
SELECT salario as SalárioVendas FROM funcionarios 
WHERE departamento_id = (
SELECT departamento_id 
FROM departamentos 
WHERE departamento_nome = "Vendas"
);
 
SELECT SUM(salario) as SalárioVendas FROM funcionarios 
WHERE departamento_id = (
SELECT departamento_id 
FROM departamentos 
WHERE departamento_nome = "Vendas"
);

SELECT 
	produtos.produto_nome as nome_produto, 
	MAX(vendas.quantidade) as quantidade_vendida 
FROM vendas
INNER JOIN produtos
	ON produtos.produto_id = vendas.produto_id
GROUP BY produtos.produto_nome
ORDER BY quantidade_vendida DESC
LIMIT 5;

SELECT
	produtos.produto_nome as nome_produto,
    MIN(vendas.quantidade) as quantidade_vendida
FROM vendas
INNER JOIN produtos
	ON produtos.produto_id = vendas.produto_id
GROUP BY produtos.produto_nome
ORDER BY quantidade_vendida ASC
LIMIT 5;

SELECT 
	produto_nome as produto_nome,
	produto_price as preco_produto
FROM produtos
WHERE produto_price = (SELECT MAX(produto_price) FROM produtos)
LIMIT 1;

INSERT INTO escritorios(escritorio_id, escritorio_nome, endereco, cep, cidade, estado_provincia, pais_id)
VALUES (6500, "Anitta Office", "4000 AV Paulista", 8349238, "São Paulo", "São Paulo", "BR");

INSERT INTO departamentos(departamento_nome, escritorio_id)
VALUES ("Inovações",6500);
 
INSERT INTO funcionarios(primeiro_nome, sobrenome, email, senha, telefone, data_contratacao, cargo_id, salario, gerente_id, departamento_id)
VALUES ('Beyoncé', 'Knowles', 'beyonce.knowles@momento.org', '@b@e@y@o@n@c@e', '555.234.5678', '2003-06-15', 20, 9500.00, 100, 14),
('Adele', 'Adkins', 'adele.adkins@momento.org', '@a@d@e@l@e', '555.345.6789', '2011-08-01', 19, 9200.00, 100, 14),
('Lady', 'Gaga', 'lady.gaga@momento.org', '@l@a@d@y@g@a@g@a', '555.456.7890', '2008-02-20', 18, 8500.00, 100, 14),
('Rihanna', 'Fenty', 'rihanna.fenty@momento.org', '@r@i@h@a@n@n@a', '555.567.8901', '2005-03-17', 17, 9000.00, 100, 14),
('Selena', 'Gomez', 'selena.gomez@momento.org', '@s@e@l@e@n@a', '555.678.9012', '2013-10-01', 16, 8000.00, 100, 14),
('Shakira', 'Mebarak', 'shakira.mebarak@momento.org', '@s@h@a@k@i@r@a', '555.789.0123', '2001-09-15', 16, 9500.00, 100, 14),
('Billie', 'Eilish', 'billie.eilish@momento.org', '@b@i@l@l@i@e', '555.890.1234', '2019-11-01', 17, 8200.00, 100, 14),
('Katy', 'Perry', 'katy.perry@momento.org', '@k@a@t@y', '555.901.2345', '2008-04-25', 10, 8800.00, 100, 14),
('Dua', 'Lipa', 'dua.lipa@momento.org', '@d@u@a', '555.012.3456', '2017-06-10', 10, 8400.00, 100, 14);

SELECT 
	COUNT(*)
FROM funcionarios
INNER JOIN dependentes
	ON funcionarios.funcionario_id = dependentes.funcionario_id
WHERE 
	dependentes.relacionamento = "Cônjuge";

SELECT
	CONCAT(funcionarios.primeiro_nome, " ", funcionarios.sobrenome) as nome_completo,
    MIN(funcionarios.data_contratacao) as data_contratacao
FROM funcionarios
GROUP BY nome_completo
ORDER BY data_contratacao
LIMIT 1;

SELECT
	CONCAT(funcionarios.primeiro_nome, " ", funcionarios.sobrenome) as nome_completo,
    MAX(funcionarios.data_contratacao) as data_contratacao
FROM funcionarios
GROUP BY nome_completo
ORDER BY data_contratacao DESC
LIMIT 1;

SELECT
	CONCAT(funcionarios.primeiro_nome, " ", funcionarios.sobrenome) as nome_completo,
    MIN(funcionarios.data_contratacao) as data_contratacao
FROM funcionarios
GROUP BY nome_completo
ORDER BY data_contratacao ASC
LIMIT 5;

SELECT DISTINCT
	AVG(funcionarios.salario) as media_salarial,
    YEAR(funcionarios.data_contratacao) AS ano_contratacao
FROM funcionarios
GROUP BY ano_contratacao
ORDER BY media_salarial DESC;

SELECT 
	AVG(funcionarios.salario) media_salarial
FROM funcionarios
WHERE
	funcionarios.cargo_id NOT IN (
		SELECT cargo_id FROM cargos WHERE cargo_nome IN ("CEO", "CFO", "CMO")
	);
    
SELECT
	AVG(funcionarios.salario) as media_salarial
FROM funcionarios
WHERE 
	funcionarios.departamento_id = (
		SELECT departamento_id FROM departamentos WHERE departamento_nome = "Tecnologia"
    );
    
SELECT
	departamentos.departamento_nome as nome_departamento,
	AVG(funcionarios.salario) as media_salarial
FROM funcionarios
INNER JOIN departamentos
	ON funcionarios.departamento_id = departamentos.departamento_id
GROUP BY nome_departamento
ORDER BY media_salarial DESC
LIMIT 1;

SELECT 
    departamentos.departamento_nome AS nome_departamento,
    COUNT(funcionarios.departamento_id) AS qtd_funcionarios
FROM departamentos
INNER JOIN funcionarios 
	ON funcionarios.departamento_id = departamentos.departamento_id
GROUP BY departamentos.departamento_nome
ORDER BY qtd_funcionarios ASC
LIMIT 5;

SELECT 
	produtos.produto_nome as nome_produto,
    MAX(vendas.quantidade) as qtd_vendida,
    MAX(produtos.produto_price) as valor_produto
FROM produtos
INNER JOIN vendas
	ON produtos.produto_id = vendas.produto_id
GROUP BY nome_produto
ORDER BY qtd_vendida AND valor_produto
LIMIT 1;

SELECT 
	produtos.produto_nome as nome_produto,
    MAX(vendas.quantidade) as qtd_vendida
FROM produtos
INNER JOIN vendas
	ON produtos.produto_id = vendas.produto_id
GROUP BY nome_produto
ORDER BY qtd_vendida DESC
LIMIT 1;

SELECT 
	produtos.produto_nome as nome_produto,
    MIN(vendas.quantidade) as qtd_vendida
FROM produtos
INNER JOIN vendas
	ON produtos.produto_id = vendas.produto_id
GROUP BY nome_produto
ORDER BY qtd_vendida ASC
LIMIT 1;

SELECT 
    regioes.regiao_nome AS nome_regiao,
    COUNT(escritorios.pais_id) AS qtd_sedes
FROM regioes
INNER JOIN paises 
	ON paises.regiao_id = regioes.regiao_id
INNER JOIN escritorios 
	ON escritorios.pais_id = paises.pais_id
GROUP BY regioes.regiao_nome
ORDER BY qtd_sedes;

SELECT 
	escritorios.escritorio_nome as nome_escritorio,
	suprimentos.custo as custo
FROM escritorios
INNER JOIN suprimentos
	ON escritorios.escritorio_id = suprimentos.escritorio_id
ORDER BY custo DESC;

SELECT * FROM regioes;

SELECT * FROM escritorios;