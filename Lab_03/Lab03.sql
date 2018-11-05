-- Zadanie 3.1, baza danych: cukiernia

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE datarealizacji BETWEEN '11-11-2013' AND '12-21-2013';

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE datarealizacji BETWEEN '12-01-2013' AND '12-06-2013' OR datarealizacji BETWEEN '12-15-2013' AND '12-20-2013';

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE CAST(datarealizacji AS TEXT) LIKE '12-%-2013';

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE date_part('month', datarealizacji) = 11 AND date_part('year', datarealizacji) = 2013;;

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE date_part('month', datarealizacji) IN (11, 12) AND date_part('year', datarealizacji) = 2013;

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE date_part('day', datarealizacji) IN (17, 18, 19);

SELECT idzamowienia, datarealizacji FROM zamowienia WHERE date_part('week', datarealizacji) IN (46, 47)

-- Zadanie 3.2, baza danych: cukiernia

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE 'S%';

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE 'S%i';

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE 'S% m%';

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE 'A%' OR nazwa LIKE 'B%' OR nazwa LIKE 'C%';

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE 'Orzech%' OR nazwa LIKE '%orzech%';

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE 'S%m%';

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE '%maliny%' OR nazwa LIKE '%truskawki%';
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa SIMILAR TO '%(truskawki|maliny)%';

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa NOT SIMILAR TO '([D-K]|S|T)%';

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa LIKE 'Słod%';

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa NOT LIKE '% %';

-- Zadanie 3.3, baza danych: cukiernia

SELECT miejscowosc FROM Klienci WHERE miejscowosc LIKE '% %';

SELECT telefon FROM Klienci WHERE telefon LIKE '% % % %';

SELECT telefon FROM Klienci WHERE telefon NOT LIKE '% % % %';

-- Zadanie 3.4, baza danych: cukiernia

-- Zadanie 3.5, baza danych: cukiernia

-- Zadanie 3.6, baza danych: siatkówka

-- Zadanie 3.7, baza danych: siatkówka

-- Zadanie 3.8, baza danych: siatkówka
