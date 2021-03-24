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
(1,'Kraków ul. Juliana Fałata 7 30-109', 'Marek Buc','2020-11-10','Ocieplenie',1)


INSERT INTO Magazyn VALUES
('Dysperbit DN, IZOLEX', 'Masy Dyspersyjne',0),
('Dysperbit grunt (Asfalbit)IZOLEX', 'Masy Dyspersyjne',0),
('Folia aluminiowa termo-izolacyjna m2', 'Folie i Izolacje Fundamentów', 0),
('Folia fundamentowa pionowa, Eurovent PM 8N', 'Folie i Izolacje Fundamentów', 0),
('Folia hydroizolacyjna PVC, gr. 1.1 mm.', 'Folie i Izolacje Fundamentów',0),
('Klej poliuretanowy, EASY SOUDABOND, 750 ml. SOUDAL', 'Kleje do Styropianu',0),
('Kołek do styropianu, opakowanie 100 szt.', 'Akcesoria Elewacyjne', 0),
('Listwa podtynkowa W6', 'Akcesoria Elewacyjne', 0),
('Narożnik aluminiowy z siatką','Akcesoria Elewacyjne',0),
('Siatka elewacyjna z włókna szklanego do styropianu, rolka 50 m2.', 'Akcesoria Elewacyjne',0),
('Listwa startowa', 'Akcesoria Elewacyjne', 0),
('Masa bitumiczna, Izobit Br, IZOLEX', 'Masy Dyspersyjne', 0),
('Membrana dachowa, EUROVENT MAXI limited, rolka 75 m2.', '	Folie i Izolacje Fundamentów',0),
('Styropian, EPS 100', 'Styropian', 0),
('Styropian, EPS 70', 'Styropian', 0),
('Styropian, EPS 40', 'Styropian', 0)
