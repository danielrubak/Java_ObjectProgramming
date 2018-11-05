-- Zadanie 2.1, baza danych: cukiernia

-- 1. Wyświetla listę klientów (nazwa, ulica, miejscowość) posortowaną według nazw klientów.
SELECT nazwa, ulica, miejscowosc FROM klienci;

-- 2. Wyświetla listę klientów posortowaną malejąco według nazw miejscowości, a w ramach tej samej miejscowości rosnąco według nazw klientów.
SELECT nazwa, ulica, miejscowosc FROM klienci ORDER BY miejscowosc DESC, nazwa ASC;

-- 3. Wyświetla listę klientów z Krakowa lub z Warszawy posortowaną malejąco według nazw miejscowości, a w ramach tej samej miejscowości rosnąco według nazw klientów (zapytanie utwórz na dwa sposoby stosując w kryteriach or lub in).


-- 4. Wyświetla listę klientów posortowaną malejąco według nazw miejscowości

-- 5. Wyświetla listę klientów z Krakowa posortowaną według nazw klientów.

-- Zadanie 2.2, baza danych: cukiernia

-- 1. Wyświetla nazwę i masę czekoladek, których masa jest większa niż 20 g.
-- 2. Wyświetla nazwę, masę i koszt produkcji czekoladek, których masa jest większa niż 20 g i koszt produkcji jest większy niż 25 gr.
-- 3. J.w. ale koszt produkcji musi być podany w groszach.
-- 4. Wyświetla nazwę oraz rodzaj czekolady, nadzienia i orzechów dla czekoladek, które są w mlecznej czekoladzie i nadziane malinami lub są w mlecznej czekoladzie i nadziane truskawkami lub zawierają orzechy laskowe, ale nie są w gorzkiej czekoladzie.
-- 5. Wyświetla nazwę i koszt produkcji czekoladek, których koszt produkcji jest większy niż 25 gr.
-- 6. Wyświetla nazwę i rodzaj czekolady dla czekoladek, które są w białej lub mlecznej czekoladzie.

-- Zadanie 2.3

-- 1. 124 * 7 +45
-- 2. 2 ^ 20
-- 3. sqrt(3)
-- 4. pi

-- Zadanie 2.4, baza danych: cukiernia
-- 1. Masa mieści się w przedziale od 15 do 24 g.
-- 2. Koszt produkcji mieści się w przedziale od 25 do 35 gr.
-- 3. Masa mieści się w przedziale od 25 do 35 g lub koszt produkcji mieści się w przedziale od 15 do 24 gr.


-- Zadanie 2.5, baza danych: cukiernia

-- Zadanie 2.6, baza danych: cukiernia

-- Zadanie 2.7, baza danych: cukiernia

-- Zadanie 2.8, baza danych: cukiernia
