-- 1. Napisz funkcję zwracającą informacje o zamówieniach złożonych przez klienta, którego identyfikator podawany jest jako argument wywołania funkcji. W/w informacje muszą zawierać: idzamowienia, idpudelka, datarealizacji. Przetestuj działanie funkcji. Uwaga: Funkcja zwraca więcej niż 1 wiersz!

DROP FUNCTION IF EXISTS zamKlient(INT);
CREATE FUNCTION zamKlient(klient INT)
    RETURNS TABLE (r_idzamowienia INT, r_idpudelka CHAR(4), r_datarealizacji DATE) AS
$$

BEGIN
	RETURN QUERY
	SELECT idzamowienia, idpudelka, datarealizacji FROM zamowienia
	   NATURAL JOIN artykuly
       WHERE idklienta = klient;
END;

$$
LANGUAGE plpgsql;

-- 2. Napisz funkcję zwracającą listę klientów z miejscowości, której nazwa podawana jest jako argument wywołania funkcji. Lista powinna zawierać: nazwę klienta i adres. Przetestuj działanie funkcji.

DROP FUNCTION IF EXISTS miejscKlien(VARCHAR);
CREATE FUNCTION miejscKlien(miejsc VARCHAR)
    RETURNS TABLE (r_nazwa VARCHAR, r_ulica VARCHAR) AS
$$

BEGIN
	RETURN QUERY
	SELECT nazwa, ulica FROM klienci WHERE miejscowosc = miejsc;
END;

$$
LANGUAGE plpgsql;
