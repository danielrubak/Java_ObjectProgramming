-- 1. Napisz funkcję sumaZamowien obliczającą łączną wartość zamówień złożonych przez klienta, które czekają na realizację (są w tabeli Zamowienia).
-- Funkcja jako argument przyjmuje identyfikator klienta. Przetestuj działanie funkcji.

DROP FUNCTION IF EXISTS sumaZamowien(INT);
CREATE FUNCTION sumaZamowien(klient INT)
   RETURNS NUMERIC(7,2) AS
$$

DECLARE suma_zamowien NUMERIC(7, 2);
BEGIN
   SELECT SUM(sztuk*cena)
      INTO suma_zamowien
   FROM zamowienia
      NATURAL JOIN artykuly
      NATURAL JOIN pudelka
   WHERE idklienta = klient;

   RETURN suma_zamowien;
END;

$$
LANGUAGE plpgsql;

-- 2. Napisz funkcję rabat obliczającą rabat jaki otrzymuje klient składający zamówienie.
-- Funkcja jako argument przyjmuje identyfikator klienta.
-- Rabat wyliczany jest na podstawie wcześniej złożonych zamówień w sposób następujący:
-- - 4 % jeśli wartość zamówień jest z przedziału 101-200 zł
-- - 7 % jeśli wartość zamówień jest z przedziału 201-400 zł
-- - 8 % jeśli wartość zamówień jest większa od 400 zł.

DROP FUNCTION IF EXISTS naliczRabat(INT);
CREATE FUNCTION naliczRabat(klient INT)
   RETURNS NUMERIC(7,2) AS
$$

DECLARE rabat NUMERIC(7, 2);
   suma_zamowien NUMERIC(7, 2);
BEGIN
   suma_zamowien = sumaZamowien(klient);
   IF suma_zamowien BETWEEN 101 AND 200
      THEN rabat = 0.04;
   ELSEIF suma_zamowien BETWEEN 201 AND 400
      THEN rabat =0.07;
   ELSE
      rabat = 0.08;
   END IF;

   RETURN rabat;
END;

$$
LANGUAGE plpgsql;
