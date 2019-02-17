-- Zadanie 10.2, baza danych: cukiernia

-- Napisz zapytanie wyświetlające informacje na temat zamówień (dataRealizacji, idzamowienia) używając odpowiedniego operatora in/not in/exists/any/all, które:

-- 1. Zostały złożone przez klienta, który ma na imię Antoni.

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE idklienta IN (SELECT idklienta FROM klienci WHERE nazwa LIKE '%Antoni');

-- 2. Zostały złożone przez klientów z mieszkań (zwróć uwagę na pole ulica).

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE idklienta IN (SELECT idklienta FROM klienci WHERE ulica LIKE '%/%');

-- 3. Zostały złożone przez klienta z Krakowa do realizacji w listopadzie 2013 roku.

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE EXISTS (SELECT miejscowosc FROM klienci WHERE miejscowosc = 'Kraków' AND klienci.idklienta = zamowienia.idklienta AND datarealizacji BETWEEN '2013-11-01' AND '2013-11-30');

SELECT z.idklienta, z.idzamowienia, z.datarealizacji FROM zamowienia z, klienci k WHERE z.idklienta=k.idklienta and k.idklienta IN (SELECT idklienta FROM klienci k WHERE k.miejscowosc ilike 'Kraków' AND date_part('month',z.datarealizacji) = 11 AND date_part('year', z.datarealizacji) = 2013);

--------------------------------------
-- Zadanie 10.3, baza danych: cukiernia

-- Napisz zapytanie wyświetlające informacje na temat klientów (nazwa, ulica, miejscowość), używając odpowiedniego operatora in/not in/exists/any/all, którzy:

-- 1. Złożyli zamówienia z datą realizacji 12.11.2013.

SELECT nazwa, ulica, miejscowosc FROM klienci WHERE idklienta IN (SELECT idklienta FROM zamowienia WHERE datarealizacji = '2013-11-12');

-- 2. Złożyli zamówienia z datą realizacji w listopadzie 2013.

SELECT nazwa, ulica, miejscowosc FROM klienci WHERE idklienta IN (SELECT idklienta FROM zamowienia WHERE datarealizacji BETWEEN '2013-11-01' AND '2013-11-30');

-- 3. Zamówili pudełko Kremowa fantazja lub Kolekcja jesienna.

SELECT nazwa, ulica, miejscowosc FROM klienci WHERE idklienta IN (SELECT z.idklienta FROM zamowienia z NATURAL JOIN artykuly a NATURAL JOIN pudelka p WHERE p.nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna'));

-- 4. Zamówili co najmniej 2 sztuki pudełek Kremowa fantazja lub Kolekcja jesienna w ramach jednego zamówienia.

SELECT k.nazwa, k.ulica, k.miejscowosc FROM klienci k  WHERE k.idklienta IN (SELECT z.idklienta FROM zamowienia z NATURAL JOIN artykuly a NATURAL JOIN pudelka p WHERE p.nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna') AND a.sztuk >= 2);

-- 5. Zamówili pudełka, które zawierają czekoladki z migdałami.

SELECT nazwa, ulica, miejscowosc FROM klienci WHERE idklienta IN (SELECT z.idklienta FROM zamowienia z JOIN artykuly a USING(idzamowienia) JOIN pudelka p USING(idpudelka) JOIN zawartosc USING(idpudelka) JOIN czekoladki USING (idczekoladki) WHERE orzechy ilike 'migdały');

-- 6. Złożyli przynajmniej jedno zamówienie.

SELECT nazwa, ulica, miejscowosc FROM klienci WHERE idklienta IN (SELECT idklienta FROM zamowienia WHERE idklienta IS NOT NULL);
SELECT nazwa, ulica, miejscowosc FROM klienci WHERE EXISTS (SELECT idklienta FROM zamowienia);

-- 7. Nie złożyli żadnych zamówień.

SELECT nazwa, ulica, miejscowosc FROM klienci WHERE NOT EXISTS (SELECT idklienta FROM zamowienia where klienci.idklienta = zamowienia.idklienta);

--------------------------------------
-- Zadanie 10.4, baza danych: cukiernia

-- Napisz zapytanie wyświetlające informacje na temat pudełek z czekoladkami (nazwa, opis, cena), używając odpowiedniego operatora, np. in/not in/exists/any/all, które:

-- 1. Zawierają czekoladki o wartości klucza głównego D0.

SELECT p.nazwa, p.opis, p.cena FROM pudelka p WHERE p.idpudelka IN (SELECT DISTINCT idpudelka FROM zawartosc WHERE idczekoladki ilike 'D09');

-- 2. Zawierają czekoladki Gorzka truskawkowa.

SELECT DISTINCT p.nazwa, p.opis, p.cena FROM pudelka p WHERE p.idpudelka IN (SELECT z.idpudelka FROM zawartosc z WHERE z.idczekoladki IN (SELECT c.idczekoladki FROM czekoladki c WHERE c.nazwa ilike 'Gorzka truskawkowa'));

-- 3. Zawierają przynajmniej jedną czekoladkę, której nazwa zaczyna się na S.

SELECT DISTINCT p.nazwa, p.opis, p.cena FROM pudelka p WHERE p.idpudelka IN (SELECT z.idpudelka FROM zawartosc z WHERE z.idczekoladki IN (SELECT c.idczekoladki FROM czekoladki c WHERE c.nazwa LIKE 'S%'));

-- 4. Zawierają przynajmniej 4 sztuki czekoladek jednego gatunku (o takim samym kluczu głównym).

SELECT DISTINCT p.nazwa, p.opis, p.cena FROM pudelka p WHERE p.idpudelka IN (SELECT z.idpudelka FROM zawartosc z WHERE z.sztuk >= 4);

-- 5. Zawierają co najmniej 3 sztuki czekoladki Gorzka truskawkowa.

SELECT DISTINCT p.nazwa, p.opis, p.cena FROM pudelka p WHERE p.idpudelka IN (SELECT z.idpudelka FROM zawartosc z WHERE EXISTS (SELECT z.idczekoladki FROM czekoladki c WHERE c.nazwa ilike 'Gorzka truskawkowa' AND z.idczekoladki = c.idczekoladki) AND z.sztuk >= 3 );

-- 6. Zawierają czekoladki z nadzieniem truskawkowym.

SELECT DISTINCT p.nazwa, p.opis, p.cena FROM pudelka p WHERE p.idpudelka IN (SELECT DISTINCT z.idpudelka FROM zawartosc z WHERE z.idczekoladki IN  (SELECT c.idczekoladki FROM czekoladki c WHERE c.nadzienie ilike 'Truskawki'));

-- 7. Nie zawierają czekoladek w gorzkiej czekoladzie.

SELECT DISTINCT p.nazwa, p.opis, p.cena FROM pudelka p WHERE p.idpudelka != ALL (SELECT z.idpudelka FROM zawartosc z NATURAL JOIN czekoladki c WHERE c.czekolada ilike 'Gorzka');

-- 8. Nie zawierają czekoladek z orzechami.

SELECT DISTINCT p.nazwa, p.opis, p.cena FROM pudelka p WHERE p.idpudelka = SOME  (SELECT z.idpudelka FROM zawartosc z NATURAL JOIN czekoladki c WHERE c.orzechy IS NULL);

-- 9. Zawierają przynajmniej jedną czekoladkę bez nadzienia.

SELECT DISTINCT p.nazwa, p.opis, p.cena FROM pudelka p WHERE p.idpudelka IN (SELECT z.idpudelka FROM zawartosc z NATURAL JOIN czekoladki c WHERE c.nadzienie IS NULL);

--------------------------------------
-- Zadanie 10.5, baza danych: cukiernia

-- Napisz poniższe zapytania w języku SQL (używając odpowiedniego operatora, np. in/not in/exists/any/all):

-- 1. Wyświetl wartości kluczy głównych oraz nazwy czekoladek, których koszt jest większy od czekoladki o wartości klucza głównego równej D08.

SELECT c1.idczekoladki, c1.nazwa FROM czekoladki c1 WHERE EXISTS (SELECT idczekoladki FROM czekoladki c2 WHERE c2.idczekoladki ilike 'D08' AND c1.koszt > c2.koszt );

-- 2. Kto (nazwa klienta) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiała Gorka Alicja.

SELECT DISTINCT k.nazwa FROM klienci k NATURAL JOIN zamowienia z NATURAL JOIN artykuly a WHERE a.idpudelka = ANY(SELECT a.idpudelka FROM artykuly a NATURAL JOIN zamowienia z WHERE z.idklienta IN (SELECT k.idklienta FROM klienci k WHERE nazwa ilike 'Górka Alicja'));

-- 3. Kto (nazwa klienta, adres) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiali klienci z Katowic.

SELECT DISTINCT k.nazwa, k.ulica || ' ' || miejscowosc AS adres FROM klienci k NATURAL JOIN zamowienia z NATURAL JOIN artykuly a  WHERE a.idpudelka = ANY (SELECT a.idpudelka FROM artykuly a NATURAL JOIN zamowienia z WHERE z.idklienta IN (SELECT k.idklienta FROM klienci k WHERE miejscowosc = 'Katowice'));

--------------------------------------
-- Zadanie 10.6, baza danych: cukiernia

-- Wyświetl nazwę pudełka oraz ilość czekoladek, dla:

-- 1. Pudełka o największej liczbie czekoladek (bez użycia klauzuli limit).

SELECT nazwa, SUM(sztuk) FROM pudelka NATURAL JOIN zawartosc GROUP BY idpudelka HAVING SUM(sztuk) = ( SELECT MAX(ilosci.suma) FROM ( SELECT SUM(sztuk) AS suma FROM pudelka NATURAL JOIN zawartosc GROUP BY idpudelka ) AS ilosci );

SELECT nazwa, SUM(sztuk) FROM pudelka NATURAL JOIN zawartosc GROUP BY idpudelka HAVING SUM(sztuk) >= ALL ( SELECT SUM(sztuk) AS ilosc FROM pudelka NATURAL JOIN zawartosc GROUP BY idpudelka );

-- 2. Pudełka o najmniejszej liczbie czekoladek (bez użycia klauzuli limit).

SELECT nazwa, SUM(sztuk) FROM pudelka NATURAL JOIN zawartosc GROUP BY idpudelka HAVING SUM(sztuk) = (SELECT MIN(ilosci.suma) FROM (SELECT SUM(sztuk) AS suma FROM pudelka NATURAL JOIN zawartosc GROUP BY idpudelka) AS ilosci);

SELECT nazwa, SUM(sztuk) FROM pudelka NATURAL JOIN zawartosc GROUP BY idpudelka HAVING SUM(sztuk) <= ALL ( SELECT SUM(sztuk) AS ilosc FROM pudelka NATURAL JOIN zawartosc GROUP BY idpudelka );

-- 3. Pudełka, w którym liczba czekoladek jest powyżej średniej.

SELECT nazwa, idpudelka, SUM(sztuk) AS liczebnosc FROM pudelka NATURAL JOIN zawartosc  w GROUP by idpudelka having SUM(sztuk) > (SELECT AVG(sumy) AS srednia FROM (SELECT SUM(sztuk) AS sumy FROM zawartosc GROUP BY idpudelka) AS inner_query);

-- 4. Pudełka o największej lub najmniejszej liczbie czekoladek.

SELECT nazwa, SUM(sztuk) FROM pudelka NATURAL JOIN zawartosc GROUP BY idpudelka
HAVING
SUM(sztuk) = (SELECT MIN(ilosci.suma) FROM (SELECT SUM(sztuk) AS suma FROM pudelka NATURAL JOIN zawartosc GROUP BY idpudelka) AS ilosci)
OR
SUM(sztuk) = (SELECT MAX(ilosci.suma) FROM (SELECT SUM(sztuk) AS suma FROM pudelka NATURAL JOIN zawartosc GROUP BY idpudelka) AS ilosci);

--------------------------------------
-- Zadanie 10.7, baza danych: cukiernia

-- Napisz zapytanie wyświetlające: liczbę porządkową i identyfikator pudełka czekoladek (idpudelka). Identyfikatory pudełek mają być posortowane alfabetycznie, rosnąco. Liczba porządkowa jest z przedziału 1..N, gdzie N jest ilością pudełek.
-- Użyj podzapytania w klauzuli SELECT: SELECT kolumna1, kolumna2, (SELECT ...) FROM ...

SELECT (SELECT COUNT(*) FROM pudelka p2 WHERE p2.idpudelka <= p1.idpudelka) AS "L. p.", p1.idpudelka FROM pudelka p1 ORDER BY p1.idpudelka;
