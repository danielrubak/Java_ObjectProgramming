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
-- 7. Zamówili pudełka, które zawierają czekoladki z migdałami.

SELECT k.nazwa, k.ulica, k.miejscowosc, z.datarealizacji, p.nazwa AS nazwa_pudelka, a.sztuk FROM klienci k JOIN zamowienia z ON k.idklienta = z.idklienta JOIN artykuly a ON a.idzamowienia = z.idzamowienia INNER JOIN pudelka p ON a.idpudelka = p.idpudelka WHERE p.nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna') AND a.sztuk >= 2;

--------------------------------------
-- Zadanie 4.4, baza danych: cukiernia

-- 1. Wszystkich pudełek.
-- 2. Pudełka o wartości klucza głównego heav.
-- 3. Pudełek, których nazwa zawiera słowo Kolekcja.

--------------------------------------
-- Zadanie 4.5, baza danych: cukiernia

-- 1. Zawierają czekoladki o wartości klucza głównego d09.
-- 2. Zawierają przynajmniej jedną czekoladkę, której nazwa zaczyna się na S.
-- 3. Zawierają przynajmniej 4 sztuki czekoladek jednego gatunku (o takim samym kluczu głównym).
-- 4. Zawierają czekoladki z nadzieniem truskawkowym.
-- 5. Nie zawierają czekoladek w gorzkiej czekoladzie.
-- 6. Zawierają co najmniej 3 sztuki czekoladki Gorzka truskawkowa.
-- 7. Nie zawierają czekoladek z orzechami.
-- 8. Zawierają czekoladki Gorzka truskawkowa.
-- 9. Zawierają przynajmniej jedną czekoladkę bez nadzienia.

--------------------------------------
-- Zadanie 4.6, baza danych: cukiernia

-- 1. Wyświetl wartości kluczy głównych oraz nazwy czekoladek, których koszt jest większy od kosztu czekoladki o wartości klucza głównego równej d08.
-- 2. Kto (nazwa klienta) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiała Górka Alicja.
-- 3. Kto (nazwa klienta, adres) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiali klienci z Katowic.
