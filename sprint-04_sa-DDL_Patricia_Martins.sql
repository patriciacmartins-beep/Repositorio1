
-- Situação de Aprendizagem - Empresa de Recursos Humanos (RH)
-- Sprint 04 | Implementando a Estrutura de Armazenamento do Projeto


CREATE DATABASE IF NOT EXISTS DB_SA_SRH;
USE DB_SA_SRH;

-- Apaga as tabelas (das dependentes para as principais) para o script
-- poder ser executado de novo do zero
DROP TABLE IF EXISTS TB_SRH_NOTIFICACAO;
DROP TABLE IF EXISTS TB_SRH_CANDIDATURA;
DROP TABLE IF EXISTS TB_SRH_CANDIDATO;
DROP TABLE IF EXISTS TB_SRH_USUARIO;
DROP TABLE IF EXISTS TB_SRH_VAGA;
DROP TABLE IF EXISTS TB_SRH_FUNCIONARIO;
DROP TABLE IF EXISTS TB_SRH_CARGO;
DROP TABLE IF EXISTS TB_SRH_DEPARTAMENTO;


-- Quadro de funcionários

CREATE TABLE TB_SRH_DEPARTAMENTO (
    id_departamento INT           NOT NULL AUTO_INCREMENT,
    nm_departamento VARCHAR(100)  NOT NULL,
    vl_orcamento    DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_SRH_DEPARTAMENTO PRIMARY KEY (id_departamento),
    CONSTRAINT CK_SRH_DEPARTAMENTO_ORCAMENTO CHECK (vl_orcamento >= 0)
);

CREATE TABLE TB_SRH_CARGO (
    id_cargo        INT           NOT NULL AUTO_INCREMENT,
    nm_titulo       VARCHAR(80)   NOT NULL,
    vl_salario_base DECIMAL(10,2),

    CONSTRAINT PK_SRH_CARGO PRIMARY KEY (id_cargo),
    -- RN01: o salário base não pode ser menor que o salário mínimo vigente
    CONSTRAINT CK_SRH_CARGO_SALARIO CHECK (vl_salario_base >= 1621.00)
);

CREATE TABLE TB_SRH_FUNCIONARIO (
    id_funcionario  INT         NOT NULL AUTO_INCREMENT,
    id_departamento INT         NOT NULL,
    id_cargo        INT         NOT NULL,
    nm_nome         VARCHAR(80) NOT NULL,
    nr_cpf          CHAR(14)    NOT NULL,
    dt_admissao     DATETIME    NOT NULL,
    -- RN05 (data de admissão não pode ser futura) é validada pela aplicação,

    CONSTRAINT PK_SRH_FUNCIONARIO PRIMARY KEY (id_funcionario),
    -- RN02: CPF único
    CONSTRAINT UK_SRH_FUNCIONARIO_CPF UNIQUE (nr_cpf),
    -- RN03: o funcionário fica vinculado a um departamento e a um cargo
    CONSTRAINT FK_SRH_FUNCIONARIO_DEPARTAMENTO FOREIGN KEY (id_departamento)
        REFERENCES TB_SRH_DEPARTAMENTO (id_departamento) ON DELETE RESTRICT,
    -- RNF02: não deixa excluir um cargo que tem funcionários
    CONSTRAINT FK_SRH_FUNCIONARIO_CARGO FOREIGN KEY (id_cargo)
        REFERENCES TB_SRH_CARGO (id_cargo) ON DELETE RESTRICT
);

CREATE TABLE TB_SRH_VAGA (
    id_vaga       INT     NOT NULL AUTO_INCREMENT,
    id_cargo      INT     NOT NULL,
    vl_quantidade INT     NOT NULL,
    st_vaga       CHAR(2) NOT NULL DEFAULT 'LV',

    CONSTRAINT PK_SRH_VAGA PRIMARY KEY (id_vaga),
    -- RN04: quantidade de posições maior que zero
    CONSTRAINT CK_SRH_VAGA_QUANTIDADE CHECK (vl_quantidade > 0),
    -- LV = livre para ser preenchida, EP = em processo de recrutamento
    CONSTRAINT CK_SRH_VAGA_STATUS CHECK (st_vaga IN ('LV', 'EP')),
    CONSTRAINT FK_SRH_VAGA_CARGO FOREIGN KEY (id_cargo)
        REFERENCES TB_SRH_CARGO (id_cargo) ON DELETE RESTRICT
);

-- Acesso ao sistema e recrutamento

CREATE TABLE TB_SRH_USUARIO (
    id_usuario INT          NOT NULL AUTO_INCREMENT,
    nm_usuario VARCHAR(80)  NOT NULL,
    ds_email   VARCHAR(100) NOT NULL,
    ds_senha   VARCHAR(255) NOT NULL,  -- guardar a senha criptografada
    st_perfil  CHAR(2)      NOT NULL,

    CONSTRAINT PK_SRH_USUARIO PRIMARY KEY (id_usuario),
    CONSTRAINT UK_SRH_USUARIO_EMAIL UNIQUE (ds_email),
    -- AR = Analista de RH, RE = Recrutador
    CONSTRAINT CK_SRH_USUARIO_PERFIL CHECK (st_perfil IN ('AR', 'RE'))
);

CREATE TABLE TB_SRH_CANDIDATO (
    id_candidato INT          NOT NULL AUTO_INCREMENT,
    nm_nome      VARCHAR(80)  NOT NULL,
    nr_cpf       CHAR(14)     NOT NULL,
    ds_email     VARCHAR(100) NOT NULL,
    nr_telefone  VARCHAR(15),

    CONSTRAINT PK_SRH_CANDIDATO PRIMARY KEY (id_candidato),
    CONSTRAINT UK_SRH_CANDIDATO_CPF UNIQUE (nr_cpf)
);

CREATE TABLE TB_SRH_CANDIDATURA (
    id_candidatura INT      NOT NULL AUTO_INCREMENT,
    id_candidato   INT      NOT NULL,
    id_vaga        INT      NOT NULL,
    dt_inscricao   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    st_etapa       CHAR(2)  NOT NULL DEFAULT 'TR',

    CONSTRAINT PK_SRH_CANDIDATURA PRIMARY KEY (id_candidatura),
    -- o mesmo candidato não se inscreve duas vezes na mesma vaga
    CONSTRAINT UK_SRH_CANDIDATURA_CANDIDATO_VAGA UNIQUE (id_candidato, id_vaga),
    -- TR = triagem, EN = entrevista, AP = aprovado, RP = reprovado
    CONSTRAINT CK_SRH_CANDIDATURA_ETAPA CHECK (st_etapa IN ('TR', 'EN', 'AP', 'RP')),
    CONSTRAINT FK_SRH_CANDIDATURA_CANDIDATO FOREIGN KEY (id_candidato)
        REFERENCES TB_SRH_CANDIDATO (id_candidato) ON DELETE RESTRICT,
    CONSTRAINT FK_SRH_CANDIDATURA_VAGA FOREIGN KEY (id_vaga)
        REFERENCES TB_SRH_VAGA (id_vaga) ON DELETE RESTRICT
);

CREATE TABLE TB_SRH_NOTIFICACAO (
    id_notificacao INT          NOT NULL AUTO_INCREMENT,
    id_usuario     INT          NOT NULL,
    id_candidatura INT          NOT NULL,
    ds_mensagem    VARCHAR(200) NOT NULL,
    dt_envio       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    st_lida        CHAR(1)      NOT NULL DEFAULT 'N',

    CONSTRAINT PK_SRH_NOTIFICACAO PRIMARY KEY (id_notificacao),
    -- S = lida, N = não lida
    CONSTRAINT CK_SRH_NOTIFICACAO_LIDA CHECK (st_lida IN ('S', 'N')),
    -- RN06: notificação ao recrutador sobre as etapas do processo seletivo
    CONSTRAINT FK_SRH_NOTIFICACAO_USUARIO FOREIGN KEY (id_usuario)
        REFERENCES TB_SRH_USUARIO (id_usuario) ON DELETE RESTRICT,
    CONSTRAINT FK_SRH_NOTIFICACAO_CANDIDATURA FOREIGN KEY (id_candidatura)
        REFERENCES TB_SRH_CANDIDATURA (id_candidatura) ON DELETE CASCADE
);

-- Conferência da estrutura criada
SHOW TABLES;
