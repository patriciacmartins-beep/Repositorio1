

-- Inserindo dados nas tabelas construídas
INSERT INTO tb_srh_cargo (nm_titulo, vl_salario_base) values

("Administrador", 5830.00),
("Técnico em DS", 3580.00),
("Operador I", 2700.00),
("Operador II", 2350.00);

SELECT * FROM tb_srh_cargo; -- Consulta tabela

INSERT INTO tb_srh_departamento (id_departamento, nm_departamento, vl_orcamento) values

(1, "Gestão Estratégica", 1000.00),
(2, "TI", 6000.00),
(3, "PCP", 5500.00),
(4, "Logistica", 5000.00);

SELECT * FROM tb_srh_departamento; -- Consulta tabela

INSERT INTO tb_srh_funcionario(id_funcionario, id_departamento, id_cargo, nm_funcionario, nr_cpf, dt_admissao) values

(1, 1, 1, "João Carlos Souza", "123.456.789-00", "2026-05-23 08:00:00"),
(2, 2, 2, "Patricia Martins", "987.654.321-00", "2026-10-15 09:50:00"),
(3, 3,3, "Carla Brandão", "987.456.321-01", "2025-10-26 08:31:00"),
(4, 4, 4, "Cicero Pedro", "951.847.623-11", "2024-01-20 08:45:00");

SELECT * FROM tb_srh_funcionario; -- Consulta tabela

INSERT INTO tb_srh_vaga (id_vaga, id_cargo, vl_quantidade, st_vaga) values

(1, 1, 2, "LV"),
(2, 2, 1, "EP"),
(3, 3, 5, "LV"),
(4, 4, 1, "EP");

SELECT * FROM tb_srh_vaga; -- Consulta tabela


-- Mudando nome das estruturas na tabela
SELECT 
	nm_titulo AS 'CARGO',
    vl_salario_base AS 'SALÁRIO'
FROM
	tb_srh_cargo;
    
SELECT
	id_departamento AS 'CODIGO DPT',
    nm_departamento AS 'DEPARTAMENTO',
    vl_orcamento AS 'R$ DISP CONTRATO'
FROM
	tb_srh_departamento;

SELECT
	id_funcionario AS 'MATRICULA',
    id_departamento AS 'CODIGO DT',
    id_cargo AS 'COD CARGO',
    nm_funcionario AS 'COLABORADOR',
    nr_cpf AS 'CPF',
    dt_admissao AS 'ADMISSÃO'
FROM
	tb_srh_funcionario;
    

-- Realizando mudança no salário do funcionario
UPDATE tb_srh_cargo
	SET vl_salario_base = 3100.00
	WHERE id_cargo = 4;
    
    SELECT * FROM tb_srh_cargo;
    
    
    
    
    
    

