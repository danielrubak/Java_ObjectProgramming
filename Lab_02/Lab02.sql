-- Zadanie 2.1, baza danych: cukiernia

-- 1. Wyświetla listę klientów (nazwa, ulica, miejscowość) posortowaną według nazw klientów.
SELECT nazwa, ulica, miejscowosc FROM klienci;

-- 2. Wyświetla listę klientów posortowaną malejąco według nazw miejscowości, a w ramach tej samej miejscowości rosnąco według nazw klientów.
SELECT nazwa, ulica, miejscowosc FROM klienci ORDER BY miejscowosc DESC, nazwa ASC;

-- 3. Wyświetla listę klientów z Krakowa lub z Warszawy posortowaną malejąco według nazw miejscowości, a w ramach tej samej miejscowości rosnąco według nazw klientów (zapytanie utwórz na dwa sposoby stosując w kryteriach or lub in).
SELECT * FROM klienci WHERE miejscowosc = 'Kraków' OR miejscowosc = 'Warszawa' ORDER BY miejscowosc DESC, nazwa ASC;
SELECT * FROM klienci WHERE miejscowosc in ('Warszawa', 'Kraków') ORDER BY miejscowosc DESC, nazwa ASC;

-- 4. Wyświetla listę klientów posortowaną malejąco według nazw miejscowości
SELECT * FROM klienci ORDER BY miejscowosc DESC;

-- 5. Wyświetla listę klientów z Krakowa posortowaną według nazw klientów.
SELECT * FROM klienci WHERE miejscowosc = 'Kraków' ORDER BY nazwa;

--------------------------------------
-- Zadanie 2.2, baza danych: cukiernia

-- 1. Wyświetla nazwę i masę czekoladek, których masa jest większa niż 20 g.
SELECT nazwa, masa FROM czekoladki WHERE masa > 20;

-- 2. Wyświetla nazwę, masę i koszt produkcji czekoladek, których masa jest większa niż 20 g i koszt produkcji jest większy niż 25 gr.
SELECT nazwa, masa, koszt FROM czekoladki WHERE masa > 20 AND koszt > 0.25;

-- 3. J.w. ale koszt produkcji musi być podany w groszach.
SELECT nazwa, masa, koszt FROM czekoladki WHERE masa > 20 AND koszt*100 > 25;

-- 4. Wyświetla nazwę oraz rodzaj czekolady, nadzienia i orzechów dla czekoladek, które są w mlecznej czekoladzie i nadziane malinami lub są w mlecznej czekoladzie i nadziane truskawkami lub zawierają orzechy laskowe, ale nie są w gorzkiej czekoladzie.
SELECT nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE (czekolada = 'mleczna' AND nadzienie = 'maliny') OR (czekolada = 'mleczna' AND nadzienie = 'truskawki') OR (orzechy = 'laskowe' AND czekolada != 'gorzka');

-- 5. Wyświetla nazwę i koszt produkcji czekoladek, których koszt produkcji jest większy niż 25 gr.
SELECT nazwa, koszt FROM czekoladki WHERE koszt > 0.25;

-- 6. Wyświetla nazwę i rodzaj czekolady dla czekoladek, które są w białej lub mlecznej czekoladzie.
SELECT nazwa, czekolada FROM czekoladki WHERE czekolada in ('mleczna', 'biała');

--------------
-- Zadanie 2.3

-- 1. 124 * 7 +45
SELECT 124 * 7 + 45 AS result;

-- 2. 2 ^ 20
SELECT 2 ^ 20 AS result;

-- 3. sqrt(3)
SELECT sqrt(3) AS result;

-- 4. pi
SELECT PI() AS result;

--------------------------------------
-- Zadanie 2.4, baza danych: cukiernia

-- 1. Masa mieści się w przedziale od 15 do 24 g.
SELECT idczekoladki, nazwa, masa, koszt FROM czekoladki WHERE masa > 15 AND masa < 24;

-- 2. Koszt produkcji mieści się w przedziale od 25 do 35 gr.
SELECT idczekoladki, nazwa, masa, koszt FROM czekoladki WHERE koszt > 0.25 AND koszt < 0.35;

-- 3. Masa mieści się w przedziale od 25 do 35 g lub koszt produkcji mieści się w przedziale od 15 do 24 gr.
SELECT idczekoladki, nazwa, masa, koszt FROM czekoladki WHERE (masa > 25 AND masa < 35) OR (koszt > 0.15 AND koszt < 0.24);

--------------------------------------
-- Zadanie 2.5, baza danych: cukiernia

-- 1. Zawierają jakieś orzechy.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE orzechy IS NOT NULL;

-- 2. Nie zawierają orzechów.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE orzechy IS NULL;

-- 3. Zawierają jakieś orzechy lub jakieś nadzienie.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE orzechy IS NOT NULL AND nadzienie IS NOT NULL;

-- 4. Są w mlecznej lub białej czekoladzie (użyj IN) i nie zawierają orzechów.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE czekolada in ('biała', 'mleczna') AND orzechy IS NULL;

-- 5. Nie są ani w mlecznej ani w białej czekoladzie i zawierają jakieś orzechy lub jakieś nadzienie.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE czekolada != 'mleczna' AND czekolada != 'biała' AND (orzechy IS NOT NULL OR nadzienie IS NOT NULL);

-- 6. Zawierają jakieś nadzienie.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nadzienie IS NOT NULL;

-- 7. Nie zawierają nadzienia.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nadzienie IS NULL;

-- 8. Nie zawierają orzechów ani nadzienia.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nadzienie IS NULL AND orzechy IS NULL;

-- 9. Są w mlecznej lub białej czekoladzie i nie zawierają nadzienia.

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE czekolada in ('mleczna', 'biała') AND nadzienie IS NULL;

--------------------------------------
-- Zadanie 2.6, baza danych: cukiernia

-- 1. Masa mieści się w przedziale od 15 do 24 g lub koszt produkcji mieści się w przedziale od 15 do 24 gr.

SELECT * FROM czekoladki WHERE (masa > 15 AND masa < 24) OR (koszt > 0.15 AND koszt < 0.24);

-- 2. Masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr lub masa mieści się w przedziale od 25 do 35 g i koszt produkcji mieści się w przedziale od 25 do 35 gr.

SELECT * FROM czekoladki WHERE ((masa > 15 AND masa < 24) AND (koszt > 0.15 AND koszt < 0.24)) OR ((masa > 25 AND masa < 35) AND (koszt > 0.25 AND koszt < 0.35));

-- 3. Masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr.

SELECT * FROM czekoladki WHERE ((masa > 15 AND masa < 24) AND (koszt > 0.15 AND koszt < 0.24))

-- 4. Masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się w przedziale od 25 do 35 gr.

SELECT * FROM czekoladki WHERE ((masa > 25 AND masa < 35) AND (koszt < 0.25 OR koszt > 0.35));

-- 5. Masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się ani w przedziale od 15 do 24 gr, ani w przedziale od 25 do 35 gr.

SELECT * FROM czekoladki WHERE ((masa > 25 AND masa < 35) AND (koszt < 0.15 OR  koszt > 0.35))

--------------------------------------
-- Zadanie 2.7, baza danych: cukiernia

\a - popsuło formatowanie
\f - zmienia seperator wyświetlanych danych
\H - dane wyświetlane są w formacie HTML
\o nazwa_pliku - przekierowuje wynik do pliku nazwa_pliku

--------------------------------------
-- Zadanie 2.8, baza danych: cukiernia

Z poziomu psql: \i zapytanie1.sql
