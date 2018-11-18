-- Zadanie 4.1, baza danych: cukiernia

-- 1. W którym zapytaniu występuje iloczyn kartezjański?
-- 2. Które zapytanie dostarcza bezwartościowych danych?

--------------------------------------
-- Zadanie 4.2, baza danych: cukiernia

-- 1. Zostały złożone przez klienta, który ma na imię Antoni.

SELECT k.nazwa, z.idzamowienia, z.datarealizacji FROM klienci k JOIN zamowienia z ON k.idklienta= z.idklienta WHERE k.nazwa LIKE '%Antoni%'

-- 2. Zostały złożone przez klientów z mieszkań (zwróć uwagę na pole ulica).

SELECT k.nazwa, z.idzamowienia, z.datarealizacji FROM klienci k JOIN zamowienia z ON k.idklienta= z.idklienta WHERE k.ulica LIKE '%/%';

-- 3. Zostały złożone przez klienta z Krakowa do realizacji w listopadzie 2013 roku.

SELECT k.nazwa, z.idzamowienia, z.datarealizacji FROM klienci k JOIN zamowienia z ON k.idklienta= z.idklienta WHERE k.miejscowosc = 'Kraków' AND CAST(z.datarealizacji AS TEXT) LIKE '2013-11-%';

--------------------------------------
-- Zadanie 4.3, baza danych: cukiernia

-- 1. Złożyli zamówienia z datą realizacji nie starszą niż sprzed pięciu lat.

SELECT k.nazwa, k.ulica, k.miejscowosc, z.datarealizacji FROM klienci k JOIN zamowienia z ON k.idklienta = z.idklienta WHERE z.datarealizacji > NOW() - INTERVAL '5 years';

-- 2. Zamówili pudełko Kremowa fantazja lub Kolekcja jesienna.

SELECT k.nazwa, k.ulica, k.miejscowosc, z.datarealizacji, p.nazwa FROM klienci k JOIN zamowienia z ON k.idklienta = z.idklienta JOIN artykuly a ON a.idzamowienia = z.idzamowienia INNER JOIN pudelka p ON a.idpudelka = p.idpudelka WHERE p.nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna');

-- 3. Złożyli przynajmniej jedno zamówienie.

SELECT k.nazwa, k.ulica, k.miejscowosc, COUNT(idzamowienia) AS liczba_zamowien FROM klienci k JOIN zamowienia z ON z.idklienta = k.idklienta GROUP BY k.idklienta;

-- 4. Nie złożyli żadnych zamówień.

SELECT idklienta FROM klienci EXCEPT (SELECT DISTINCT k.idklienta FROM klienci k JOIN zamowienia z ON z.idklienta = k.idklienta);

-- 5. Złożyli zamówienia z datą realizacji w listopadzie 2013.

SELECT k.nazwa, z.idzamowienia, z.datarealizacji FROM klienci k JOIN zamowienia z ON k.idklienta= z.idklienta WHERE CAST(z.datarealizacji AS TEXT) LIKE '2013-11-%';

-- 6. Zamówili co najmniej 2 sztuki pudełek Kremowa fantazja lub Kolekcja jesienna w ramach jednego zamówienia.

SELECT DISTINCT(k.idklienta), z.idzamowienia, k.nazwa, k.ulica, k.miejscowosc, a.idpudelka, a.sztuk FROM klienci k, artykuly a, zamowienia z WHERE k.idklienta = z.idklienta AND a.idzamowienia = z.idzamowienia AND (a.sztuk > 1 AND (a.idpudelka LIKE 'autu' OR a.idpudelka LIKE 'fudg')) ORDER BY k.idklienta, z.idzamowienia;

-- 7. Zamówili pudełka, które zawierają czekoladki z migdałami.

SELECT k.nazwa, k.ulica, k.miejscowosc, z.datarealizacji, p.nazwa AS nazwa_pudelka, a.sztuk FROM klienci k JOIN zamowienia z ON k.idklienta = z.idklienta JOIN artykuly a ON a.idzamowienia = z.idzamowienia INNER JOIN pudelka p ON a.idpudelka = p.idpudelka WHERE p.nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna') AND a.sztuk >= 2;

--------------------------------------
-- Zadanie 4.4, baza danych: cukiernia

-- Napisz zapytanie w języku SQL wyświetlające informacje na temat pudełek i ich zawartości (nazwa, opis, nazwa czekoladki, opis czekoladki)

-- 1. Wszystkich pudełek.

SELECT p.nazwa AS "Nazwa pudełka", p.opis AS "Opis pudełka", c.nazwa AS "Nazwa czekoladki", c.opis AS "Opis czekoladku" FROM pudelka p, czekoladki c, zawartosc z WHERE c.idczekoladki = z.idczekoladki AND z.idpudelka = p.idpudelka GROUP BY p.idpudelka, c.nazwa, c.opis ORDER BY p.nazwa;

-- 2. Pudełka o wartości klucza głównego heav.

SELECT p.nazwa AS "Nazwa pudełka", p.opis AS "Opis pudełka", c.nazwa AS "Nazwa czekoladki", c.opis AS "Opis czekoladku" FROM pudelka p, czekoladki c, zawartosc z WHERE c.idczekoladki = z.idczekoladki AND z.idpudelka = p.idpudelka AND p.idpudelka = 'heav' GROUP BY p.idpudelka, c.nazwa, c.opis ORDER BY p.nazwa;

SELECT p.nazwa AS "Nazwa pudełka", p.opis AS "Opis pudełka", c.nazwa AS "Nazwa czekoladki", c.opis AS "Opis czekoladku" FROM pudelka p
JOIN zawartosc z ON p.idpudelka = z.idpudelka
JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE p.idpudelka = 'heav' GROUP BY p.idpudelka, c.nazwa, c.opis ORDER BY p.nazwa;

-- 3. Pudełek, których nazwa zawiera słowo Kolekcja.

SELECT p.nazwa AS "Nazwa pudełka", p.opis AS "Opis pudełka", c.nazwa AS "Nazwa czekoladki", c.opis AS "Opis czekoladku" FROM pudelka p
JOIN zawartosc z ON p.idpudelka = z.idpudelka
JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE p.nazwa LIKE '%Kolekcja%' GROUP BY p.idpudelka, c.nazwa, c.opis ORDER BY p.nazwa;

--------------------------------------
-- Zadanie 4.5, baza danych: cukiernia

-- Napisz zapytanie w języku SQL wyświetlające informacje na temat pudełek z czekoladkami (nazwa, opis, cena), które (uwaga: może być konieczne użycie konstrukcji z poprzednich laboratoriów).

-- 1. Zawierają czekoladki o wartości klucza głównego d09.

SELECT p.nazwa AS "Nazwa pudelka", p.opis AS "Opis pudelka", p.cena AS "Pudelka cena", c.nazwa AS "Czekoladki nazwa", c.opis AS "Czekoladki opis", c.idczekoladki FROM pudelka p
JOIN zawartosc z ON z.idpudelka = p.idpudelka
JOIN czekoladki c ON c.idczekoladki = z.idczekoladki WHERE c.idczekoladki = 'd09';

-- 2. Zawierają przynajmniej jedną czekoladkę, której nazwa zaczyna się na S.

SELECT p.nazwa AS "Nazwa pudelka", p.opis AS "Opis pudelka", p.cena AS "Pudelka cena", c.nazwa AS "Czekoladki nazwa", c.opis AS "Czekoladki opis", c.idczekoladki FROM pudelka p
JOIN zawartosc z ON z.idpudelka = p.idpudelka
JOIN czekoladki c ON c.idczekoladki = z.idczekoladki WHERE c.nazwa LIKE 'S%';

-- 3. Zawierają przynajmniej 4 sztuki czekoladek jednego gatunku (o takim samym kluczu głównym).

SELECT p.nazwa AS "Nazwa pudelka", p.opis AS "Opis pudelka", p.cena AS "Pudelka cena", c.nazwa AS "Czekoladki nazwa", c.opis AS "Czekoladki opis", z.sztuk FROM pudelka p
JOIN zawartosc z ON z.idpudelka = p.idpudelka
JOIN czekoladki c ON c.idczekoladki = z.idczekoladki WHERE z.sztuk >=4;

-- 4. Zawierają czekoladki z nadzieniem truskawkowym.

SELECT p.nazwa AS "Nazwa pudelka", p.opis AS "Opis pudelka", p.cena AS "Pudelka cena", c.nazwa AS "Czekoladki nazwa", c.opis AS "Czekoladki opis", c.nadzienie FROM pudelka p
JOIN zawartosc z ON z.idpudelka = p.idpudelka
JOIN czekoladki c ON c.idczekoladki = z.idczekoladki WHERE c.nadzienie = 'truskawki';

-- 5. Nie zawierają czekoladek w gorzkiej czekoladzie.

SELECT p.nazwa AS "Nazwa pudelka", p.opis AS "Opis pudelka", p.cena FROM pudelka p
JOIN zawartosc z ON z.idpudelka = p.idpudelka
JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
EXCEPT
SELECT DISTINCT(p.nazwa) AS "Nazwa pudelka", p.opis AS "Opis pudelka", p.cena FROM pudelka p
JOIN zawartosc z ON z.idpudelka = p.idpudelka
JOIN czekoladki c ON c.idczekoladki = z.idczekoladki WHERE c.czekolada = 'gorzka';

-- 6. Zawierają co najmniej 3 sztuki czekoladki Gorzka truskawkowa.

SELECT p.nazwa AS "Nazwa pudelka", p.opis AS "Opis pudelka", p.cena FROM pudelka p
JOIN zawartosc z ON z.idpudelka = p.idpudelka
JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE z.sztuk >= 3 AND c.nazwa = 'Gorzka truskawkowa';

-- 7. Nie zawierają czekoladek z orzechami.

SELECT p.nazwa AS "Nazwa pudelka", p.opis AS "Opis pudelka", p.cena FROM pudelka p
JOIN zawartosc z ON z.idpudelka = p.idpudelka
JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
EXCEPT
SELECT DISTINCT(p.nazwa) AS "Nazwa pudelka", p.opis AS "Opis pudelka", p.cena FROM pudelka p
JOIN zawartosc z ON z.idpudelka = p.idpudelka
JOIN czekoladki c ON c.idczekoladki = z.idczekoladki WHERE c.orzechy IS NOT NULL;

-- 8. Zawierają czekoladki Gorzka truskawkowa.

SELECT DISTINCT(p.nazwa) AS "Nazwa pudelka", p.opis AS "Opis pudelka", p.cena AS "Pudelka cena", c.nazwa AS "Czekoladki nazwa", c.opis AS "Czekoladki opis", c.idczekoladki, c.orzechy FROM pudelka p JOIN zawartosc w USING(idpudelka) JOIN czekoladki c USING(idczekoladki) WHERE p.nazwa in (SELECT p.nazwa FROM pudelka p JOIN zawartosc z USING(idpudelka) JOIN czekoladki c USING(idczekoladki) WHERE c.nazwa = 'Gorzka truskawkowa') ORDER BY p.nazwa;

-- 9. Zawierają przynajmniej jedną czekoladkę bez nadzienia.

SELECT DISTINCT(p.nazwa) AS "Nazwa pudelka", p.opis AS "Opis pudelka", p.cena AS "Pudelka cena", c.nazwa AS "Czekoladki nazwa", c.opis AS "Czekoladki opis", c.idczekoladki, c.orzechy FROM pudelka p JOIN zawartosc w USING(idpudelka) JOIN czekoladki c USING(idczekoladki) WHERE p.nazwa in (SELECT p.nazwa FROM pudelka p JOIN zawartosc z USING(idpudelka) JOIN czekoladki c USING(idczekoladki) WHERE c.nadzienie IS NULL) ORDER BY p.nazwa;

--------------------------------------
-- Zadanie 4.6, baza danych: cukiernia

-- Uwaga: w poniższych zapytaniach należy użyć samozłączeń (złączeń własnych).

-- 1. Wyświetl wartości kluczy głównych oraz nazwy czekoladek, których koszt jest większy od kosztu czekoladki o wartości klucza głównego równej d08.

SELECT c1.idczekoladki AS "Id czekoladek", c1.nazwa AS "Nazwa czekoladek" FROM  czekoladki c1, czekoladki c2 WHERE c1.koszt < c2.koszt AND c2.idczekoladki  = 'd08';

-- 2. Kto (nazwa klienta) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiała Górka Alicja.

SELECT DISTINCT ON(k1.nazwa, zaw1.idpudelka) k1.nazwa, zam1.idzamowienia, c1.idczekoladki, c1.nazwa, zaw1.idpudelka FROM czekoladki c1 JOIN zawartosc zaw1 USING(idczekoladki) JOIN pudelka p1 USING(idpudelka) JOIN artykuly a1 USING (idpudelka) JOIN zamowienia zam1 USING(idzamowienia) JOIN klienci k1 USING(idklienta), czekoladki c2 JOIN zawartosc zaw2 USING(idczekoladki) JOIN pudelka p2 USING(idpudelka) JOIN artykuly a2 USING (idpudelka) JOIN zamowienia zam2 USING(idzamowienia) JOIN klienci k2 USING(idklienta) WHERE k2.nazwa = 'Górka Alicja' AND p1.idpudelka = p2.idpudelka; 

-- 3. Kto (nazwa klienta, adres) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiali klienci z Katowic.

SELECT DISTINCT ON(k1.nazwa) k1.nazwa, k1.miejscowosc FROM (klienci k1 NATURAL JOIN zamowienia z1 NATURAL JOIN artykuly a1), (klienci k2 NATURAL JOIN zamowienia z2 NATURAL JOIN artykuly a2) WHERE a1.idpudelka = a2.idpudelka AND k2.miejscowosc = 'Katowice';
