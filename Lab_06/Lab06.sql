-- Zadanie 6.1, baza danych: cukiernia

-- 1. Napisz i wykonaj zapytanie (użyj INSERT), które dodaje do tabeli czekoladki następujące informacje: idczekoladki: W98, nazwa: Biały kieł, czekolada: biała, orzechy: laskowe, nadzienie: marcepan, opis: Rozpływające się w rękach i kieszeniach, koszt: 45 gr, masa: 20 g.

INSERT INTO czekoladki VALUES('W98', 'Biały kieł', 'biała', 'laskowe', 'marcepan', 'Rozpływające się w rękach i kieszeniach', '45', '20');

-- 2. Napisz i wykonaj trzy zapytania (użyj INSERT), które dodadzą do tabeli klienci następujące dane osobowe:
-- idklienta: 90, nazwa: Matusiak Edward, ulica: Kropiwnickiego 6/3, miejscowosc: Leningrad, kod: 31-471, telefon: 031 423 45 38;
-- idklienta: 91, nazwa: Matusiak Alina, ulica: Kropiwnickiego 6/3, miejscowosc: Leningrad, kod: 31-471, telefon: 031 423 45 38;
-- idklienta: 92, nazwa: Kimono Franek, ulica: Karateków 8, miejscowosc: Mistrz, kod: 30-029, telefon: 501 498 324.

INSERT INTO klienci VALUES('90', 'Matusiak Edward', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38');
INSERT INTO klienci VALUES('91', 'Matusiak ALina', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38');
INSERT INTO klienci VALUES('92', 'Kimono Franek', 'Karateków 8', 'Mistrz', '30-029', '501 498 324');

-- 3. Dodaj do tabeli klienci dane Izy Matusiak (idklienta 93). Pozostałe dane osobowe Izy Matusiak muszą być takie same jak dla Pana Edwarda Matusiaka. Użyj podzapytań.

INSERT INTO klienci SELECT '93', 'Iza Matusiak', ulica, miejscowosc, kod, telefon FROM klienci WHERE idklienta = 90;

-- 4. Sprawdź, czy napisane przez Ciebie zapytania odniosły pożądany skutek tj. czy do w/w tabel zostały dodane odpowiednie wiersze, wykorzystaj SELECT.

SELECT * FROM klienci WHERE idklienta = 93;

--------------------------------------
-- Zadanie 6.2, baza danych: cukiernia

-- 1. Napisz i wykonaj zapytanie, które doda do tabeli czekoladki następujące pozycje, wykorzystaj wartości NULL w poleceniu INSERT:
-- IDCzekoladki: X91, Nazwa: Nieznana Nieznajoma, Opis: Niewidzialna czekoladka wspomagajaca odchudzanie., Koszt: 26 gr, Masa: 0g;
-- IDCzekoladki: M98, Nazwa: Mleczny Raj, Czekolada: Mleczna, Opis: Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem., Koszt: 26 gr, Masa: 36 g,

\d+ czekoladki;
INSERT INTO czekoladki VALUES ('X91', 'Nieznana Nieznajoma', NULL, NULL, NULL, 'Niewidzialna czekoladka wspomagajaca odchudzanie.', '26', '0');
INSERT INTO czekoladki VALUES ('M98', 'Nieznana Nieznajoma', 'Mleczna', NULL, NULL, 'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.', '26', '36');


-- 2. Sprawdź, czy napisane przez Ciebie zapytania odniosły pożądany skutek tj. czy do w/w tabel zostały dodane odpowiednie wiersze, wykorzystaj SELECT.

SELECT * FROM czekoladki WHERE idczekoladki = 'M98' OR idczekoladki = 'X91';

--------------------------------------
-- Zadanie 6.3, baza danych: cukiernia

-- 1. Napisz zapytanie, które usunie informacje dodane w Zadaniu 6.2, użyj DELETE.

DELETE FROM czekoladki WHERE idczekoladki IN ('M98', 'X91');

-- 2. Sprawdź, czy odpowiednie rekordy zostały usunięte.

SELECT * FROM czekoladki WHERE idczekoladki = 'M98' OR idczekoladki = 'X91';

-- 3. Napisz i wykonaj zapytanie, które doda do tabeli czekoladki następujące pozycje, wykorzystaj nazwy kolumn w poleceniu INSERT:
-- IDCzekoladki: X91, Nazwa: Nieznana Nieznajoma, Opis: Niewidzialna czekoladka wspomagajaca odchudzanie., Koszt: 26 gr, Masa: 0g;
-- IDCzekoladki: M98, Nazwa: Mleczny Raj, Czekolada: Mleczna, Opis: Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem., Koszt: 26 gr, Masa: 36g;

INSERT INTO czekoladki (idczekoladki, nazwa, opis, koszt, masa) VALUES('X91', 'Nieznana Nieznajoma', 'Niewidzialna czekoladka wspomagajaca odchudzanie.', '26', '0');
INSERT INTO czekoladki (idczekoladki, nazwa, czekolada, opis, koszt, masa) VALUES ('M98', 'Mleczny Raj', 'Mleczna', 'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.', '26', '36');

-- 4. Sprawdź, czy napisane przez Ciebie zapytania odniosły pożądany skutek tj. czy do w/w tabel zostały dodane odpowiednie wiersze, wykorzystaj SELECT.

SELECT * FROM czekoladki WHERE idczekoladki IN ('M98', 'X91');

--------------------------------------
-- Zadanie 6.4, baza danych: cukiernia

-- Napisz instrukcje aktualizujące dane w bazie cukiernia. Sprawdź za pomocą instrukcji SELECT, czy odpowiednie rekordy zostały zmienione.

-- 1. Zmiana nazwiska Izy Matusiak na Nowak.

UPDATE klienci SET nazwa = 'Nowak Iza' WHERE nazwa = 'Matusiak Iza';
SELECT * FROM klienci WHERE idklienta = 93;

-- 2. Obniżenie kosztu czekoladek o identyfikatorach (idczekoladki): W98, M98 i X91, o 10%.

UPDATE czekoladki SET koszt = 0.9 * koszt WHERE idczekoladki IN ('W98', 'M98', 'X91');

-- 3. Ustalenie kosztu czekoladek o nazwie Nieznana Nieznajoma na taką samą jak cena czekoladki o identyfikatorze W98.

UPDATE czekoladki SET koszt = (SELECT koszt FROM czekoladki WHERE idczekoladki = 'W98') WHERE nazwa = 'Nieznana Nieznajoma';
SELECT * FROM czekoladki WHERE nazwa = 'Nieznana Nieznajoma';

-- 4. Zmiana nazwy z Leningrad na Piotrograd w tabeli klienci.

UPDATE klienci SET miejscowosc = 'Piotrograd' WHERE miejscowosc = 'Leningrad';

-- 5. Podniesienie kosztu czekoladek, których dwa ostatnie znaki identyfikatora (idczekoladki) są większe od 90, o 15 groszy.

UPDATE czekoladki SET koszt = koszt + 15 WHERE idczekoladki LIKE '_9_';

--------------------------------------
-- Zadanie 6.5, baza danych: cukiernia

-- Napisz instrukcje usuwające z bazy danych informacje o:

-- 1. Klientach o nazwisku Matusiak.

DELETE FROM klienci WHERE nazwa LIKE '%Matusiak%';
SELECT * FROM klienci WHERE nazwa LIKE '%Matusiak%';

-- 2. Klientach o identyfikatorze większym niż 91.

DELETE FROM klienci WHERE idklienta > 91;

-- 3. Czekoladkach, których koszt jest większy lub równy 0.45 lub masa jest większa lub równa 36, lub masa jest równa 0.

DELETE FROM czekoladki WHERE masa >= 36 OR masa = 0 OR koszt >= 0.45;

--------------------------------------
-- Zadanie 6.6, baza danych: cukiernia

-- Napisz skrypt zawierający instrukcje INSERT wstawiające do bazy danych Cukiernia dwa nowe rekordy do tabeli Pudelka oraz odpowiednie rekordy związane z tymi pudełkami do tabeli Zawartosc. Każde z nowych pudełek ma zawierać łącznie co najmniej 10 czekoladek, w co najmniej 4 różnych smakach.

File name: Ex_6_6.sql

------------------------------------------------------------
-- Zadanie 6.7, baza danych: cukiernia, oprogramowanie: psql

-- 1. Polecenie COPY pozwala m.in. kopiowanie danych między bazą danych i standardowym systemem plików. Polecenie COPY FROM kopiuje dane z pliku do wskazanej tabeli. Domyślnie wartości atrybutów są oddzielane tabulatorem, zaś NULL jest oznaczany symbolem \N. Polecenie COPY TO kopiuje dane z bazy danych (cała tabela, wybrane kolumny lub wynik instrukcji SELECT) do pliku. Opcje polecenia pozwalają zdefiniować m.in. separator, oznaczenia wartości null, oznaczenie napisu pustego itp. http://www.postgresql.org/docs/9.1/static/sql-copy.html



-- 2. Napisz skrypt zawierający instrukcje COPY wstawiające do bazy danych cukiernia dwa nowe rekordy do tabeli pudelka oraz odpowiednie rekordy związane z tymi pudełkami do tabeli zawartosc. Każde z nowych pudełek ma zawierać łącznie co najmniej 10 czekoladek, w co najmniej 4 różnych smakach.



--------------------------------------
-- Zadanie 6.8, baza danych: cukiernia

-- 1. Napisz instrukcję UDPATE, która dla pudełek dodanych w poprzednich dwóch zadaniach, zwiększa o 1 liczbę czekoladek każdego smaku, które w nich występują.

UPDATE zawartosc SET sztuk = sztuk + 1 WHERE idpudelka = 'NB01';
UPDATE zawartosc SET sztuk = sztuk + 1 WHERE idpudelka = 'NB02';

-- 2. Napisz skrypt zawierający instrukcje UPDATE, które modyfikują tabelę czekoladki zastępując w kolumnach: czekolada, orzechy i nadzienie wartości Null wartością “brak”.

File: Ex_6_8.sql

-- 3. Napisz skrypt zawierający instrukcje UPDATE, które anulują zmiany wprowadzone w poprzednim punkcie.
