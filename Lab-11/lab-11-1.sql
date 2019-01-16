-- 1. Napisz funkcję masaPudelka wyznaczającą masę pudełka jako sumę masy czekoladek w nim zawartych.
-- Funkcja jako argument przyjmuje identyfikator pudełka. Przetestuj działanie funkcji na podstawie prostej instrukcji select.

CREATE OR REPLACE FUNCTION masaPudelka(idPud char(4))
   RETURNS INT AS
$$

DECLARE masa_pudelka INT;

BEGIN
   SELECT SUM(masa) INTO masa_pudelka
      FROM zawartosc
      NATURAL JOIN czekoladki
      WHERE idpudelka = idPud;
   return masa_pudelka;
END;

$$
language plpgsql;

-- 2. Napisz funkcję liczbaCzekoladek wyznaczającą liczbę czekoladek znajdujących się w pudełku.
-- Funkcja jako argument przyjmuje identyfikator pudełka. Przetestuj działanie funkcji na podstawie prostej instrukcji select.


CREATE OR REPLACE FUNCTION liczbaCzekoladek(idPud CHAR(4))
   RETURNS INT AS
$$

DECLARE ilosc_czekoladek INT;

BEGIN
   SELECT SUM(sztuk) INTO ilosc_czekoladek
      FROM zawartosc
      WHERE idpudelka = idPud;

  RETURN ilosc_czekoladek;
END;

$$
LANGUAGE plpgsql;
