-- Zadanie 3.1, baza danych: cukiernia

-- 1. Między 12 i 20 listopada 2013.

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE datarealizacji BETWEEN '11-11-2013' AND '12-21-2013';

-- 2. Między 1 i 6 grudnia lub między 15 i 20 grudnia 2013.

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE datarealizacji BETWEEN '12-01-2013' AND '12-06-2013' OR datarealizacji BETWEEN '12-15-2013' AND '12-20-2013';

-- 3. W grudniu 2013 (nie używaj funkcji date_part ani extract).

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE CAST(datarealizacji AS TEXT) LIKE '12-%-2013';

-- 4. W listopadzie 2013 (w tym i kolejnych zapytaniach użyj funkcji date_part lub extract).

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE date_part('month', datarealizacji) = 11 AND date_part('year', datarealizacji) = 2013;

-- 5. W listopadzie lub grudniu 2013.

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE date_part('month', datarealizacji) IN (11, 12) AND date_part('year', datarealizacji) = 2013;

-- 6. 17, 18 lub 19 dnia miesiąca.

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE date_part('day', datarealizacji) IN (17, 18, 19);

-- 7. 46 lub 47 tygodniu roku.

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE date_part('week', datarealizacji) IN (46, 47)

--------------------------------------
-- Zadanie 3.2, baza danych: cukiernia

-- 1. Rozpoczyna się na literę 'S'.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE 'S%';

-- 2. Rozpoczyna się na literę 'S' i kończy się na literę 'i'.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE 'S%i';

-- 3. Rozpoczyna się na literę 'S' i zawiera słowo rozpoczynające się na literę 'm'.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE 'S% m%';

-- 4. Rozpoczyna się na literę 'A', 'B' lub 'C'.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE 'A%' OR nazwa LIKE 'B%' OR nazwa LIKE 'C%';

-- 5. Zawiera rdzeń 'orzech' (może on wystąpić na początku i wówczas będzie pisany z wielkiej litery).

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE 'Orzech%' OR nazwa LIKE '%orzech%';

-- 6. Rozpoczyna się na literę 'S' i zawiera w środku literę 'm'.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE 'S%m%';

-- 7. Zawiera słowo 'maliny' lub 'truskawki'.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE '%maliny%' OR nazwa LIKE '%truskawki%';
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa SIMILAR TO '%(truskawki|maliny)%';

-- 8. Nie rozpoczyna się żadną z liter: 'D'-'K', 'S' i 'T'.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa NOT SIMILAR TO '([D-K]|S|T)%';

-- 9. Rozpoczyna się od 'Slod' ('Słod').

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE 'Słod%';

-- 10. Składa się dokładnie z jednego słowa.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa NOT LIKE '% %';

--------------------------------------
-- Zadanie 3.3, baza danych: cukiernia

-- 1. Wyświetla nazwy miast, z których pochodzą klienci cukierni i które składają się z więcej niż jednego słowa.

SELECT miejscowosc FROM Klienci WHERE miejscowosc LIKE '% %';

-- 2. Wyświetla nazwy klientów, którzy podali numer stacjonarny telefonu.

SELECT telefon FROM Klienci WHERE telefon LIKE '% % % %';

-- 3. Wyświetla nazwy klientów, którzy podali numer komórkowy telefonu.

SELECT telefon FROM Klienci WHERE telefon NOT LIKE '% % % %';

--------------------------------------
-- Zadanie 3.4, baza danych: cukiernia

-- 1. Masa mieści się w przedziale od 15 do 24 g lub koszt produkcji mieści się w przedziale od 15 do 24 gr.
-- 2. Masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się w przedziale od 25 do 35 gr.
-- 3. Masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr lub masa mieści się w przedziale od 25 do 35 g i koszt produkcji mieści się w przedziale od 25 do 35 gr.
-- 4. Masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr.
-- 5. Masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się ani w przedziale od 15 do 24 gr, ani w przedziale od 29 do 35 gr.

--------------------------------------
-- Zadanie 3.5, baza danych: cukiernia

-- 1. Identyfikatory klientów, którzy nigdy nie złożyli żadnego zamówienia.
-- 2. Identyfikatory pudełek, które nigdy nie zostały zamówione.
-- 3. Nazwy klientów, czekoladek i pudełek, które zawierają rz (lub Rz).
-- 4. Identyfikatory czekoladek, które nie występują w żadnym pudełku.

--------------------------------------
-- Zadanie 3.6, baza danych: siatkówka

-- 1. Identyfikator meczu, sumę punktów zdobytych przez gospodarzy i sumę punktów zdobytych przez gości.
-- 2. Identyfikator meczu, sumę punktów zdobytych przez gospodarzy i sumę punktów zdobytych przez gości, dla meczów, które skończyły się po 5 setach i zwycięzca ostatniego seta zdobył ponad 15 punktów.
-- 3. Identyfikator i wynik meczu w formacie x:y, np. 3:1 (wynik jest pojedynczą kolumną – napisem),
-- 4. Identyfikator meczu, sumę punktów zdobytych przez gospodarzy i sumę punktów zdobytych przez gości, dla meczów, w których gospodarze zdobyli ponad 100 punktów.
-- 5. Identyfikator meczu, liczbę punktów zdobytych przez gospodarzy w pierwszym secie, sumę punktów zdobytych w meczu przez gospodarzy, dla meczów, w których pierwiastek kwadratowy z liczby punktów zdobytych w pierwszym secie jest mniejszy niż logarytm o podstawie 2 z sumy punktów zdobytych w meczu. ;)

--------------------------------------
-- Zadanie 3.7, baza danych: siatkówka

--------------------------------------
-- Zadanie 3.8, baza danych: siatkówka
