CREATE DATABASE GerenciamentoEstoque;
USE GerenciamentoEstoque;
CREATE TABLE Produtos (
    ProdutoID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Quantidade INT
);
CREATE TABLE RegistroEstoque (
    RegistroID INT PRIMARY KEY AUTO_INCREMENT,
    ProdutoID INT,
    Acao VARCHAR(50),
    QuantidadeAlterada INT,
    DataHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);
INSERT INTO Produtos (ProdutoID, Nome, Quantidade) VALUES
(1, 'Camiseta', 100),
(2, 'Calça Jeans', 50),
(3, 'Tênis', 80);
DELIMITER //

CREATE TRIGGER AfterInsertRegistroEstoque
AFTER INSERT ON RegistroEstoque
FOR EACH ROW
BEGIN
    DECLARE acao VARCHAR(50);
    SET acao = NEW.Acao;

    IF acao = 'Entrada' THEN
        UPDATE Produtos SET Quantidade = Quantidade + NEW.QuantidadeAlterada WHERE ProdutoID = NEW.ProdutoID;
    ELSEIF acao = 'Saída' THEN
        UPDATE Produtos SET Quantidade = Quantidade - NEW.QuantidadeAlterada WHERE ProdutoID = NEW.ProdutoID;
    END IF;
END;//

DELIMITER ;