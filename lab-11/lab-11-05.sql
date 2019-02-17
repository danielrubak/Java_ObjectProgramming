-- Napisz funkcję obnizka odwracająca zmiany wprowadzone w poprzedniej funkcji. Przetestuj działanie funkcji.

DROP FUNCTION IF EXISTS obnizka();
CREATE FUNCTION obnizka()
    RETURNS VOID as
$$

DECLARE
	podw NUMERIC(7, 2);
	czeko record;
	zaw zawartosc%ROWTYPE;

BEGIN
    FOR czeko IN (SELECT idczekoladki, koszt FROM czekoladki)
	LOOP
        IF czeko.koszt < 0.23 THEN
			podw := 0.03;
		ELSIF czeko.koszt < 0.34 THEN
			podw := 0.04;
		ELSE
            podw := 0.05;
		END IF;

        UPDATE czekoladki SET koszt = koszt+podw
            WHERE idczekoladki = czeko.idczekoladki;

        FOR zaw in (SELECT * FROM zawartosc)
        LOOP
            IF zaw.idczekoladki = czeko.idczekoladki THEN
                UPDATE pudelka SET cena = cena - zaw.sztuk*podw;
            END IF;
        END LOOP;

    END LOOP;
END;

$$
LANGUAGE plpgsql;
