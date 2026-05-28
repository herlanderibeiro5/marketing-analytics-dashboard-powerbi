```sql
-- =========================================
-- CREATE DATABASE
-- =========================================

CREATE DATABASE MarketingAnalyticsDB;
GO

USE MarketingAnalyticsDB;
GO


-- =========================================
-- CREATE TABLE: Campanhas
-- =========================================

CREATE TABLE Campanhas (
    campanha_id INT IDENTITY(1,1) PRIMARY KEY,
    nome_campanha VARCHAR(100),
    canal VARCHAR(50),
    investimento DECIMAL(10,2),
    data_inicio DATE,
    data_fim DATE
);


-- =========================================
-- CREATE TABLE: Leads
-- =========================================

CREATE TABLE Leads (
    lead_id INT IDENTITY(1,1) PRIMARY KEY,
    campanha_id INT,
    nome_lead VARCHAR(100),
    origem VARCHAR(50),
    cidade VARCHAR(50),
    data_lead DATE,

    CONSTRAINT FK_Leads_Campanhas
    FOREIGN KEY (campanha_id)
    REFERENCES Campanhas(campanha_id)
);


-- =========================================
-- CREATE TABLE: Conversoes
-- =========================================

CREATE TABLE Conversoes (
    conversion_id INT IDENTITY(1,1) PRIMARY KEY,
    lead_id INT,
    data_conversao DATE,
    convertido BIT,
    valor_venda DECIMAL(10,2),

    CONSTRAINT FK_Conversoes_Leads
    FOREIGN KEY (lead_id)
    REFERENCES Leads(lead_id)
);


-- =========================================
-- INSERT CAMPANHAS
-- =========================================

INSERT INTO Campanhas
(nome_campanha, canal, investimento, data_inicio, data_fim)
VALUES
('Summer Ads', 'Google Ads', 2500.00, '2024-01-01', '2024-01-31'),
('Instagram Growth', 'Instagram', 1800.00, '2024-02-01', '2024-02-28'),
('LinkedIn B2B', 'LinkedIn', 3200.00, '2024-03-01', '2024-03-31'),
('Email Blast', 'Email Marketing', 900.00, '2024-04-01', '2024-04-30'),
('Organic Campaign', 'Blog', 0.00, '2024-05-01', '2024-06-30');


-- =========================================
-- INSERT LEADS
-- =========================================

INSERT INTO Leads
(campanha_id, nome_lead, origem, cidade, data_lead)
VALUES
(1, 'Joao Silva', 'Google Ads', 'Lisboa', '2024-01-05'),
(1, 'Maria Costa', 'Google Ads', 'Porto', '2024-01-07'),
(1, 'Carlos Mendes', 'Google Ads', 'Coimbra', '2024-01-09'),

(2, 'Ana Ribeiro', 'Instagram', 'Lisboa', '2024-02-03'),
(2, 'Pedro Santos', 'Instagram', 'Braga', '2024-02-10'),
(2, 'Juliana Lima', 'Instagram', 'Faro', '2024-02-15'),

(3, 'Ricardo Alves', 'LinkedIn', 'Lisboa', '2024-03-05'),
(3, 'Fernanda Rocha', 'LinkedIn', 'Porto', '2024-03-08'),
(3, 'Tiago Martins', 'LinkedIn', 'Aveiro', '2024-03-11'),

(4, 'Sofia Almeida', 'Email', 'Lisboa', '2024-04-02'),
(4, 'Miguel Pereira', 'Email', 'Braga', '2024-04-05'),
(4, 'Patricia Gomes', 'Email', 'Coimbra', '2024-04-08'),

(5, 'Raimundo Cruz', 'Blog', 'Lisboa', '2024-05-11'),
(5, 'Patricia Macedo', 'Blog', 'Braga', '2024-05-12'),
(5, 'Angelo Silva', 'Blog', 'Lisboa', '2024-06-11'),
(5, 'Fernanda Paris', 'Blog', 'Braga', '2024-06-12'),

(2, 'Lucas Ferreira', 'Instagram', 'Lisboa', '2024-02-18'),
(3, 'Camila Duarte', 'LinkedIn', 'Porto', '2024-03-20');


-- =========================================
-- INSERT CONVERSOES
-- =========================================

INSERT INTO Conversoes
(lead_id, data_conversao, convertido, valor_venda)
VALUES
(1, '2024-01-10', 1, 4200),
(2, '2024-01-15', 1, 3100),
(3, '2024-01-20', 0, 0),

(4, '2024-02-12', 1, 5200),
(5, '2024-02-18', 1, 4700),
(6, '2024-02-22', 0, 0),

(7, '2024-03-10', 1, 6800),
(8, '2024-03-15', 0, 0),
(9, '2024-03-21', 1, 7300),

(10, '2024-04-08', 1, 2100),
(11, '2024-04-12', 0, 0),
(12, '2024-04-18', 1, 3900),

(13, '2024-05-25', 1, 5820),
(14, '2024-05-10', 1, 4575),
(15, '2024-06-30', 1, 2800),
(16, '2024-06-15', 1, 7500),

(17, '2024-02-25', 1, 6400),
(18, '2024-03-28', 0, 0);


-- =========================================
-- SELECTS
-- =========================================

SELECT * FROM Campanhas;

SELECT * FROM Leads;

SELECT * FROM Conversoes;


-- =========================================
-- JOIN FINAL ANALYTICS VIEW
-- =========================================

SELECT
    c.campanha_id,
    c.nome_campanha,
    c.canal,
    c.investimento,
    l.lead_id,
    l.nome_lead,
    l.cidade,
    l.data_lead,
    cv.data_conversao,
    cv.convertido,
    cv.valor_venda
FROM Conversoes cv
INNER JOIN Leads l
    ON cv.lead_id = l.lead_id
INNER JOIN Campanhas c
    ON l.campanha_id = c.campanha_id;

