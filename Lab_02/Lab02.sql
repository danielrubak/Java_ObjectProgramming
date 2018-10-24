-- Zadanie 2.1, baza danych: cukiernia

-- 1. Wyświetla listę klientów (nazwa, ulica, miejscowość) posortowaną według nazw klientów.
SELECT nazwa, ulica, miejscowosc FROM klienci;

-- 2. Wyświetla listę klientów posortowaną malejąco według nazw miejscowości, a w ramach tej samej miejscowości rosnąco według nazw klientów.
SELECT nazwa, ulica, miejscowosc FROM klienci ORDER BY miejscowosc DESC, nazwa ASC;

-- 3. Wyświetla listę klientów z Krakowa lub z Warszawy posortowaną malejąco według nazw miejscowości, a w ramach tej samej miejscowości rosnąco według nazw klientów (zapytanie utwórz na dwa sposoby stosując w kryteriach or lub in).


-- 4. Wyświetla listę klientów posortowaną malejąco według nazw miejscowości

-- 5. Wyświetla listę klientów z Krakowa posortowaną według nazw klientów.
