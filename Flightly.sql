CREATE DATABASE FLIGHTLY;
USE FLIGHTLY;
CREATE TABLE USUARIO 
( 
 idUsuario INT PRIMARY KEY AUTO_INCREMENT,  
 Nome VARCHAR(70) NOT NULL,  
 Email VARCHAR(70) NOT NULL,  
 Senha VARCHAR(30) NOT NULL,  
 Preferencias VARCHAR(80),  
 UNIQUE (Email)
); 

CREATE TABLE PLANO_VIAGEM 
( 
 idUsuario INT,  
 idPlano INT PRIMARY KEY AUTO_INCREMENT,  
 Nome VARCHAR(60) NOT NULL,  
 Descricao VARCHAR(120)
); 

CREATE TABLE VOO 
( 
 idVoo INT PRIMARY KEY,  
 Companhia VARCHAR(40) NOT NULL,  
 Aeroporto_Ida VARCHAR(4) NOT NULL,  
 Aeroporto_Volta VARCHAR(4),  
 Dia_Ida DATE NOT NULL,  
 Dia_Volta DATE,  
 Preco FLOAT NOT NULL,  
 Link VARCHAR(150)
); 

CREATE TABLE HOSPEDAGEM 
( 
 idHospedagem INT PRIMARY KEY AUTO_INCREMENT,  
 Check_In DATE NOT NULL,  
 Check_Out DATE,  
 Preco FLOAT NOT NULL,  
 Link VARCHAR(150) 
); 

CREATE TABLE TRANSPORTE 
( 
 idTransporte INT PRIMARY KEY AUTO_INCREMENT,  
 Modelo VARCHAR(30) NOT NULL,  
 Marca VARCHAR(30) NOT NULL,  
 Preco_Locacao FLOAT NOT NULL,  
 Link VARCHAR(150)
);

CREATE TABLE PONTO_TURISTICO 
( 
 idPontTurist INT PRIMARY KEY AUTO_INCREMENT,  
 Pais VARCHAR(30),  
 Estado VARCHAR(30),  
 Nome VARCHAR(80),  
 Link VARCHAR(150)
); 


CREATE TABLE Voo_Plano 
( 
 idVooPlano INT PRIMARY KEY AUTO_INCREMENT,  
 idPlano INT,  
 idVoo INT
); 

CREATE TABLE Hosp_Plano 
( 
 idHospPlano INT PRIMARY KEY AUTO_INCREMENT,  
 idPlano INT,  
 idHospedagem INT  
); 

CREATE TABLE Turismo_Plano 
( 
 idTurismoPlano INT PRIMARY KEY AUTO_INCREMENT,  
 idPlano INT,  
 idPontTurist INT
); 

CREATE TABLE Transporte_Plano 
( 
 idTransportePlano INT PRIMARY KEY AUTO_INCREMENT,  
 idPlano INT,  
 idTransporte INT
); 

ALTER TABLE PLANO_VIAGEM ADD FOREIGN KEY(idUsuario) REFERENCES USUARIO (idUsuario);
ALTER TABLE Voo_Plano ADD FOREIGN KEY(idPlano) REFERENCES PLANO_VIAGEM (idPlano);
ALTER TABLE Voo_Plano ADD FOREIGN KEY(idVoo) REFERENCES VOO (idVoo);
ALTER TABLE Hosp_Plano ADD FOREIGN KEY(idPlano) REFERENCES PLANO_VIAGEM (idPlano);
ALTER TABLE Hosp_Plano ADD FOREIGN KEY(idHospedagem) REFERENCES HOSPEDAGEM (idHospedagem);
ALTER TABLE Turismo_Plano ADD FOREIGN KEY(idPlano) REFERENCES PLANO_VIAGEM (idPlano);
ALTER TABLE Turismo_Plano ADD FOREIGN KEY(idPontTurist) REFERENCES PONTO_TURISTICO (idPontTurist);
ALTER TABLE Transporte_Plano ADD FOREIGN KEY(idPlano) REFERENCES PLANO_VIAGEM (idPlano);
ALTER TABLE Transporte_Plano ADD FOREIGN KEY(idTransporte) REFERENCES TRANSPORTE (idTransporte);

delimiter //
CREATE TRIGGER Exclui_Voo AFTER DELETE on Voo_Plano FOR each row
Begin
	IF(Select Count(*) from Voo_Plano where idVoo = OLD.idVoo)<1 Then 
   DELETE FROM Voo where Voo.idVoo = old.idVoo ;
   END IF;
End
//
delimiter //
CREATE TRIGGER Exclui_Hosp AFTER DELETE on Hosp_Plano FOR each row
Begin
	IF(Select Count(*) from Hosp_Plano where idHospedagem = OLD.idHospedagem)<1 Then 
   DELETE FROM Hospedagem where Hospedagem.idHospedagem = old.idHospedagem ;
   END IF;
End
//
delimiter //
CREATE TRIGGER Exclui_Turismo AFTER DELETE on Turismo_Plano FOR each row
Begin
	IF(Select Count(*) from Turismo_Plano where idPontTurist = OLD.idPontTurist)<1 Then 
   DELETE FROM Ponto_Turistico where Turismo.idPontTurist = old.idPontTurist ;
   END IF;
End
//
delimiter //
CREATE TRIGGER Exclui_Transporte AFTER DELETE on Transporte_Plano FOR each row
Begin
	IF(Select Count(*) from Transporte_Plano where idTransporte = OLD.idTransporte)<1 Then 
   DELETE FROM Transporte where Transporte.idTransporte = old.idTransporte ;
   END IF;
End
//


    
