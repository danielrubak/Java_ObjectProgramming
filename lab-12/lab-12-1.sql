-- 1. Utwórz (i przetestuj działanie) wyzwalacz (w schemacie kwiaciarnia), który przy złożeniu zamówienia przez klienta:
-- - Oblicza rabat dla sprzedającego (użyj funkcji z zadania 11.7) i modyfikuje pole cena w dodawanym rekordzie;
-- - Zmniejsza liczbę dostępnych kompozycji w tabeli kompozycje;
-- - Dodaje rekord do tabeli zapotrzebowanie, jeśli stan danej kompozycji spada poniżej stanu minimalnego.

CREATE OR REPLACE FUNCTION fn_zapotrzebowanie()
    RETURNS TRIGGER AS
$$

DECLARE
    s INTEGER;
    s_min INTEGER;

BEGIN
    UPDATE kompozycje SET stan = stan - 1
        WHERE idkompozycji = new.idkompozycji;

    SELECT stan INTO s FROM kompozycje
        WHERE idkompozycji = new.idkompozycji;

    SELECT minimum INTO s_min FROM kompozycje
        WHERE idkompozycji = new.idkompozycji;

    IF s < s_min THENINSERT INTO zapotrzebowanie
        VALUES(new.idkompozycji, current_date);
    END IF;

    RETURN NULL;
END;

$$
LANGUAGE plpgsql;

CREATE TRIGGER tr_zapotrzebowanie AFTER INSERT ON Zamowienia
FOR EACH ROW EXECUTE PROCEDURE fn_zapotrzebowanie();

COMMIT;

--sprawdzanie
SELECT idkompozycji, stan, minimum FROM kompozycje WHERE idkompozycji = 'buk1';
SELECT * FROM zamowienia ORDER BY 1;
SELECT * FROM zapotrzebowanie;
INSERT INTO zamowienia VALUES (3000002, 'karolina', 8, 'buk1', current_date, 250, 'True', 'brak');

-- 2. ★ Utwórz wyzwalacz (w schemacie kwiaciarnia), który automatycznie usuwa rekordy z tabeli zapotrzebowanie, jeżeli po dostawie (after update) wzrasta stan danej kompozycji powyżej minimum. Przetestuj działanie wyzwalacza.

CREATE FUNCTION fn_anuluj_zapotrzebowanie()
    RETURN TRIGGER AS
$$

BEGIN
    IF old.stan < new.minimum AND new.stan > new.minimum THEN
        DELETE FROM zapotrzebowanie WHERE idkompozycji = new.idkompozycji;
    END IF;

    RETURN NULL;
END;

$$
LANGUAGE plpgsql;

CREATE TRIGGER tr_anuluj_zapotrzebowanie AFTER UPDATE ON kompozycje
FOR EACH ROW EXECUTE PROCEDURE fn_anuluj_zapotrzebowanie()
