CREATE TABLE Brygady 
    (
     Nr INTEGER NOT NULL , 
     Brygadzista INTEGER NOT NULL , 
     Samochod VARCHAR (7) NOT NULL 
    )
GO

ALTER TABLE Brygady ADD CONSTRAINT Brygady_PK PRIMARY KEY CLUSTERED (Nr)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Kalendarz 
    (
     Data DATE NOT NULL , 
     Brygada INTEGER NOT NULL , 
     MiejsceBudowy INTEGER NOT NULL , 
     WykonywaneZajecie VARCHAR (256) NOT NULL , 
     LiczbaGodzin INTEGER NOT NULL 
    )
GO

ALTER TABLE Kalendarz ADD CONSTRAINT Kalendarz_PK PRIMARY KEY CLUSTERED (MiejsceBudowy, Brygada, Data)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Magazyn 
    (
     NazwaProduktu VARCHAR (256) NOT NULL , 
     Kategoria VARCHAR (256) NOT NULL , 
     Ilosc INTEGER NOT NULL 
    )
GO

ALTER TABLE Magazyn ADD CONSTRAINT Magazyn_PK PRIMARY KEY CLUSTERED (NazwaProduktu)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE MiejsceBudowy 
    (
     Nr INTEGER NOT NULL , 
     Adres VARCHAR (256) NOT NULL , 
     KierownikBudowy VARCHAR (256) NOT NULL , 
     Termin DATE NOT NULL , 
     RodzajBudowy VARCHAR (256) NOT NULL , 
     Status BIT NOT NULL 
    )
GO

ALTER TABLE MiejsceBudowy ADD CONSTRAINT MiejsceBudowy_PK PRIMARY KEY CLUSTERED (Nr)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Pensje 
    (
     NrPracownika INTEGER NOT NULL , 
     Miesiac SMALLINT NOT NULL , 
     Rok INTEGER NOT NULL , 
     LiczbaGodzin INTEGER NOT NULL , 
     Kwota INTEGER NOT NULL , 
     Bonus INTEGER NOT NULL 
    )
GO

ALTER TABLE Pensje ADD CONSTRAINT Pensje_PK PRIMARY KEY CLUSTERED (NrPracownika, Miesiac, Rok)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Pracownik 
    (
     Nr INTEGER NOT NULL , 
     Imie VARCHAR (50) NOT NULL , 
     Nazwisko VARCHAR (50) NOT NULL , 
     Stawka MONEY NOT NULL , 
     Data_Przyjecia DATE NOT NULL , 
     NrZwierzchnika INTEGER , 
     Brygada INTEGER , 
     NrTelefonu VARCHAR (9) , 
     MiejsceZamieszkania VARCHAR (50) NOT NULL 
    )
GO

ALTER TABLE Pracownik ADD CONSTRAINT Pracownik_PK PRIMARY KEY CLUSTERED (Nr)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Samochody 
    (
     NrRejestracji VARCHAR (7) NOT NULL , 
     Marka VARCHAR (30) NOT NULL , 
     KoniecPrzegladu DATE NOT NULL , 
     Sprawny BIT NOT NULL 
    )
GO

ALTER TABLE Samochody ADD CONSTRAINT Samochody_PK PRIMARY KEY CLUSTERED (NrRejestracji)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Urlopy 
    (
     NrPracownika INTEGER NOT NULL , 
     Od DATE NOT NULL , 
     Do DATE NOT NULL 
    )
GO

ALTER TABLE Urlopy ADD CONSTRAINT Urlopy_PK PRIMARY KEY CLUSTERED (NrPracownika, Od)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE WydatkiZyski 
    (
     MiejsceBudowy INTEGER NOT NULL , 
     Data DATE NOT NULL , 
     Kwota INTEGER NOT NULL , 
     Szczegóły VARCHAR (256) NOT NULL 
    )
GO

CREATE TABLE Zapotrzebowanie 
    (
     NrBudowy INTEGER NOT NULL , 
     NazwaProduktu VARCHAR (256) NOT NULL , 
     Ilosc INTEGER NOT NULL 
    )
GO

ALTER TABLE Brygady 
    ADD CONSTRAINT Brygady_Pracownik_FK FOREIGN KEY 
    ( 
     Brygadzista
    ) 
    REFERENCES Pracownik 
    ( 
     Nr 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Brygady 
    ADD CONSTRAINT Brygady_Samochody_FK FOREIGN KEY 
    ( 
     Samochod
    ) 
    REFERENCES Samochody 
    ( 
     NrRejestracji 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Kalendarz 
    ADD CONSTRAINT Kalendarz_Brygady_FK FOREIGN KEY 
    ( 
     Brygada
    ) 
    REFERENCES Brygady 
    ( 
     Nr 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Kalendarz 
    ADD CONSTRAINT Kalendarz_MiejsceBudowy_FK FOREIGN KEY 
    ( 
     MiejsceBudowy
    ) 
    REFERENCES MiejsceBudowy 
    ( 
     Nr 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Pensje 
    ADD CONSTRAINT Pensje_Pracownik_FK FOREIGN KEY 
    ( 
     NrPracownika
    ) 
    REFERENCES Pracownik 
    ( 
     Nr 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Pracownik 
    ADD CONSTRAINT Pracownik_Pracownik_FK FOREIGN KEY 
    ( 
     NrZwierzchnika
    ) 
    REFERENCES Pracownik 
    ( 
     Nr 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Urlopy 
    ADD CONSTRAINT Urlopy_Pracownik_FK FOREIGN KEY 
    ( 
     NrPracownika
    ) 
    REFERENCES Pracownik 
    ( 
     Nr 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE WydatkiZyski 
    ADD CONSTRAINT WydatkiZyski_MiejsceBudowy_FK FOREIGN KEY 
    ( 
     MiejsceBudowy
    ) 
    REFERENCES MiejsceBudowy 
    ( 
     Nr 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Zapotrzebowanie 
    ADD CONSTRAINT Zapotrzebowanie_Magazyn_FK FOREIGN KEY 
    ( 
     NazwaProduktu
    ) 
    REFERENCES Magazyn 
    ( 
     NazwaProduktu 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Zapotrzebowanie 
    ADD CONSTRAINT Zapotrzebowanie_MiejsceBudowy_FK FOREIGN KEY 
    ( 
     NrBudowy
    ) 
    REFERENCES MiejsceBudowy 
    ( 
     Nr 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO


------------------------------------------------------
ALTER TABLE Pracownik
ADD CONSTRAINT WartoscStawki CHECK (Stawka > 0)

ALTER TABLE Urlopy
ADD CONSTRAINT OdMniejszeDo CHECK (Od < Do)

ALTER TABLE Magazyn
ADD CONSTRAINT Ilosc CHECK (Ilosc >= 0)

ALTER TABLE Zapotrzebowanie
ADD CONSTRAINT IloscZap CHECK (Ilosc >= 0)

------------------------------------------------------	
GO
CREATE FUNCTION WyplatyPracownika (@nr_pracownika INT)
RETURNS TABLE
AS
RETURN
	SELECT P.Rok, P.Miesiac, P.LiczbaGodzin, P.Kwota, P.Bonus
	FROM Pensje P
	WHERE NrPracownika = @nr_pracownika
------------------------------------------------------	
GO
CREATE FUNCTION JestNaUrlopie (@nr_pracownika INT,@data DATE)
RETURNS BIT
AS
BEGIN
	DECLARE @od DATE, @do DATE;
	SELECT TOP 1 @od = U.Od,@do = U.Do
	FROM Urlopy U
	WHERE U.NrPracownika = @nr_pracownika
	ORDER BY U.Do DESC
	IF @data BETWEEN @od AND @do
	RETURN 1
	
	RETURN 0
END

------------------------------------------------------
GO
CREATE FUNCTION PracownicyBrygady (@nr_brygady INT)
RETURNS TABLE
AS
RETURN
	SELECT P.Nr, P.Imie, P.Nazwisko
	FROM Pracownik P
	WHERE P.Brygada = @nr_brygady
------------------------------------------------------
GO
CREATE VIEW ZawartoscMagazynu AS
SELECT * FROM Magazyn
WHERE Ilosc > 0
------------------------------------------------------
GO
CREATE VIEW Brygadzisci AS
SELECT B.Nr Numer_Brygady, P.Nr Numer_Pracownika, P.Imie, P.Nazwisko, P.NrTelefonu
FROM
Pracownik P JOIN Brygady B ON P.Nr = B.Brygadzista
------------------------------------------------------
GO
CREATE FUNCTION Bilans (@nr_budowy INT)
RETURNS INT
AS
BEGIN
	DECLARE @suma INT = 
	(SELECT SUM(W.Kwota)
	FROM WydatkiZyski W
	WHERE W.MiejsceBudowy = @nr_budowy)
	RETURN @suma
END;
------------------------------------------------------
GO
CREATE VIEW KsiazkaTelefoniczna AS
SELECT Imie, Nazwisko, NrTelefonu
FROM Pracownik
------------------------------------------------------
GO
CREATE FUNCTION KartkaKalendarza (@data DATE)
RETURNS TABLE
AS
RETURN
	SELECT * FROM Kalendarz K
	WHERE K.Data = @data
------------------------------------------------------
GO
CREATE FUNCTION BrakiWMagazynie (@nr_budowy INT)
RETURNS @braki TABLE(
	nazwa VARCHAR(256),
	ilosc INT)
AS
BEGIN
	DECLARE @ilosc INT
	DECLARE @nazwa VARCHAR(256)
	DECLARE kursor CURSOR LOCAL
	FOR SELECT Ilosc, NazwaProduktu FROM Zapotrzebowanie WHERE NrBudowy = @nr_budowy
	FOR READ ONLY

	OPEN kursor
	FETCH kursor INTO @ilosc, @nazwa
	WHILE @@FETCH_STATUS  = 0
	BEGIN
		DECLARE @roznica INT = @ilosc-(SELECT Ilosc FROM Magazyn WHERE NazwaProduktu = @nazwa)
		IF(@roznica > 0)
			INSERT INTO @braki VALUES(@nazwa,@roznica)
		
		FETCH kursor INTO @ilosc,@nazwa
	END
	CLOSE kursor
	DEALLOCATE kursor
	RETURN;
END
------------------------------------------------------
GO
CREATE VIEW NieprzypisaneSamochody AS
SELECT * FROM Samochody 
WHERE NrRejestracji NOT IN
(SELECT S.NrRejestracji FROM Samochody S JOIN Brygady B
ON S.NrRejestracji = B.Samochod)
------------------------------------------------------
GO
CREATE PROCEDURE PodniesienieObnizenieStawki @nr_pracownika INT, @roznica_stawki INT
AS
BEGIN
	DECLARE @nowa_stawka INT = (SELECT Stawka FROM Pracownik WHERE Nr = @nr_pracownika) + @roznica_stawki
	IF(@nowa_stawka <= 0)
		BEGIN
			PRINT('Wystąpił błąd, nowa stawka nie może być <= 0');
		END
	ELSE
		BEGIN
			UPDATE Pracownik
			SET Stawka = @nowa_stawka
			WHERE Nr = @nr_pracownika
		END
END

------------------------------------------------------
GO
CREATE PROCEDURE DajBonus @nr_pracownika INT, @rok INT, @miesiac INT, @bonus INT
AS
BEGIN
	IF(NOT EXISTS(SELECT NrPracownika FROM Pensje WHERE NrPracownika = @nr_pracownika AND Rok = @rok AND Miesiac = @miesiac))
		INSERT INTO Pensje VALUES (@nr_pracownika, @miesiac, @rok, 0, 0, @bonus)
	ELSE
	BEGIN
		UPDATE Pensje
		SET Bonus = Bonus + @bonus
		WHERE NrPracownika = @nr_pracownika AND Rok = @rok AND Miesiac = @miesiac
	END
END	
------------------------------------------------------
GO
CREATE PROCEDURE ZakonczBudowe (@nr_budowy INT)
AS
BEGIN
	IF(NOT EXISTS (SELECT * FROM MiejsceBudowy WHERE Nr = @nr_budowy))
		PRINT('Nie istnieje budowa o tym numerze')
	ELSE IF((SELECT M.Status FROM MiejsceBudowy M WHERE M.Nr = @nr_budowy) = 0)
		PRINT('Budowa juz jest zakonczona')
	ELSE
	BEGIN
		UPDATE MiejsceBudowy
		SET Status = 0
		WHERE Nr = @nr_budowy
	END
END
------------------------------------------------------
GO
CREATE PROCEDURE ZmienIlosc  @nazwa_produktu VARCHAR(256), @roznica_ilosci INT
AS
BEGIN
	DECLARE @nowa_ilosc INT = (SELECT Ilosc FROM Magazyn WHERE NazwaProduktu = @nazwa_produktu) + @roznica_ilosci
	IF(@nowa_ilosc < 0)
	BEGIN
		PRINT('Odejowanie wiekszej ilosci niz stan magazynu, wpisywanie 0 jako ilość')
		UPDATE Magazyn
		SET Ilosc = 0
		WHERE NazwaProduktu = @nazwa_produktu
	END
	ELSE
	BEGIN
		UPDATE Magazyn
		SET Ilosc = @nowa_ilosc
		WHERE NazwaProduktu = @nazwa_produktu
	END	
END
------------------------------------------------------
GO
CREATE PROCEDURE PrzelozenieTerminu @numer_budowy INT, @nowy_termin DATE
AS
BEGIN
	IF((SELECT Status FROM MiejsceBudowy WHERE Nr = @numer_budowy) = 0)
	BEGIN
		PRINT('Budowa jest już zakończona, nie zostanie zmieniony termin')
	END
	ELSE
	BEGIN
		UPDATE MiejsceBudowy
		SET Termin = @nowy_termin
		WHERE Nr = @numer_budowy
	END
END
------------------------------------------------------
GO
CREATE TRIGGER AktualizacjaPensjiInsert
ON Kalendarz AFTER INSERT AS
BEGIN
	DECLARE @data DATE = (SELECT I.Data FROM inserted I)
	DECLARE @liczba_godzin INT = (SELECT LiczbaGodzin FROM inserted)
	DECLARE @miesiac INT = MONTH(@data)
	DECLARE @rok INT = YEAR(@data)
	DECLARE @nr_brygady INT = (SELECT Brygada FROM inserted)
	DECLARE @nr_pracownika INT
	DECLARE kursor CURSOR LOCAL
		FOR SELECT Nr FROM Pracownik WHERE Brygada = @nr_brygady 
		FOR READ ONLY
	OPEN kursor
	FETCH kursor INTO @nr_pracownika
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF(dbo.JestNaUrlopie(@nr_pracownika,@data) = 0)
		BEGIN
			IF(NOT EXISTS (SELECT * FROM Pensje WHERE NrPracownika = @nr_pracownika AND Miesiac = @miesiac AND Rok = @rok))
			BEGIN
				INSERT INTO Pensje VALUES (@nr_pracownika,@miesiac,@rok,@liczba_godzin, @liczba_godzin * (SELECT Stawka FROM Pracownik WHERE Nr = @nr_pracownika),0)
			END
			ELSE
			BEGIN
				UPDATE Pensje SET 
				Kwota = Kwota + (SELECT Stawka FROM Pracownik WHERE Nr = @nr_pracownika)*@liczba_godzin,
				LiczbaGodzin = LiczbaGodzin + @liczba_godzin
				WHERE NrPracownika = @nr_pracownika
			END
		END
		FETCH kursor INTO @nr_pracownika
	END
	CLOSE kursor
	DEALLOCATE kursor
END
------------------------------------------------------
GO
CREATE TRIGGER AktualizacjaPensjiDelete
ON Kalendarz AFTER DELETE AS
BEGIN
	DECLARE @data DATE = (SELECT I.Data FROM deleted I)
	DECLARE @liczba_godzin INT = (SELECT LiczbaGodzin FROM deleted)
	DECLARE @miesiac INT = MONTH(@data)
	DECLARE @rok INT = YEAR(@data)
	DECLARE @nr_brygady INT = (SELECT Brygada FROM deleted)
	DECLARE @nr_pracownika INT
	DECLARE kursor CURSOR LOCAL
		FOR SELECT Nr FROM Pracownik WHERE Brygada = @nr_brygady 
		FOR READ ONLY
	OPEN kursor
	FETCH kursor INTO @nr_pracownika
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF(dbo.JestNaUrlopie(@nr_pracownika,@data) <> 0)
		BEGIN
			DECLARE @nowa_kwota INT = (SELECT Kwota FROM Pensje WHERE NrPracownika = @nr_pracownika) - (SELECT Stawka FROM Pracownik WHERE Nr = @nr_pracownika)*@liczba_godzin
			DECLARE @nowa_liczba_godzin INT = (SELECT LiczbaGodzin FROM Pensje WHERE NrPracownika = @nr_pracownika) - @liczba_godzin
			DECLARE @bonus INT = (SELECT Bonus FROM Pensje WHERE NrPracownika = @nr_pracownika)
			IF(@nowa_kwota <= 0 AND @nowa_liczba_godzin <=0 AND @bonus = 0)
			BEGIN
				DELETE FROM Pensje WHERE NrPracownika = @nr_pracownika AND Rok = @rok AND Miesiac = @miesiac
			END
			ELSE
			BEGIN
				UPDATE Pensje SET 
				Kwota = @nowa_kwota,
				LiczbaGodzin = @nowa_liczba_godzin
				WHERE NrPracownika = @nr_pracownika
			END
			
		END
		FETCH kursor INTO @nr_pracownika
	END
	CLOSE kursor
	DEALLOCATE kursor
END
------------------------------------------------------
GO
CREATE TRIGGER ZmienZwierzchnikaUpdate
ON Brygady AFTER UPDATE AS
BEGIN
	DECLARE @nr_brygady INT = (SELECT Nr FROM deleted)
	DECLARE @stary_brygadzista INT = (SELECT Brygadzista FROM deleted)
	DECLARE @nowy_brygadzista INT = (SELECT Brygadzista FROM inserted)
	IF(@nowy_brygadzista <> @stary_brygadzista)
	BEGIN
		UPDATE Pracownik
		SET NrZwierzchnika = @nowy_brygadzista
		WHERE Brygada = @nr_brygady

		UPDATE Pracownik
		SET NrZwierzchnika = 1
		WHERE Nr = @nowy_brygadzista
	END
END
------------------------------------------------------
GO
CREATE TRIGGER AktualizacjaWydatkowInsert
ON Kalendarz AFTER INSERT AS
BEGIN
	DECLARE @nr_budowy INT = (SELECT MiejsceBudowy FROM inserted)
	DECLARE @nr_brygady INT = (SELECT Brygada FROM inserted)
	DECLARE @data DATE = (SELECT Data FROM inserted)
	DECLARE @suma INT = 0
	DECLARE @nr_pracownika INT
	DECLARE kursor CURSOR LOCAL
		FOR SELECT Nr FROM Pracownik WHERE Brygada = @nr_brygady 
		FOR READ ONLY
	OPEN kursor
	FETCH kursor INTO @nr_pracownika
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF(dbo.JestNaUrlopie(@nr_pracownika,@data) = 0)
		BEGIN
			SET @suma = @suma + ((SELECT Stawka FROM Pracownik WHERE Nr = @nr_pracownika)*(SELECT LiczbaGodzin FROM inserted))
		END
		FETCH kursor INTO @nr_pracownika
	END
	CLOSE kursor
	DEALLOCATE kursor

	DECLARE @data_wypłaty DATE = (SELECT DATEFROMPARTS(YEAR(@data), MONTH(@data),1))

	IF(NOT EXISTS(SELECT * FROM WydatkiZyski W WHERE W.MiejsceBudowy = @nr_budowy AND W.Data = @data_wypłaty AND W.Szczegóły = 'Wypłaty'))
	BEGIN
		INSERT INTO WydatkiZyski VALUES (@nr_budowy, @data_wypłaty,0-@suma,'Wypłaty')
	END
	ELSE
	BEGIN
		UPDATE WydatkiZyski
		SET Kwota = Kwota - @suma
		WHERE MiejsceBudowy = @nr_brygady AND Data = @data_wypłaty AND Szczegóły = 'Wypłaty'
	END

END
------------------------------------------------------
GO
CREATE TRIGGER AktualizacjaWydatkowDelete
ON Kalendarz AFTER DELETE AS
BEGIN
	DECLARE @nr_budowy INT = (SELECT MiejsceBudowy FROM inserted)
	DECLARE @nr_brygady INT = (SELECT Brygada FROM inserted)
	DECLARE @data DATE = (SELECT Data FROM inserted)
	DECLARE @suma INT = 0
	DECLARE @nr_pracownika INT
	DECLARE kursor CURSOR LOCAL
		FOR SELECT Nr FROM Pracownik WHERE Brygada = @nr_brygady 
		FOR READ ONLY
	OPEN kursor
	FETCH kursor INTO @nr_pracownika
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF(dbo.JestNaUrlopie(@nr_pracownika,@data) = 0)
		BEGIN
			SET @suma = @suma + ((SELECT Stawka FROM Pracownik WHERE Nr = @nr_pracownika)*(SELECT LiczbaGodzin FROM inserted))
		END
		FETCH kursor INTO @nr_pracownika
	END
	CLOSE kursor
	DEALLOCATE kursor
	DECLARE @data_wypłaty DATE = (SELECT DATEFROMPARTS(YEAR(@data), MONTH(@data),1))

	
	UPDATE WydatkiZyski
	SET Kwota = Kwota + @suma
	WHERE MiejsceBudowy = @nr_brygady AND Data = @data_wypłaty AND Szczegóły = 'Wypłaty'
	IF((SELECT Kwota FROM WydatkiZyski WHERE MiejsceBudowy = @nr_brygady AND Data = @data_wypłaty AND Szczegóły = 'Wypłaty') = 0)
		DELETE FROM WydatkiZyski WHERE MiejsceBudowy = @nr_brygady AND Data = @data_wypłaty AND Szczegóły = 'Wypłaty'

END
------------------------------------------------------
INSERT INTO Pracownik VALUES
(1,'Adam','Kowalski',30.0,'2010-10-01',NULL,1,'123456789','Krakow'),
(2,'Mariusz','Adamowski',20.0,'2011-01-07',1,1,'501234001','Warszawa'),
(3,'Wojciech','Kowal',18.5,'2011-02-05',1,1,'','Krakow'),
(4,'Marek','Wrona',15.0,'2016-01-22',1,1,'987654321','Piaseczno'),
(5,'Jan','Gawlik',19.0,'2012-05-11',1,2,'573427982','Krakow'),
(6,'Bartosz','Szalwia',15.0,'2013-06-01',5,2,'876234010','Krakow'),
(7,'Piotr','Rumianek',11.0,'2018-12-01',5,2,'129496789','Mielno'),
(8,'Michał','Wróbel',14.5,'2017-07-19',5,2,'999999999','Koszalin'),
(9,'Jakub','Wodniak',15.0,'2015-10-01',5,2,'605231005','Krakow'),
(10,'Andrzej','Gąsior',15.5,'2017-10-11',5,2,'533101962','Toruń')

INSERT INTO Samochody VALUES
('KR12345','Renault','2020-10-10',1),
('KR50TU1','Peugeot','2022-01-15',1),
('KRA10BC','Volkswagen','2021-06-22',1),
('KR5A5B1','Volkswagen','2019-11-01',0)

INSERT INTO Brygady VALUES
(1,2,'KR12345'),
(2,5,'KR50TU1')

INSERT INTO Urlopy VALUES
(2,'2012-01-10','2012-01-11'),
(4,'2017-11-01', '2017-12-01'),
(7,'2019-02-01','2019-02-14')

INSERT INTO MiejsceBudowy VALUES 
(1,'Kraków ul. Juliana Fałata 7 30-109', 'Marek Buc','2020-11-10','Ocieplenie',1),
(2,'Kraków ul. Focha 12 30-202', 'Michał Korbka','2021-12-01','Izolacja',1),
(3,'Kraków ul. Armii Krajowej 7 30-112', 'Wojciech Bąk','2020-06-15','Ocieplenie',1)

INSERT INTO Magazyn VALUES
('Dysperbit DN, IZOLEX', 'Masy Dyspersyjne',10),
('Dysperbit grunt (Asfalbit)IZOLEX', 'Masy Dyspersyjne',5),
('Folia aluminiowa termo-izolacyjna m2', 'Folie i Izolacje Fundamentów', 0),
('Folia fundamentowa pionowa, Eurovent PM 8N', 'Folie i Izolacje Fundamentów', 0),
('Folia hydroizolacyjna PVC, gr. 1.1 mm.', 'Folie i Izolacje Fundamentów',0),
('Klej poliuretanowy, EASY SOUDABOND, 750 ml. SOUDAL', 'Kleje do Styropianu',13),
('Kołek do styropianu, opakowanie 100 szt.', 'Akcesoria Elewacyjne', 0),
('Listwa podtynkowa W6', 'Akcesoria Elewacyjne', 0),
('Narożnik aluminiowy z siatką','Akcesoria Elewacyjne',10),
('Siatka elewacyjna z włókna szklanego do styropianu, rolka 50 m2.', 'Akcesoria Elewacyjne',0),
('Listwa startowa', 'Akcesoria Elewacyjne', 11),
('Masa bitumiczna, Izobit Br, IZOLEX', 'Masy Dyspersyjne', 0),
('Membrana dachowa, EUROVENT MAXI limited, rolka 75 m2.', '	Folie i Izolacje Fundamentów',4),
('Styropian, EPS 100', 'Styropian', 20),
('Styropian, EPS 70', 'Styropian', 20),
('Styropian, EPS 40', 'Styropian', 20)

INSERT INTO Zapotrzebowanie VALUES
(1,'Folia aluminiowa termo-izolacyjna m2',15),
(1,'Styropian, EPS 100',10),
(1,'Listwa startowa',3),
(1,'Kołek do styropianu, opakowanie 100 szt.',1),
(2,'Membrana dachowa, EUROVENT MAXI limited, rolka 75 m2.',2),
(2,'Folia hydroizolacyjna PVC, gr. 1.1 mm.',10),
(3,'Folia fundamentowa pionowa, Eurovent PM 8N',22),
(3,'Styropian, EPS 40',30),
(3,'Listwa startowa',10)

INSERT INTO Kalendarz VALUES
('2019-12-10',1,1,'Mocowanie, przyklejanie i łączenie płyt',10)
INSERT INTO Kalendarz VALUES
('2019-12-10',2,1,'Mocowanie, przyklejanie i łączenie płyt',12)
INSERT INTO Kalendarz VALUES
('2019-12-16',1,1,'Zbrojenie siatkami ochronnymi',9)
INSERT INTO Kalendarz VALUES
('2019-12-17',2,1,'Zbrojenie siatkami ochronnymi',10)
INSERT INTO Kalendarz VALUES
('2019-12-20',1,1,'Nakładanie zaprawy tynkarskiej, malowanie',12)
INSERT INTO Kalendarz VALUES
('2019-12-27',1,2,'Usuwanie starych elementów',10)
INSERT INTO Kalendarz VALUES
('2020-01-03',2,2,'Uszczelnianie',9)
INSERT INTO Kalendarz VALUES
('2020-01-04',1,2,'Sprzątanie',3)


INSERT INTO WydatkiZyski VALUES
(1,'2019-12-07',-1500,'Zapotrzebowanie'),
(1,'2019-12-10',-300,'Paliwo'),
(1,'2019-12-30',3500,'Zapłata za budowę'),
(2,'2019-12-10',-1000,'Zapotrzebowanie'),
(2,'2019-12-19',-300,'Kara za wybite okno'),
(2,'2020-01-04',2000,'Zapłata za budowę')
