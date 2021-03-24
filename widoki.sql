CREATE VIEW ZawartoscMagazynu AS
SELECT * FROM Magazyn
WHERE Ilosc > 0
------------------------------------------------------
CREATE VIEW Brygadzisci AS
SELECT B.Nr Numer_Brygady, P.Nr Numer_Pracownika, P.Imie, P.Nazwisko, P.NrTelefonu
FROM Pracownik P JOIN Brygady B ON P.Nr = B.Brygadzista
------------------------------------------------------
CREATE VIEW KsiazkaTelefoniczna AS
SELECT Imie, Nazwisko, NrTelefonu
FROM Pracownik
------------------------------------------------------
CREATE VIEW NieprzypisaneSamochody AS
SELECT * FROM Samochody 
WHERE NrRejestracji NOT IN
(SELECT S.NrRejestracji FROM Samochody S JOIN Brygady B
ON S.NrRejestracji = B.Samochod)
