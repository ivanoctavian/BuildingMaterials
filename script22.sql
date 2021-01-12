# SOURCE C:/Users/Ivanutzu/Desktop/Proiect BD/script22_F3.sql;
#SOURCE C:/Users/X/Desktop/labBD/proiectBD/script22.sql;


/*#############################################################*/
/*        PARTEA 1 - STERGEREA SI RECREAREA BAZEI DE DATE      */



DROP DATABASE materialeDB;
CREATE DATABASE materialeDB;
USE materialeDB;
/*#############################################################*/



/*#############################################################*/
/*                  PARTEA 2 - CREAREA TABELELOR              */

CREATE TABLE tblAngajati (
    idAngajat int(3) ZEROFILL NOT NULL AUTO_INCREMENT,
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
    idMaterial int NOT NULL AUTO_INCREMENT,
    ProducatorFK int(3) ZEROFILL NOT NULL,
    RaionFK varchar(5) NOT NULL,
    Denumire varchar(50) NOT NULL,
    Unitati int NOT NULL,
    PretRON decimal(7,2) NOT NULL,
    GarantieLuni int,
    CONSTRAINT tblMateriale_pk PRIMARY KEY (idMaterial)
);

CREATE TABLE tblProducatori (
    idProducator int(3) ZEROFILL NOT NULL AUTO_INCREMENT,
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
    idResponsabilitate int NOT NULL AUTO_INCREMENT,
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

INSERT INTO tblRaioane VALUES('A1', 'Vopsele', 'Interior');
INSERT INTO tblRaioane VALUES('A2', 'Sanitare', 'Interior');
INSERT INTO tblRaioane VALUES('A3', 'Electrice', 'Interior');
INSERT INTO tblRaioane VALUES('A4', 'Parchete', 'Interior');
INSERT INTO tblRaioane VALUES('A5', 'Zidarie', 'Interior');
INSERT INTO tblRaioane VALUES('B1', 'Caramizi', 'Interior');
INSERT INTO tblRaioane VALUES('B2', 'BCA', 'Interior');
INSERT INTO tblRaioane VALUES('B3', 'Fier', 'Interior');
INSERT INTO tblRaioane VALUES('B4', 'Ciment', 'Interior');
INSERT INTO tblRaioane VALUES('B5', 'Tencuiala', 'Interior');
INSERT INTO tblRaioane VALUES('C1', 'Gleturi', 'Interior');
INSERT INTO tblRaioane VALUES('C2', 'Metalurgice', 'Interior');
INSERT INTO tblRaioane VALUES('C3', 'Chimice', 'Interior');
INSERT INTO tblRaioane VALUES('C4', 'Gradinarit', 'Exterior');
INSERT INTO tblRaioane VALUES('C5', 'Perdele', 'Exterior');






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
INSERT INTO tblAngajati VALUES(11,'Mihailescu','Alina','Asistent','2020-03-12','0724905040','mihalina@gmail.com',4500);
INSERT INTO tblAngajati VALUES(12,'Slav','Victor','Manager','2017-01-12','0744203456','vslav@hotmail.com',8500);



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
INSERT INTO tblProducatori VALUES(13, "Resitex", "Satu Mare", "07190321781", "resitexRO@gmail.com");

INSERT INTO tblResponsabiliRaioane VALUES(1,4,'A2','2021-01-25');
INSERT INTO tblResponsabiliRaioane VALUES(2,3,'B1','2021-01-26');
INSERT INTO tblResponsabiliRaioane VALUES(3,1,'C5','2021-01-25');
INSERT INTO tblResponsabiliRaioane VALUES(4,7,'C4','2021-01-24');
INSERT INTO tblResponsabiliRaioane VALUES(5,11,'A4','2021-01-27');
INSERT INTO tblResponsabiliRaioane VALUES(6,6,'C3','2021-01-26');
INSERT INTO tblResponsabiliRaioane VALUES(7,5,'B2','2021-01-25');
INSERT INTO tblResponsabiliRaioane VALUES(8,2,'B3','2021-01-28');
INSERT INTO tblResponsabiliRaioane VALUES(9,8,'A5','2021-01-29');
INSERT INTO tblResponsabiliRaioane VALUES(10,9,'B4','2021-01-28');
INSERT INTO tblResponsabiliRaioane VALUES(11,9,'C2','2020-02-01');
INSERT INTO tblResponsabiliRaioane VALUES(12,9,'C1','2020-02-01');
INSERT INTO tblResponsabiliRaioane VALUES(13,9,'A1','2020-02-02');
INSERT INTO tblResponsabiliRaioane VALUES(14,9,'A3','2020-02-03');
INSERT INTO tblResponsabiliRaioane VALUES(15,9,'B5','2020-02-04');

INSERT INTO tblMateriale VALUES(1, 11, "B4", "Ciment++", 400, 18, 0);
INSERT INTO tblMateriale VALUES(2, 4, "B4", "CX5", 500, 15, 0);
INSERT INTO tblMateriale VALUES(3, 7, "C2", "SurubPentruLemn", 1500, 0.5, 12);
############
INSERT INTO tblMateriale VALUES(4, 5, "A1", "Lavabila", 15, 20, 3);
INSERT INTO tblMateriale VALUES(5, 9, "A1", "Vopsea Primer", 18, 100, 3);
INSERT INTO tblMateriale VALUES(6, 9, "C4", "Pamant de flori", 203, 199.99, 0);
INSERT INTO tblMateriale VALUES(7, 8, "C2", "Surub stea", 721, 0.3,0);
INSERT INTO tblMateriale VALUES(8, 10,"C2", "Teflon 20", 89, 89.99,3);
INSERT INTO tblMateriale VALUES(9,12, "C4", "Grebla", 15, 34.99, 6);
INSERT INTO tblMateriale VALUES(10,1, "C1", "AFX-17", 53, 18.99,0);
#+15
INSERT INTO tblMateriale VALUES(11, 8, "C2", "Piulite", 1000, 0.3, 0);
INSERT INTO tblMateriale VALUES(12, 10, "A1", "Amorsa", 50, 16, 12);
INSERT INTO tblMateriale VALUES(13, 3, "C3", "Adeziv pt lipire metal", 30, 12, 8);
INSERT INTO tblMateriale VALUES(14, 6, "A1", "Pensula", 100, 7, 0);
INSERT INTO tblMateriale VALUES(15, 1, "C1", "Adeplast GM-20", 45, 15, 12);
INSERT INTO tblMateriale VALUES(16, 8, "C2", "Saiba", 800, 0.4, 0);
INSERT INTO tblMateriale VALUES(17, 12,"C4", "Lopata", 15, 25, 0);
INSERT INTO tblMateriale VALUES(18, 11,"B4", "Ciment Structo", 60, 18, 6);
INSERT INTO tblMateriale VALUES(19, 4, "B5", "Decorativa", 15, 35, 12);
INSERT INTO tblMateriale VALUES(20, 1, "C1", "Glet Ceresit CT 126", 25, 19, 6);
INSERT INTO tblMateriale VALUES(21, 7, "B1", "Mortar Sticla", 35, 14, 24);
INSERT INTO tblMateriale VALUES(22, 13,"C5", "Perdea Atria", 6, 40, 0);
INSERT INTO tblMateriale VALUES(23, 9, "C1", "Chit de rosturi", 23, 25, 18);
INSERT INTO tblMateriale VALUES(24, 10,"A1", "Superlavabila interior", 17, 26, 6);
INSERT INTO tblMateriale VALUES(25, 11, "B2", "Macon", 90, 58, 0);
INSERT INTO tblMateriale VALUES(26, 13, "A2", "Bideu", 6, 165, 24);
INSERT INTO tblMateriale VALUES(27, 1, "A5", "Boltar", 500, 25, 0);
INSERT INTO tblMateriale VALUES(28, 7, "A3", "Prize", 98, 10, 0);
INSERT INTO tblMateriale VALUES(29, 8, "B3", "Fier-beton", 27, 14, 0);
INSERT INTO tblMateriale VALUES(30, 3, "A4", "Parchet castan", 40, 27, 12);

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
