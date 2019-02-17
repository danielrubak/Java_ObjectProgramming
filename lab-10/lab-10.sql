-- Zadanie 10.2, baza danych: cukiernia

--Napisz zapytanie wyświetlające informacje na temat zamówień (dataRealizacji, idzamowienia) używając odpowiedniego operatora in/not in/exists/any/all, które:

-- 1. Zostały złożone przez klienta, który ma na imię Antoni.

-- 2. Zostały złożone przez klientów z mieszkań (zwróć uwagę na pole ulica).

-- 3. Zostały złożone przez klienta z Krakowa do realizacji w listopadzie 2013 roku.

--------------------------------------
-- Zadanie 10.3, baza danych: cukiernia

-- Napisz zapytanie wyświetlające informacje na temat klientów (nazwa, ulica, miejscowość), używając odpowiedniego operatora in/not in/exists/any/all, którzy:

-- 1. Złożyli zamówienia z datą realizacji 12.11.2013.

-- 2. Złożyli zamówienia z datą realizacji w listopadzie 2013.

-- 3. Zamówili pudełko Kremowa fantazja lub Kolekcja jesienna.

-- 4. Zamówili co najmniej 2 sztuki pudełek Kremowa fantazja lub Kolekcja jesienna w ramach jednego zamówienia.

-- 5. Zamówili pudełka, które zawierają czekoladki z migdałami.

-- 6. Złożyli przynajmniej jedno zamówienie.

-- 7. Nie złożyli żadnych zamówień.

--------------------------------------
-- Zadanie 10.4, baza danych: cukiernia

-- Napisz zapytanie wyświetlające informacje na temat pudełek z czekoladkami (nazwa, opis, cena), używając odpowiedniego operatora, np. in/not in/exists/any/all, które:

-- 1. Zawierają czekoladki o wartości klucza głównego D0.

-- 2. Zawierają czekoladki Gorzka truskawkowa.

-- 3. Zawierają przynajmniej jedną czekoladkę, której nazwa zaczyna się na S.

-- 4. Zawierają przynajmniej 4 sztuki czekoladek jednego gatunku (o takim samym kluczu głównym).

-- 5. Zawierają co najmniej 3 sztuki czekoladki Gorzka truskawkowa.

-- 6. Zawierają czekoladki z nadzieniem truskawkowym.

-- 7. Nie zawierają czekoladek w gorzkiej czekoladzie.

-- 8. Nie zawierają czekoladek z orzechami.

-- 9. Zawierają przynajmniej jedną czekoladkę bez nadzienia.

--------------------------------------
-- Zadanie 10.5, baza danych: cukiernia

--Napisz poniższe zapytania w języku SQL (używając odpowiedniego operatora, np. in/not in/exists/any/all):

-- 1. Wyświetl wartości kluczy głównych oraz nazwy czekoladek, których koszt jest większy od czekoladki o wartości klucza głównego równej D08.

-- 2. Kto (nazwa klienta) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiała Gorka Alicja.

-- 3. Kto (nazwa klienta, adres) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiali klienci z Katowic.

--------------------------------------
-- Zadanie 10.6, baza danych: cukiernia

--Wyświetl nazwę pudełka oraz ilość czekoladek, dla:

-- 1. Pudełka o największej liczbie czekoladek (bez użycia klauzuli limit).
-- 2. Pudełka o najmniejszej liczbie czekoladek (bez użycia klauzuli limit).
-- 3. Pudełka, w którym liczba czekoladek jest powyżej średniej.
-- 4. Pudełka o największej lub najmniejszej liczbie czekoladek.

--------------------------------------
-- Zadanie 10.7, baza danych: cukiernia

-- Napisz zapytanie wyświetlające: liczbę porządkową i identyfikator pudełka czekoladek (idpudelka). Identyfikatory pudełek mają być posortowane alfabetycznie, rosnąco. Liczba porządkowa jest z przedziału 1..N, gdzie N jest ilością pudełek.
-- Użyj podzapytania w klauzuli SELECT: SELECT kolumna1, kolumna2, (SELECT ...) FROM ...
