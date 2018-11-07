-- Zadanie 5.1, baza danych: cukiernia

-- 1. Łącznej liczby czekoladek w bazie danych.

SELECT COUNT(*) FROM czekoladki;

-- 2. Łącznej liczby czekoladek z nadzieniem (na 2 sposoby) - podpowiedź: count(*), count(nazwaKolumny).

SELECT COUNT(*) FROM czekoladki WHERE nadzienie IS NOT NULL;
SELECT COUNT(idczekoladki) FROM czekoladki WHERE nadzienie IS NOT NULL;

-- 3. Pudełka, w którym jest najwięcej czekoladek (uwaga: konieczne jest użycie LIMIT).

SELECT idpudelka, SUM(sztuk) FROM zawartosc GROUP BY idpudelka ORDER BY sum DESC LIMIT 1;

-- 4. Łącznej liczby czekoladek w poszczególnych pudełkach.
-- 5. Łącznej liczby czekoladek bez orzechów w poszczególnych pudełkach.
-- 6. Łącznej liczby czekoladek w mlecznej czekoladzie w poszczególnych pudełkach.

--------------------------------------
-- Zadanie 5.2, baza danych: cukiernia

-- 1. Masy poszczególnych pudełek.

SELECT idpudelka, SUM(masapudelka) FROM (SELECT z.idpudelka, c.masa * z.sztuk AS masapudelka FROM zawartosc z JOIN czekoladki c ON c.idczekoladki = z.idczekoladki) AS q1 GROUP BY idpudelka;

-- 2. Pudełka o największej masie.

SELECT idpudelka, SUM(masapudelka) FROM (SELECT z.idpudelka, c.masa * z.sztuk AS masapudelka FROM zawartosc z JOIN czekoladki c ON c.idczekoladki = z.idczekoladki) AS q1 GROUP BY idpudelka ORDER BY 2 DESC LIMIT 1;
SELECT z.idpudelka, SUM(c.masa * z.sztuk) AS masapudelka FROM zawartosc z JOIN czekoladki c ON c.idczekoladki = z.idczekoladki GROUP BY z.idpudelka ORDER BY 2 DESC LIMIT 1;


-- 3. Średniej masy pudełka w ofercie cukierni.
-- 4. Średniej wagi pojedynczej czekoladki w poszczególnych pudełkach.

--------------------------------------
-- Zadanie 5.3, baza danych: cukiernia

-- 1. Liczby zamówień na poszczególne dni.

SELECT datarealizacji, COUNT(*) liczba_zamowien FROM zamowienia GROUP BY datarealizacji;

-- 2. Łącznej liczby wszystkich zamówień.

SELECT COUNT(*) FROM zamowienia;

-- 3. Łącznej wartości wszystkich zamówień.
-- 4. Klientów, liczby złożonych przez nich zamówień i łącznej wartości złożonych przez nich zamówień.

--------------------------------------
-- Zadanie 5.4, baza danych: cukiernia

-- 1. Czekoladki, która występuje w największej liczbie pudełek.

SELECT idczekoladki, COUNT(idpudelka) liczba_wystapien FROM zawartosc GROUP BY idczekoladki ORDER BY 2 DESC LIMIT 1;

-- 2. Pudełka, które zawiera najwięcej czekoladek bez orzechów.

SELECT z.idpudelka, COUNT(z.idczekoladki) FROM zawartosc z JOIN czekoladki c ON c.idczekoladki = z.idczekoladki WHERE c.orzechy IS NULL GROUP BY z.idpudelka ORDER BY 2 DESC LIMIT 1;

-- 3. Czekoladki, która występuje w najmniejszej liczbie pudełek.
-- 4. Pudełka, które jest najczęściej zamawiane przez klientów.

--------------------------------------
-- Zadanie 5.5, baza danych: cukiernia

-- 1. Liczby zamówień na poszczególne kwartały.

SELECT extract(quarter from datarealizacji) AS kwartal, COUNT(idzamowienia) liczba_zamowien FROM zamowienia GROUP BY extract(quarter from datarealizacji);

-- 2. Liczby zamówień na poszczególne miesiące.

SELECT extract(month from datarealizacji) AS miesiac, COUNT(idzamowienia) liczba_zamowien FROM zamowienia GROUP BY extract(month from datarealizacji);

-- 3. Liczby zamówień do realizacji w poszczególnych tygodniach.
-- 4. Liczby zamówień do realizacji w poszczególnych miejscowościach.

--------------------------------------
-- Zadanie 5.6, baza danych: cukiernia

-- 1. łącznej masy wszystkich pudełek czekoladek znajdujących się w cukierni.

SELECT z.idpudelka, SUM(c.masa * z.sztuk * p.stan) AS masa_pudelek FROM zawartosc z JOIN czekoladki c ON c.idczekoladki = z.idczekoladki JOIN pudelka p ON p.idpudelka = z.idpudelka GROUP BY z.idpudelka ORDER BY 2;

-- 2. Łącznej wartości wszystkich pudełek czekoladek znajdujących się w cukierni.

--------------------------------------
-- Zadanie 5.7, baza danych: cukiernia

-- 1. Zysk ze sprzedaży jednej sztuki poszczególnych pudełek (różnica między ceną pudełka i kosztem jego wytworzenia).
-- 2. Zysk ze sprzedaży zamówionych pudełek.
-- 3. Zysk ze sprzedaży wszystkich pudełek czekoladek w cukierni.

--------------------------------------
-- Zadanie 5.8, baza danych: cukiernia

-- 1. Napisz zapytanie wyświetlające: liczbę porządkową i identyfikator pudełka czekoladek (idpudelka). Identyfikatory pudełek mają być posortowane alfabetycznie, rosnąco. Liczba porządkowa jest z przedziału 1..N, gdzie N jest ilością pudełek.
