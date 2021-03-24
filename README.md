# BD-Firmy
Baza danych firmy budowlanej

## Tabele
* Brygady
* Kalendarz
* Magazyn
* MiejsceBudowy
* Pensje
* Pracownik
* Samochody
* Urlopy
* WydatkiZyski
* Zapotrzebowanie

## Widoki
| Nazwa  | Opis |
| ------------- | ------------- |
| ZawartoscMagazynu  | Produkty których ilość jest większa od 0  |
| Brygadzisci  | Wszyscy brygadziści  |
| KsiazkaTelefoniczna | Numer telefonu do każdego z pracowników |
| NieprzypisaneSamochody | Samochody, które nie są przypisane do żadnej z brygad |

## Funkcje
| Nazwa  | Opis |
| ------------- | ------------- |
| WyplatyPracownika | Zwraca wszystkie wypłaty danego pracownika |
| JestNaUrlopie | Sprawdza czy pracownik w danym terminie był na urlopie |
| PracownicyBrygady | Zwraca pracowników danej brygady |
| Bilans | Zwraca sumę zysków i wydatków z danej budowy |
| KartkaKalendarza | Zwraca wszystkie szczególy jakie prace zostały wykonane w danym dniu |
| BrakiWMagazynie | Dla podanej budowy zwraca produkty, których nie ma w magazynie, a będą potrzebne w pracy |

## Procedury Składowane
| Nazwa  | Opis |
| ------------- | ------------- |
| PodniesienieObnizenieStawki | Zmienia stawkę pracownika o podaną różnicę |
| DajBonus | Do standardowej pensji pracownika dodaje kwotę podaną w parametrze |
| ZakonczBudowe | Zakańcza daną budowę |
| zmien_ilosc | Zmnienia ilość produktu w magazynie o podaną różnicę |
| przelozenie_terminu | Dla danej budowy ustawia termin na datę podaną w parametrze |

## Wyzwalacze
| Nazwa  | Opis |
| ------------- | ------------- |
| aktualizacja_pensji_insert | Po wstawieniu rekordu do tabeli Kalendarz tabela Pensje jest aktualizowana aby zawsze zawierała aktualną pensję dla każdego pracownika |
| aktualizacja_pensji_delete | Podobnie jak powyższy wyzwalacz lecz w przypadku usunięcia rekordu |
| aktualizacja_wydatkow_insert | Po wstawieniu rekordu do tabeli Kalendarz tabela WydatkiZyski jest aktualizowana aby zawsze zawierała aktualny stan dla każdej budowy |
| aktualizacja_wydatkow_delete | Podobnie jak powyższy wyzwalacz lecz w przypadku usunięcia rekordu |
| ZmienZwierzchnikaUpdate | Po zmianie brygadzisty w danej brygadzie tabela rekordy z tabeli Pracownik są aktualizowane |
