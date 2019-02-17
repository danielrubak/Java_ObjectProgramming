-- Napisz bezargumentową funkcję podwyzka, która dokonuje podwyżki kosztów produkcji czekoladek o:
-- - 3 gr dla czekoladek, których koszt produkcji jest mniejszy od 20 gr;
-- - 4 gr dla czekoladek, których koszt produkcji jest z przedziału 20-29 gr;
-- - 5 gr dla pozostałych.
-- Funkcja powinna ponadto podnieść cenę pudełek o tyle o ile zmienił się koszt produkcji zawartych w nich czekoladek. Przed testowaniem działania funkcji wykonaj zapytania, które umieszczą w plikach dane na temat kosztów czekoladek i cen pudełek tak, aby można było później sprawdzić poprawność działania funkcji podwyzka. Przetestuj działanie funkcji.

-- Useful queries
-- Cost of one box of chocolates:
SELECT zawartosc.idpudelka, SUM(zawartosc.sztuk*czekoladki.koszt) FROM czekoladki
    JOIN zawartosc USING(idczekoladki)
    JOIN pudelka USING(idpudelka)
    GROUP BY zawartosc.idpudelka, zawartosc.sztuk;

-- Cost of particular chocolates
SELECT idczekoladki, koszt FROM czekoladki;

DROP FUNCTION IF EXISTS podwyzka();
CREATE FUNCTION podwyzka()
    RETURNS VOID as
$$

DECLARE
	podw NUMERIC(7, 2);
	czeko record;
	zaw zawartosc%ROWTYPE;

BEGIN
    FOR czeko IN (SELECT idczekoladki, koszt FROM czekoladki)
	LOOP
        IF czeko.koszt < 0.2 THEN
			podw := 0.03;
		ELSIF czeko.koszt < 0.30 THEN
			podw := 0.04;
		ELSE
            podw := 0.05;
		END IF;

        UPDATE czekoladki SET koszt = koszt+podw
            WHERE idczekoladki = czeko.idczekoladki;

        FOR zaw in (SELECT * FROM zawartosc)
        LOOP
            IF zaw.idczekoladki = czeko.idczekoladki THEN
                UPDATE pudelka SET cena = cena + zaw.sztuk*podw;
            END IF;
        END LOOP;

    END LOOP;
END;

$$
LANGUAGE plpgsql;
