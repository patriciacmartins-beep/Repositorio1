-- =====================================================================
-- Situação de Aprendizagem - Empresa de Recursos Humanos (RH)
-- Manipulação e consulta de dados  
-- =====================================================================

USE DB_SA_SRH;

 -- INSERT: inserindo dados nas tabelas

INSERT INTO TB_SRH_CARGO (nm_titulo, vl_salario_base) VALUES
('Administrador', 5830.00),
('Técnico em DS', 3580.00),
('Operador I',    2700.00),
('Operador II',   2350.00);

SELECT * FROM TB_SRH_CARGO; -- Consulta tabela

INSERT INTO TB_SRH_DEPARTAMENTO (id_departamento, nm_departamento, vl_orcamento) VALUES
(1, 'Gestão Estratégica', 1000.00),
(2, 'TI',                 6000.00),
(3, 'PCP',                5500.00),
(4, 'Logistica',          5000.00);

SELECT * FROM TB_SRH_DEPARTAMENTO; -- Consulta tabela

INSERT INTO TB_SRH_FUNCIONARIO (id_funcionario, id_departamento, id_cargo, nm_nome, nr_cpf, dt_admissao) VALUES
(1, 1, 1, 'João Carlos Souza', '123.456.789-00', '2026-05-23 08:00:00'),
(2, 2, 2, 'Patricia Martins',  '987.654.321-00', '2026-10-15 09:50:00'),
(3, 3, 3, 'Carla Brandão',     '987.456.321-01', '2025-10-26 08:31:00'),
(4, 4, 4, 'Cicero Pedro',      '951.847.623-11', '2024-01-20 08:45:00');

SELECT * FROM TB_SRH_FUNCIONARIO; -- Consulta tabela

-- LV = livre para ser preenchida, EP = em processo de recrutamento
INSERT INTO TB_SRH_VAGA (id_vaga, id_cargo, vl_quantidade, st_vaga) VALUES
(1, 1, 2, 'LV'),
(2, 2, 1, 'EP'),
(3, 3, 5, 'LV'),
(4, 4, 1, 'EP');

SELECT * FROM TB_SRH_VAGA; -- Consulta tabela

-- =====================================================================
-- AR = Analista de RH, RE = Recrutador
-- (no sistema real, a senha é guardada criptografada; aqui usamos SHA2 como exemplo)
INSERT INTO TB_SRH_USUARIO (nm_usuario, ds_email, ds_senha, st_perfil) VALUES
('Ana Paula Lima',   'ana.lima@empresa.com',     SHA2('senha123', 256), 'AR'),
('Bruno Teixeira',   'bruno.teixeira@empresa.com', SHA2('senha456', 256), 'RE'),
('Fernanda Rocha',   'fernanda.rocha@empresa.com', SHA2('senha789', 256), 'RE');

SELECT * FROM TB_SRH_USUARIO; -- Consulta tabela

INSERT INTO TB_SRH_CANDIDATO (nm_nome, nr_cpf, ds_email, nr_telefone) VALUES
('Lucas Andrade',   '111.222.333-44', 'lucas.andrade@email.com', '(71) 98888-1111'),
('Mariana Costa',   '222.333.444-55', 'mariana.costa@email.com', '(71) 97777-2222'),
('Rafael Nunes',    '333.444.555-66', 'rafael.nunes@email.com',  NULL),
('Juliana Freitas', '444.555.666-77', 'juliana.f@email.com',     '(71) 96666-4444');

SELECT * FROM TB_SRH_CANDIDATO; -- Consulta tabela

-- TR = triagem, EN = entrevista, AP = aprovado, RP = reprovado
INSERT INTO TB_SRH_CANDIDATURA (id_candidato, id_vaga, dt_inscricao, st_etapa) VALUES
(1, 2, '2026-11-03 10:15:00', 'EN'),
(2, 2, '2026-11-04 14:30:00', 'TR'),
(3, 4, '2026-11-05 09:00:00', 'AP'),
(4, 4, '2026-11-06 16:45:00', 'RP'),
(2, 4, '2026-11-07 11:20:00', 'TR');

SELECT * FROM TB_SRH_CANDIDATURA; -- Consulta tabela

-- RN06: o recrutador recebe um aviso a cada etapa do processo seletivo
INSERT INTO TB_SRH_NOTIFICACAO (id_usuario, id_candidatura, ds_mensagem, dt_envio, st_lida) VALUES
(2, 1, 'Lucas Andrade passou para a etapa de entrevista.', '2026-11-10 08:00:00', 'S'),
(2, 2, 'Nova candidatura de Mariana Costa em triagem.',    '2026-11-10 08:05:00', 'N'),
(3, 3, 'Rafael Nunes foi aprovado no processo seletivo.',   '2026-11-12 15:00:00', 'N'),
(3, 4, 'Juliana Freitas foi reprovada no processo seletivo.', '2026-11-12 15:10:00', 'S');

SELECT * FROM TB_SRH_NOTIFICACAO; -- Consulta tabela

-- =====================================================================
-- SELECT com apelidos (mudando o nome das colunas na consulta)

SELECT
    nm_titulo       AS 'CARGO',
    vl_salario_base AS 'SALÁRIO'
FROM TB_SRH_CARGO;

SELECT
    id_departamento AS 'CODIGO DPT',
    nm_departamento AS 'DEPARTAMENTO',
    vl_orcamento    AS 'R$ DISP CONTRATO'
FROM TB_SRH_DEPARTAMENTO;

SELECT
    id_funcionario  AS 'MATRICULA',
    id_departamento AS 'CODIGO DT',
    id_cargo        AS 'COD CARGO',
    nm_nome         AS 'COLABORADOR',
    nr_cpf          AS 'CPF',
    dt_admissao     AS 'ADMISSÃO'
FROM TB_SRH_FUNCIONARIO;


-- =====================================================================
-- Variações de consulta: WHERE, ORDER BY, LIKE, BETWEEN, IN, LIMIT

-- Cargos com salário acima de 3.000, do maior para o menor
SELECT nm_titulo, vl_salario_base
FROM TB_SRH_CARGO
WHERE vl_salario_base > 3000
ORDER BY vl_salario_base DESC;

-- Funcionários com nome começando com "C"
SELECT nm_nome, nr_cpf
FROM TB_SRH_FUNCIONARIO
WHERE nm_nome LIKE 'C%';

-- Funcionários admitidos em 2026
SELECT nm_nome, dt_admissao
FROM TB_SRH_FUNCIONARIO
WHERE dt_admissao BETWEEN '2026-01-01' AND '2026-12-31 23:59:59';

-- Candidaturas em triagem ou entrevista
SELECT id_candidatura, id_candidato, id_vaga, st_etapa
FROM TB_SRH_CANDIDATURA
WHERE st_etapa IN ('TR', 'EN');

-- Os 2 departamentos com maior orçamento
SELECT nm_departamento, vl_orcamento
FROM TB_SRH_DEPARTAMENTO
ORDER BY vl_orcamento DESC
LIMIT 2;

-- =====================================================================
-- Tratamento de dados: funções de texto, data e número

SELECT
    UPPER(nm_nome)                         AS 'NOME EM MAIÚSCULO',
    DATE_FORMAT(dt_admissao, '%d/%m/%Y')   AS 'DATA DE ADMISSÃO',
    TIMESTAMPDIFF(MONTH, dt_admissao, '2026-11-24') AS 'MESES DE EMPRESA'
FROM TB_SRH_FUNCIONARIO;

SELECT
    nm_nome                                  AS 'CANDIDATO',
    IFNULL(nr_telefone, 'Não informado')     AS 'TELEFONE',
    CONCAT(nm_nome, ' <', ds_email, '>')     AS 'CONTATO'
FROM TB_SRH_CANDIDATO;

SELECT
    nm_titulo                                AS 'CARGO',
    CONCAT('R$ ', FORMAT(vl_salario_base, 2, 'pt_BR')) AS 'SALÁRIO',
    ROUND(vl_salario_base * 12, 2)           AS 'SALÁRIO ANUAL'
FROM TB_SRH_CARGO;

-- =====================================================================
-- Funções de agregação: COUNT, SUM, AVG, MAX, MIN, GROUP BY

SELECT
    COUNT(*)             AS 'TOTAL DE CARGOS',
    AVG(vl_salario_base) AS 'MÉDIA SALARIAL',
    MAX(vl_salario_base) AS 'MAIOR SALÁRIO',
    MIN(vl_salario_base) AS 'MENOR SALÁRIO'
FROM TB_SRH_CARGO;

SELECT SUM(vl_quantidade) AS 'TOTAL DE POSIÇÕES ABERTAS'
FROM TB_SRH_VAGA;

-- Quantidade de candidaturas por vaga (só vagas com mais de 1)
SELECT id_vaga, COUNT(*) AS 'CANDIDATURAS'
FROM TB_SRH_CANDIDATURA
GROUP BY id_vaga;


-- =====================================================================
-- JOIN: juntando tabelas

-- INNER JOIN: funcionário com o nome do departamento e do cargo
SELECT
    F.nm_nome         AS 'COLABORADOR',
    D.nm_departamento AS 'DEPARTAMENTO',
    C.nm_titulo       AS 'CARGO',
    C.vl_salario_base AS 'SALÁRIO'
FROM TB_SRH_FUNCIONARIO F
INNER JOIN TB_SRH_DEPARTAMENTO D ON D.id_departamento = F.id_departamento
INNER JOIN TB_SRH_CARGO C        ON C.id_cargo = F.id_cargo
ORDER BY F.nm_nome;

-- INNER JOIN: candidaturas com o nome do candidato e o cargo da vaga
SELECT
    CA.nm_nome      AS 'CANDIDATO',
    C.nm_titulo     AS 'CARGO DA VAGA',
    CT.st_etapa     AS 'ETAPA',
    DATE_FORMAT(CT.dt_inscricao, '%d/%m/%Y') AS 'INSCRIÇÃO'
FROM TB_SRH_CANDIDATURA CT
INNER JOIN TB_SRH_CANDIDATO CA ON CA.id_candidato = CT.id_candidato
INNER JOIN TB_SRH_VAGA V       ON V.id_vaga = CT.id_vaga
INNER JOIN TB_SRH_CARGO C      ON C.id_cargo = V.id_cargo;

-- LEFT JOIN: todas as vagas, mesmo as que ainda não têm candidatos
SELECT
    V.id_vaga             AS 'VAGA',
    C.nm_titulo           AS 'CARGO',
    V.st_vaga             AS 'STATUS',
    COUNT(CT.id_candidatura) AS 'CANDIDATURAS'
FROM TB_SRH_VAGA V
INNER JOIN TB_SRH_CARGO C       ON C.id_cargo = V.id_cargo
LEFT JOIN TB_SRH_CANDIDATURA CT ON CT.id_vaga = V.id_vaga
GROUP BY V.id_vaga, C.nm_titulo, V.st_vaga;

-- RIGHT JOIN: todos os recrutadores e as notificações que receberam
SELECT
    U.nm_usuario  AS 'USUÁRIO',
    N.ds_mensagem AS 'NOTIFICAÇÃO'
FROM TB_SRH_NOTIFICACAO N
RIGHT JOIN TB_SRH_USUARIO U ON U.id_usuario = N.id_usuario;

-- =====================================================================
-- VIEW (tabela virtual)

-- Painel de Gestão de Pessoas (com filtro por departamento)
CREATE OR REPLACE VIEW VW_SRH_QUADRO_FUNCIONAL AS
SELECT
    F.id_funcionario  AS matricula,
    F.nm_nome         AS colaborador,
    D.nm_departamento AS departamento,
    C.nm_titulo       AS cargo,
    C.vl_salario_base AS salario,
    F.dt_admissao     AS admissao
FROM TB_SRH_FUNCIONARIO F
INNER JOIN TB_SRH_DEPARTAMENTO D ON D.id_departamento = F.id_departamento
INNER JOIN TB_SRH_CARGO C        ON C.id_cargo = F.id_cargo;

SELECT * FROM VW_SRH_QUADRO_FUNCIONAL;
SELECT * FROM VW_SRH_QUADRO_FUNCIONAL WHERE departamento = 'TI';

-- Portal de Vagas abertas
CREATE OR REPLACE VIEW VW_SRH_VAGAS_ABERTAS AS
SELECT
    V.id_vaga        AS vaga,
    C.nm_titulo      AS cargo,
    V.vl_quantidade  AS posicoes,
    CASE V.st_vaga
        WHEN 'LV' THEN 'Livre'
        WHEN 'EP' THEN 'Em processo'
    END              AS situacao
FROM TB_SRH_VAGA V
INNER JOIN TB_SRH_CARGO C ON C.id_cargo = V.id_cargo;

SELECT * FROM VW_SRH_VAGAS_ABERTAS;

-- =====================================================================
-- UPDATE: modificando dados

-- Realizando mudança no salário do cargo Operador II
UPDATE TB_SRH_CARGO
    SET vl_salario_base = 3100.00
    WHERE id_cargo = 4;

SELECT * FROM TB_SRH_CARGO;

-- A vaga 1 entrou em processo de recrutamento
UPDATE TB_SRH_VAGA
    SET st_vaga = 'EP'
    WHERE id_vaga = 1;

-- A candidata Mariana passou da triagem para a entrevista na vaga 2
UPDATE TB_SRH_CANDIDATURA|
    SET st_etapa = 'EN'
    WHERE id_candidato = 2 AND id_vaga = 2;

-- O recrutador leu todas as notificações dele
UPDATE TB_SRH_NOTIFICACAO
    SET st_lida = 'S'
    WHERE id_usuario = 2;

SELECT * FROM TB_SRH_NOTIFICACAO;

-- =====================================================================
-- DELETE: excluindo dados

-- Exclui a candidatura reprovada (as notificações dela saem junto, ON DELETE CASCADE)
DELETE FROM TB_SRH_CANDIDATURA
    WHERE st_etapa = 'RP';

SELECT * FROM TB_SRH_CANDIDATURA;
SELECT * FROM TB_SRH_NOTIFICACAO;

-- =====================================================================
-- 10. Testando as restrições (tire o -- da frente para ver o erro)

-- RN01 (CK_SRH_CARGO_SALARIO): salário abaixo do mínimo
-- INSERT INTO TB_SRH_CARGO (nm_titulo, vl_salario_base) VALUES ('Estagiário', 1000.00);

-- RN02 (UK_SRH_FUNCIONARIO_CPF): CPF repetido
-- INSERT INTO TB_SRH_FUNCIONARIO (id_departamento, id_cargo, nm_nome, nr_cpf, dt_admissao)
--     VALUES (1, 1, 'Teste CPF', '123.456.789-00', '2026-11-01 08:00:00');

-- RN04 (CK_SRH_VAGA_QUANTIDADE): vaga com quantidade zero
-- INSERT INTO TB_SRH_VAGA (id_cargo, vl_quantidade, st_vaga) VALUES (1, 0, 'LV');

-- RNF02 (FK_SRH_FUNCIONARIO_CARGO): excluir cargo que tem funcionário
-- DELETE FROM TB_SRH_CARGO WHERE id_cargo = 1;
