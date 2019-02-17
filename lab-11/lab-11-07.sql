-- Napisz funkcję rabat obliczającą rabat jaki otrzymuje klient kwiaciarni składający zamówienie. Funkcję utwórz w schemacie kwiaciarnia. Rabat wyliczany jest na podstawie zamówień bieżących (tabela zamowienia) i z ostatnich siedmiu dni (tabela historia) w sposób następujący:
-- - 5 % jeśli wartość zamówień jest większa od 0 lecz nie większa od 100 zł;
-- - 10 % jeśli wartość zamówień jest z przedziału 101-400 zł;
-- - 15 % jeśli wartość zamówień jest z przedziału 401-700 zł;
-- - 20 % jeśli wartość zamówień jest większa od 700 zł.

SET search_path to kwiaciarnia;

DROP FUNCTION IF EXISTS rabat(VARCHAR);
CREATE FUNCTION rabat(klient VARCHAR)
    RETURNS NUMERIC(7, 2) as
$$

DECLARE
	act NUMERIC(7, 2);
	old NUMERIC(7, 2);
	summ NUMERIC(7, 2);

BEGIN
	SELECT SUM(cena) INTO act FROM zamowienia WHERE idklienta = klient;
	SELECT SUM(cena) INTO old FROM historia
	WHERE idklienta = klient AND age(termin) < INTERVAL '7 days';

	IF act IS NULL AND old IS NULL
        THEN RETURN 0;
	END IF;

	summ := old+act;
	IF summ = 0
        THEN RETURN 0;
	END IF;

	IF summ > 0 AND summ <= 100
        THEN RETURN 0.05;
	ELSIF summ <= 400
        THEN RETURN 0.1;
	ELSIF summ <= 700
        THEN RETURN 0.15;
	ELSE
        RETURN 0.2;
	END IF;
END;

$$
LANGUAGE plpgsql;
