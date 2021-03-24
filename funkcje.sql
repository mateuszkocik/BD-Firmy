------------------------------------------------------
CREATE FUNCTION WyplatyPracownika (@nr_pracownika INT)
RETURNS TABLE
AS
RETURN
	SELECT P.Rok, P.Miesiac, P.LiczbaGodzin, P.Kwota, P.Bonus
	FROM Pensje P
	WHERE NrPracownika = @nr_pracownika
------------------------------------------------------	
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
END;

------------------------------------------------------	
CREATE FUNCTION PracownicyBrygady (@nr_brygady INT)
RETURNS TABLE
AS
RETURN
	SELECT P.Nr, P.Imie, P.Nazwisko
	FROM Pracownik P
	WHERE P.Brygada = @nr_brygady
------------------------------------------------------
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
CREATE FUNCTION KartkaKalendarza (@data DATE)
RETURNS TABLE
AS
RETURN
	SELECT * FROM Kalendarz K
	WHERE K.Data = @data
------------------------------------------------------
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
