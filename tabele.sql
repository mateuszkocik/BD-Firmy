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

