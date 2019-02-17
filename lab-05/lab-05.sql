SUM-- Zadanie 5.1, baza danych: cukiernia

-- 1. Łącznej liczby czekoladek w bazie danych.

SELECT COUNT(*) FROM czekoladki;

-- 2. Łącznej liczby czekoladek z nadzieniem (na 2 sposoby) - podpowiedź: COUNT(*), COUNT(nazwaKolumny).

SELECT COUNT(*) FROM czekoladki WHERE nadzienie IS NOT NULL;
SELECT COUNT(idczekoladki) FROM czekoladki WHERE nadzienie IS NOT NULL;

-- 3. Pudełka, w którym jest najwięcej czekoladek (uwaga: konieczne jest użycie LIMIT).

SELECT idpudelka, SUM(sztuk) FROM zawartosc GROUP BY idpudelka ORDER BY SUM DESC LIMIT 1;

-- 4. Łącznej liczby czekoladek w poszczególnych pudełkach.

SELECT p.idpudelka, SUM(z.sztuk) AS liczba_czekoladek FROM czekoladki c NATURAL JOIN zawartosc z JOIN pudelka p USING(idpudelka) GROUP BY p.idpudelka;

-- 5. Łącznej liczby czekoladek bez orzechów w poszczególnych pudełkach.

SELECT p.idpudelka, SUM(z.sztuk) AS liczba_czekoladek FROM czekoladki c NATURAL JOIN zawartosc z JOIN pudelka p USING(idpudelka) WHERE c.orzechy IS NULL GROUP BY p.idpudelka;

-- 6. Łącznej liczby czekoladek w mlecznej czekoladzie w poszczególnych pudełkach.

SELECT idpudelka, p.nazwa, SUM(sztuk) FROM zawartosc z NATURAL JOIN pudelka p JOIN czekoladki c USING (idczekoladki) WHERE czekolada ilike 'mleczna' GROUP BY idpudelka, p.nazwa ORDER BY idpudelka;

--------------------------------------
-- Zadanie 5.2, baza danych: cukiernia

-- 1. MASy poszczególnych pudełek.

SELECT idpudelka, SUM(mASapudelka) FROM (SELECT z.idpudelka, c.mASa * z.sztuk AS mASapudelka FROM zawartosc z JOIN czekoladki c ON c.idczekoladki = z.idczekoladki) AS q1 GROUP BY idpudelka;

-- 2. Pudełka o największej mASie.

SELECT idpudelka, SUM(mASapudelka) FROM (SELECT z.idpudelka, c.mASa * z.sztuk AS mASapudelka FROM zawartosc z JOIN czekoladki c ON c.idczekoladki = z.idczekoladki) AS q1 GROUP BY idpudelka ORDER BY 2 DESC LIMIT 1;
SELECT z.idpudelka, SUM(c.mASa * z.sztuk) AS mASapudelka FROM zawartosc z JOIN czekoladki c ON c.idczekoladki = z.idczekoladki GROUP BY z.idpudelka ORDER BY 2 DESC LIMIT 1;

-- 3. Średniej mASy pudełka w ofercie cukierni.

SELECT AVG(q1.mASa) FROM (SELECT SUM(z.sztuk * c.mASa) AS mASa FROM czekoladki c NATURAL JOIN zawartosc z JOIN pudelka p USING(idpudelka)  GROUP BY p.idpudelka) AS q1;

-- 4. Średniej wagi pojedynczej czekoladki w poszczególnych pudełkach.

SELECT p.idpudelka, p.nazwa, SUM(mASa*sztuk)/SUM(sztuk)::numeric(5,2) FROM pudelka p NATURAL JOIN zawartosc JOIN czekoladki c USING (idczekoladki) GROUP BY p.idpudelka;

--------------------------------------
-- Zadanie 5.3, baza danych: cukiernia

-- 1. Liczby zamówień na poszczególne dni.

SELECT datarealizacji, COUNT(*) liczba_zamowien FROM zamowienia GROUP BY datarealizacji;

-- 2. Łącznej liczby wszystkich zamówień.

SELECT COUNT(*) FROM zamowienia;

-- 3. Łącznej wartości wszystkich zamówień.

SELECT COALESCE(SUM(q.wartosc), 0) AS laczna_wartosc FROM (
   SELECT (a.sztuk * p.cena) AS wartosc FROM zamowienia z
      NATURAL JOIN artykuly a
      NATURAL JOIN pudelka p)
   AS q;

-- 4. Klientów, liczby złożonych przez nich zamówień i łącznej wartości złożonych przez nich zamówień.

SELECT z.idklienta, COUNT(a.idzamowienia), SUM(p.cena*a.sztuk) FROM pudelka p
   NATURAL JOIN artykuly a
   JOIN zamowienia z USING(idzamowienia)
   GROUP BY z.idklienta ORDER BY z.idklienta;

--------------------------------------
-- Zadanie 5.4, baza danych: cukiernia

-- 1. Czekoladki, która występuje w największej liczbie pudełek.

SELECT idczekoladki, COUNT(idpudelka) liczba_wystapien FROM zawartosc
   GROUP BY idczekoladki
   HAVING COUNT(idpudelka) = (SELECT COUNT(idpudelka) liczba_wystapien FROM zawartosc GROUP BY idczekoladki ORDER BY 1 DESC LIMIT 1);

-- 2. Pudełka, które zawiera najwięcej czekoladek bez orzechów.

SELECT z.idpudelka, COUNT(z.idczekoladki) FROM zawartosc z
   JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
   WHERE c.orzechy IS NULL
   GROUP BY z.idpudelka ORDER BY 2 DESC LIMIT 1;

-- 3. Czekoladki, która występuje w najmniejszej liczbie pudełek.

SELECT idczekoladki, COUNT(idpudelka) liczba_wystapien FROM zawartosc
   GROUP BY idczekoladki
   HAVING COUNT(idpudelka) = (SELECT COUNT(idpudelka) liczba_wystapien FROM zawartosc GROUP BY idczekoladki ORDER BY 1 ASC LIMIT 1);

-- 4. Pudełka, które jest najczęściej zamawiane przez klientów.

SELECT nazwa, COUNT(idzamowienia) FROM pudelka
   NATURAL JOIN artykuly
   GROUP BY idpudelka
   HAVING COUNT(idzamowienia) = (SELECT COUNT(idzamowienia) FROM pudelka NATURAL JOIN artykuly GROUP BY idpudelka ORDER BY 1 DESC LIMIT 1);

--------------------------------------
-- Zadanie 5.5, baza danych: cukiernia

-- 1. Liczby zamówień na poszczególne kwartały.

SELECT EXTRACT(quarter FROM datarealizacji), EXTRACT(year FROM datarealizacji), COUNT(idzamowienia) FROM zamowienia GROUP BY EXTRACT(quarter FROM datarealizacji), EXTRACT(year FROM datarealizacji);

-- 2. Liczby zamówień na poszczególne miesiące.

SELECT EXTRACT(month FROM datarealizacji), EXTRACT(year FROM datarealizacji), COUNT(idzamowienia) FROM zamowienia GROUP BY EXTRACT(month FROM datarealizacji), EXTRACT(year FROM datarealizacji);

-- 3. Liczby zamówień do realizacji w poszczególnych tygodniach.

SELECT EXTRACT(week FROM datarealizacji), EXTRACT(year FROM datarealizacji), COUNT(idzamowienia) FROM zamowienia GROUP BY EXTRACT(week FROM datarealizacji), EXTRACT(year FROM datarealizacji);

-- 4. Liczby zamówień do realizacji w poszczególnych miejscowościach.

SELECT miejscowosc, COUNT(idzamowienia) liczba_zamowien FROM zamowienia NATURAL JOIN klienci
GROUP BY miejscowosc ORDER BY liczba_zamowien DESC;

--------------------------------------
-- Zadanie 5.6, baza danych: cukiernia

-- 1. łącznej mASy wszystkich pudełek czekoladek znajdujących się w cukierni.

SELECT z.idpudelka, SUM(c.mASa * z.sztuk * p.stan) AS mASa_pudelek FROM zawartosc z JOIN czekoladki c ON c.idczekoladki = z.idczekoladki JOIN pudelka p ON p.idpudelka = z.idpudelka GROUP BY z.idpudelka ORDER BY 2;

-- 2. Łącznej wartości wszystkich pudełek czekoladek znajdujących się w cukierni.

SELECT SUM(cena*stan) FROM pudelka;

--------------------------------------
-- Zadanie 5.7, baza danych: cukiernia

-- 1. Zysk ze sprzedaży jednej sztuki poszczególnych pudełek (różnica między ceną pudełka i kosztem jego wytworzenia).

SELECT p.nazwa, p.cena, p.cena-SUM(z.sztuk*c.koszt) FROM pudelka p
   NATURAL JOIN zawartosc z
   JOIN czekoladki c USING (idczekoladki)
   GROUP BY p.idpudelka
   ORDER BY p.cena;

-- 2. Zysk ze sprzedaży zamówionych pudełek.

SELECT SUM(a.sztuk*y.zysk) FROM artykuly a
   JOIN (SELECT p.idpudelka, p.cena-x.koszt AS zysk FROM pudelka p
      JOIN (SELECT SUM(z.sztuk*c.koszt) AS koszt, z.idpudelka FROM zawartosc z
         NATURAL JOIN czekoladki c
         GROUP BY z.idpudelka)
      AS x
      USING(idpudelka)
      ORDER BY 2)
   AS y
   USING(idpudelka);

-- 3. Zysk ze sprzedaży wszystkich pudełek czekoladek w cukierni.

SELECT SUM(pudla.zysk) FROM
   (SELECT stan*(cena - SUM(sztuk*koszt)) AS zysk FROM pudelka
      NATURAL JOIN zawartosc
      JOIN czekoladki USING (idczekoladki)
      GROUP BY idpudelka)
   AS pudla;

--------------------------------------
-- Zadanie 5.8, baza danych: cukiernia

-- 1. Napisz zapytanie wyświetlające: liczbę porządkową i identyfikator pudełka czekoladek (idpudelka). Identyfikatory pudełek mają być posortowane alfabetycznie, rosnąco. Liczba porządkowa jest z przedziału 1..N, gdzie N jest ilością pudełek.

SELECT COUNT(*), p1.idpudelka FROM pudelka p1
   JOIN pudelka p2 ON p1.idpudelka >= p2.idpudelka
   GROUP BY p1.idpudelka
   ORDER BY idpudelka;

SELECT row_number() over (ORDER BY idpudelka) AS nr, idpudelka
   FROM pudelka;
