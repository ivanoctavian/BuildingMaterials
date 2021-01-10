#SOURCE C:/Users/Ivanutzu/Desktop/Proiect BD/script22.sql;


/*#############################################################*/
/*        PARTEA 1 - STERGEREA SI RECREAREA BAZEI DE DATE      */



DROP DATABASE materialeDB;
CREATE DATABASE materialeDB;
USE materialeDB;
/*#############################################################*/



/*#############################################################*/
/*                  PARTEA 2 - CREAREA TABELELOR              */

CREATE TABLE tblAngajati (
    idAngajat int(3) ZEROFILL NOT NULL,
    Nume varchar(50) NOT NULL,
    Prenume varchar(50) NOT NULL,
    Functie varchar(50) NOT NULL,
    DataAngajarii date,
    Telefon varchar(15) NOT NULL,
    Email varchar(50) NOT NULL,
    SalariuRON int,
    CONSTRAINT tblAngajati_pk PRIMARY KEY (idAngajat)
);

CREATE TABLE tblMateriale (
    idMaterial int NOT NULL,
    ProducatorFK int(3) ZEROFILL NOT NULL,
    RaionFK varchar(5) NOT NULL,
    Denumire varchar(50) NOT NULL,
    Unitati int NOT NULL,
    PretRON decimal(7,2) NOT NULL,
    GarantieLuni int,
    CONSTRAINT tblMateriale_pk PRIMARY KEY (idMaterial)
);

CREATE TABLE tblProducatori (
    idProducator int(3) ZEROFILL NOT NULL,
    Denumire varchar(50) NOT NULL,
    Sediu varchar(100) NOT NULL,
    Telefon varchar(15) NOT NULL,
    Email varchar(50) NOT NULL,
    CONSTRAINT tblProducatori_pk PRIMARY KEY (idProducator)
);

CREATE TABLE tblRaioane (
    idRaion varchar(5) NOT NULL,
    Categorie varchar(50) NOT NULL,
    Localizare varchar(50) NOT NULL,
    CONSTRAINT tblRaioane_pk PRIMARY KEY (idRaion)
);

CREATE TABLE tblResponsabiliRaioane (
    idResponsabilitate int NOT NULL,
    AngajatFK int(3) ZEROFILL NOT NULL,
    RaionFK varchar(5) NOT NULL,
    TuraLucru date NOT NULL,
    CONSTRAINT tblResponsabiliRaioane_pk PRIMARY KEY (idResponsabilitate)
);
CREATE TABLE tblUsers(
	idUser int NOT NULL AUTO_INCREMENT,
	Username VARCHAR(50) NOT NULL UNIQUE,
	Nume VARCHAR(50),
	Prenume VARCHAR(50),
	Email VARCHAR(50),
	Password VARCHAR(200) NOT NULL,
	PRIMARY KEY (idUser, username)

);
ALTER TABLE tblMateriale ADD CONSTRAINT tblMateriale_tblProducatori FOREIGN KEY tblMateriale_tblProducatori (ProducatorFK)
    REFERENCES tblProducatori (idProducator)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE tblMateriale ADD CONSTRAINT tblMateriale_tblRaioane FOREIGN KEY tblMateriale_tblRaioane (RaionFK)
    REFERENCES tblRaioane (idRaion)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE tblResponsabiliRaioane ADD CONSTRAINT tblResponsabiliRaioane_tblAngajati FOREIGN KEY tblResponsabiliRaioane_tblAngajati (AngajatFK)
    REFERENCES tblAngajati (idAngajat)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE tblResponsabiliRaioane ADD CONSTRAINT tblResponsabiliRaioane_tblRaioane FOREIGN KEY tblResponsabiliRaioane_tblRaioane (RaionFK)
    REFERENCES tblRaioane (idRaion)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

/*#############################################################*/




/*#############################################################*/
/*         PARTEA 3 - INSERAREA INREGISTRARILOR IN TABELE      */

INSERT INTO tblRaioane VALUES('R5', 'Vopsele', 'Interior');
INSERT INTO tblRaioane VALUES('J2', 'Gradinarit', 'Exterior');
INSERT INTO tblRaioane VALUES('S4', 'Sanitare', 'Interior');
INSERT INTO tblRaioane VALUES('E9', 'Electrice', 'Interior');
INSERT INTO tblRaioane VALUES('P2', 'Parchete', 'Interior');
INSERT INTO tblRaioane VALUES('Z4', 'Zidarie', 'Interior');
INSERT INTO tblRaioane VALUES('C9', 'Caramizi', 'Interior');
INSERT INTO tblRaioane VALUES('C3', 'BCA', 'Interior');
INSERT INTO tblRaioane VALUES('F5', 'Fier', 'Interior');
INSERT INTO tblRaioane VALUES('C09', 'Ciment', 'Interior');
INSERT INTO tblRaioane VALUES('T4', 'Tencuiala', 'Interior');
INSERT INTO tblRaioane VALUES('E3', 'Gleturi', 'Interior');
INSERT INTO tblRaioane VALUES('M6', 'Metalurgice', 'Interior');
INSERT INTO tblRaioane VALUES('C34', 'Chimice', 'Interior');

INSERT INTO tblAngajati VALUES(1,'Ivan','Octavian','Operator Stivuitor','2020-11-10','0760231456','ivan.octavian@yahoo.com',2200);
INSERT INTO tblAngajati VALUES(2,'Cruceru','Tiberiu','Operator Stivuitor','2020-09-05','0762271251','tibi.cruceru@yahoo.com',2200);
INSERT INTO tblAngajati VALUES(3,'Visan','Adrian','Manager','2019-03-04','0760321204','visanadrian@yahoo.com',6000);
INSERT INTO tblAngajati VALUES(4,'Toma','Andy','Operator Stivuitor','2020-05-04','0772587456','tomaandy@yahoo.com',2200);
INSERT INTO tblAngajati VALUES(5,'Petre','Rares','Asistent','2020-11-11','0752456232','petre.rares@yahoo.com',4500);
INSERT INTO tblAngajati VALUES(6,'Chiscu','Razvan','Manager','2020-07-06','0765782304','chiscu@yahoo.com',6000);
INSERT INTO tblAngajati VALUES(7,'Stoica','Mihai','Asistent','2020-02-01','0761204523','mmstoica@yahoo.com',4500);
INSERT INTO tblAngajati VALUES(8,'Iordache','Andrei','Asistent','2018-07-05','0763452000','andrei.iordache@yahoo.com',5000);
INSERT INTO tblAngajati VALUES(9,'Bololoi','Mihaela','Asistent','2019-01-01','0760232454','mihaela.luminita@yahoo.com',4500);
INSERT INTO tblAngajati VALUES(10,'Ghira','Cristian','Asistent','2020-11-12','0769203456','christighira@yahoo.com',4500);

INSERT INTO tblProducatori VALUES(1, "Adeplast", "Ploiesti","0789345632", "adeplastRO@yahoo.com");
INSERT INTO tblProducatori VALUES(2, "Baumit", "Bucuresti", "0350489546", "baumitRO@gmail.com");
INSERT INTO tblProducatori VALUES(3, "Bison", "Targu Jiu", "0350594815", "bisonRO@gmail.com");
INSERT INTO tblProducatori VALUES(4, "Ceresit", "Drobeta Turnu-Severin", "0789456731", "ceresitRO@yahoo.com");
INSERT INTO tblProducatori VALUES(5, "Oskar", "Magurele", "0350985768", "oskarRO@yahoo.com");
INSERT INTO tblProducatori VALUES(6, "Kober", "Pitesti", "0730291752", "koberRO@yahoo.com");
INSERT INTO tblProducatori VALUES(7, "EuroNarcis", "Timisoara", "0350983201", "euronarcis@yahoo.com");
INSERT INTO tblProducatori VALUES(8, "Spax", "Oradea", "0743281057", "spaxRO@gmail.com");
INSERT INTO tblProducatori VALUES(9, "Mapei", "RmValcea", "0350982013", "mapeiRO@yahoo.com");
INSERT INTO tblProducatori VALUES(10, "Savana", "Arad", "0789321564", "savana@hotmail.com");
INSERT INTO tblProducatori VALUES(11, "Carpatcement", "Giurgiu", "0789234981", "carpatcementRO@gmail.com");
INSERT INTO tblProducatori VALUES(12, "Gardener's supply", "Calarasi", "0729234981", "gardenerRO@gmail.com");

INSERT INTO tblResponsabiliRaioane VALUES(1,4,'F5','2020-11-25');
INSERT INTO tblResponsabiliRaioane VALUES(2,3,'R5','2020-11-26');
INSERT INTO tblResponsabiliRaioane VALUES(3,4,'C3','2020-11-25');
INSERT INTO tblResponsabiliRaioane VALUES(4,7,'T4','2020-11-24');
INSERT INTO tblResponsabiliRaioane VALUES(5,10,'F5','2020-11-27');
INSERT INTO tblResponsabiliRaioane VALUES(6,4,'T4','2020-11-26');
INSERT INTO tblResponsabiliRaioane VALUES(7,6,'Z4','2020-11-25');
INSERT INTO tblResponsabiliRaioane VALUES(8,8,'F5','2020-11-28');
INSERT INTO tblResponsabiliRaioane VALUES(9,9,'S4','2020-11-29');
INSERT INTO tblResponsabiliRaioane VALUES(10,1,'J2','2020-11-28');

INSERT INTO tblMateriale VALUES(1, 11, "C09", "Ciment++", 400, 18, 0);
INSERT INTO tblMateriale VALUES(2, 4, "Z4", "CX5", 500, 15, 0);
INSERT INTO tblMateriale VALUES(3, 7, "M6", "SurubPentruLemn", 1500, 0.5, 12);
INSERT INTO tblMateriale VALUES(4, 5, "R5", "Lavabila", 15, 20, 3);
INSERT INTO tblMateriale VALUES(5, 9, "C34", "Vopsea Primer", 18, 100, 3);
INSERT INTO tblMateriale VALUES(6, 9, "J2", "Pamant de flori", 203, 199.99, 0);
INSERT INTO tblMateriale VALUES(7, 11, "C09", "Ciment++", 400, 18, 0);
INSERT INTO tblMateriale VALUES(8, 8, "M6", "Surub stea", 721, 0.3,0);
INSERT INTO tblMateriale VALUES(9, 10,"R5", "Teflon 20", 89, 89.99,3);
INSERT INTO tblMateriale VALUES(10,12, "J2", "Grebla", 15, 34.99, 6); 
INSERT INTO tblMateriale VALUES(11,1, "T4", "AFX-17", 53, 18.99,0); 

/*#############################################################*/



/*#############################################################*/
/*  PARTEA 4 - VIZUALIZAREA STUCTURII BD SI A INREGISTRARILOR  */
DESCRIBE tblAngajati;
DESCRIBE tblProducatori;
DESCRIBE tblRaioane;
DESCRIBE tblMateriale;
DESCRIBE tblResponsabiliRaioane;

SELECT * FROM tblAngajati;
SELECT * FROM tblProducatori;
SELECT * FROM tblRaioane;
SELECT * FROM tblMateriale;
SELECT * FROM tblResponsabiliRaioane;
SELECT * FROM tblUsers;
/*#############################################################*/
