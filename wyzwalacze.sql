CREATE TRIGGER aktualizacja_pensji_insert
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
CREATE TRIGGER aktualizacja_wydatkow_delete
ON Kalendarz AFTER DELETE
AS
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
		IF(dbo.JestNaUrlopie(@nr_pracownika,@data) <> 0)
		BEGIN
			SET @suma = @suma + ((SELECT Stawka FROM Pracownik WHERE Nr = @nr_pracownika)*(SELECT LiczbaGodzin FROM inserted))
		END
		FETCH kursor INTO @nr_pracownika
	END
	CLOSE kursor
	DEALLOCATE kursor

	DECLARE @data_wypłaty DATE = (SELECT DATEFROMPARTS(YEAR(@data), MONTH(@data),1)

	UPDATE WydatkiZyski
	SET Kwota = Kwota + @suma
	WHERE MiejsceBudowy = @nr_brygady AND Data = @data_wypłaty AND Szczegóły = 'Wypłaty'
	
	IF((SELECT Kwota FROM WydatkiZyski WHERE MiejsceBudowy = @nr_brygady AND Data = @data_wypłaty AND Szczegóły = 'Wypłaty') = 0)
		DELETE FROM WydatkiZyski WHERE MiejsceBudowy = @nr_brygady AND Data = @data_wypłaty AND Szczegóły = 'Wypłaty'

END
------------------------------------------------------
CREATE TRIGGER aktualizacja_pensji_delete
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
CREATE TRIGGER ZmienZwierzchnikaUpdate
ON Brygady AFTER UPDATE
AS
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
CREATE TRIGGER aktualizacja_wydatkow_insert
ON Kalendarz AFTER INSERT
AS
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
		IF(dbo.JestNaUrlopie(@nr_pracownika,@data) <> 0)
		BEGIN
			SET @suma = @suma + ((SELECT Stawka FROM Pracownik WHERE Nr = @nr_pracownika)*(SELECT LiczbaGodzin FROM inserted))
		END
		FETCH kursor INTO @nr_pracownika
	END
	CLOSE kursor
	DEALLOCATE kursor

	DECLARE @data_wypłaty DATE = (SELECT DATEFROMPARTS(YEAR(@data), MONTH(@data),1)

	IF(NOT EXISTS(SELECT * FROM WydatkiZyski WHERE MiejsceBudowy = @nr_budowy AND Data = @data_wypłaty AND Szczegóły = 'Wypłaty'))
	BEGIN
		INSERT INTO WydatkiZyski VALUES (@nr_budowy, @data_wypłaty,-@suma,'Wypłaty')
	END
	ELSE
	BEGIN
		UPDATE WydatkiZyski
		SET Kwota = Kwota - @suma
		WHERE MiejsceBudowy = @nr_brygady AND Data = @data_wypłaty AND Szczegóły = 'Wypłaty'
	END

END
