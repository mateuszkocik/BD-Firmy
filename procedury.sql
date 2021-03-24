CREATE PROCEDURE PodniesienieObnizenieStawki @nr_pracownika INT, @roznica_stawki INT
AS

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

GO
------------------------------------------------------
CREATE PROCEDURE DajBonus @nr_pracownika INT, @rok INT, @miesiac INT, @bonus INT
AS
	IF(NOT EXISTS(SELECT NrPracownika FROM Pensje WHERE NrPracownika = @nr_pracownika AND Rok = @rok AND Miesiac = @miesiac))
		INSERT INTO Pensje VALUES (@nr_pracownika, @miesiac, @rok, 0, 0, @bonus)
	ELSE
	BEGIN
		UPDATE Pensje
		SET Bonus = Bonus + @bonus
		WHERE NrPracownika = @nr_pracownika AND Rok = @rok AND Miesiac = @miesiac
	END
GO
------------------------------------------------------
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
CREATE PROCEDURE zmien_ilosc @nazwa_produktu VARCHAR(256), @roznica_ilosci INT
AS
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
GO

------------------------------------------------------
CREATE PROCEDURE przelozenie_terminu @numer_budowy INT, @nowy_termin DATE
AS
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
GO
