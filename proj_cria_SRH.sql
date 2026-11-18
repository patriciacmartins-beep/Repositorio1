CREATE DATABASE IF NOT EXISTS DB_SA_SRH;
USE DB_SA_SRH;

CREATE TABLE TB_SRH_DEPARTAMENTO (
    id_departamento INT NOT NULL PRIMARY KEY,
    nm_departamento VARCHAR(100) NOT NULL,
    vl_orcamento DECIMAL(10,2) NOT NULL
);

CREATE TABLE TB_SRH_CARGO (
    id_cargo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nm_titulo VARCHAR(80) NOT NULL,
    vl_salario_base DECIMAL(10,2) NOT NULL CHECK (vl_salario_base >= 1621.00)
);

CREATE TABLE TB_SRH_FUNCIONARIO ( 
    id_funcionario INT NOT NULL PRIMARY KEY, 
    id_departamento INT NOT NULL, 
    id_cargo INT NOT NULL, 
    nm_funcionario VARCHAR(80) NOT NULL, 
    nr_cpf CHAR(14) NOT NULL, 
    dt_admissao DATE NOT NULL, 
    
    -- Nomes alterados para evitar duplicidade global no banco
    CONSTRAINT UK_SRH_FUNC_CPF UNIQUE (nr_cpf), 
    CONSTRAINT FK_SRH_FUNC_DEP FOREIGN KEY (id_departamento) 
        REFERENCES TB_SRH_DEPARTAMENTO (id_departamento), 
    CONSTRAINT FK_SRH_FUNC_CARGO FOREIGN KEY (id_cargo) 
        REFERENCES TB_SRH_CARGO (id_cargo) 
);

CREATE TABLE TB_SRH_VAGA (
    id_vaga INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cargo INT NOT NULL,
    vl_quantidade INT NOT NULL CHECK (vl_quantidade > 0),
    st_vaga CHAR(2) NOT NULL CHECK (st_vaga IN ('AB','FE')),

    CONSTRAINT FK_SRH_VAGA FOREIGN KEY (id_cargo)
        REFERENCES TB_SRH_CARGO (id_cargo)
);