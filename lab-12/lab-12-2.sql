-- 1. Utwórz wyzwalacz modyfikujący (po aktualizacji rekordów w tabeli pudelka) pole cena w tabeli pudelka, jeżeli cena jest mniejsza niż 105% kosztów wytworzenia danego pudełka czekoladek (koszt wytworzenia czekoladek + koszt pudełka 0,90 zł). W takim przypadku cenę należy ustawić na kwotę 105% kosztów wytworzenia.

UPDATE pudelka SET cena = 14.56 WHERE idpudelka = 'love';
-- KwerENDa wypisujaca potencjalne rekordy dla ktorych trigger powinien zostac wywolany:
SELECT p.idpudelka, SUM(koszt*sztuk)+0.9 AS SUMa, p.cena
   FROM pudelka p
   NATURAL JOIN zawartosc z
   JOIN czekoladki c USING(idczekoladki)
GROUP BY idpudelka, cena;

DROP TRIGGER IF EXISTS tr_cena_pudelka ON pudelka;
DROP FUNCTION IF EXISTS fn_cena_pudelka();

CREATE FUNCTION fn_cena_pudelka()
   RETURNS TRIGGER AS
$$

DECLARE koszt1 NUMERIC(7,2);

BEGIN
   SELECT SUM(koszt*sztuk)+0.9 INTO koszt1
   FROM pudelka p NATURAL JOIN zawartosc z JOIN czekoladki c USING(idczekoladki)
   WHERE idpudelka=new.idpudelka GROUP BY cena;

   IF new.cena < 1.05*koszt1 THEN
      new.cena := 1.05*koszt1;
   END IF;

   RETURN new;
END;

$$
LANGUAGE plpgsql;

CREATE TRIGGER tr_cena_pudelka
   BEFORE INSERT OR UPDATE ON pudelka
   FOR EACH ROW EXECUTE PROCEDURE fn_cena_pudelka();

-- KwerENDa aktualizujaca rekord
UPDATE pudelka SET cena = 4.38 WHERE idpudelka = 'love';

-- KwerENDa sprawdzajaca:
SELECT p.idpudelka, SUM(koszt*sztuk)+0.9 AS SUMa, p.cena
   FROM pudelka p
   NATURAL JOIN zawartosc z
   JOIN czekoladki c USING(idczekoladki)
GROUP BY idpudelka, cena;

-- 2. Utwórz wyzwalacz modyfikujący (przy wstawianiu i aktualizacji rekordów w tabeli zawartosc) pole cena w tabeli pudelka, jeżeli cena jest mniejsza niż 105% kosztów wytworzenia danego pudełka czekoladek (koszt wytworzenia czekoladek + koszt pudełka 0,90 zł). W takim przypadku cenę należy ustawić na kwotę 105% kosztów wytworzenia.

DROP TRIGGER IF EXISTS tr_cena_pudelka1 ON pudelka;
DROP FUNCTION IF EXISTS fn_cena_pudelka1();

CREATE FUNCTION fn_cena_pudelka1()
   RETURNS TRIGGER AS
$$

DECLARE
    koszt1 NUMERIC(7,2);
    stara_cena NUMERIC(7,2);
    nowa_cena NUMERIC(7,2);

BEGIN
    SELECT SUM(koszt*sztuk)+0.9 INTO koszt1
        FROM pudelka p
        NATURAL JOIN zawartosc z
        JOIN czekoladki c USING(idczekoladki)
    WHERE idpudelka = new.idpudelka
    GROUP BY cena;

    SELECT cena INTO stara_cena
        FROM pudelka
    WHERE idpudelka = new.idpudelka;

    IF stara_cena < 1.05*koszt1 THEN
        nowa_cena := 1.05*koszt1;
    ELSE
        nowa_cena := stara_cena;
    END IF;

    UPDATE pudelka SET cena=nowa_cena
        WHERE idpudelka = new.idpudelka;

    RETURN NULL;
END;

$$
LANGUAGE plpgsql;

CREATE TRIGGER tr_cena_pudelka1
   BEFORE INSERT OR UPDATE ON zawartosc
   FOR EACH ROW EXECUTE PROCEDURE fn_cena_pudelka1();

-- 3. Utwórz wyzwalacz modyfikujący (przy aktualizacji rekordów w tabeli czekoladki) pole cena w tabeli pudelka, jeżeli cena jest mniejsza niż 105% kosztów wytworzenia danego pudełka czekoladek (koszt wytworzenia czekoladek + koszt pudełka 0,90 zł). W takim przypadku cenę należy ustawić na kwotę 105% kosztów wytworzenia.

DROP TRIGGER IF EXISTS tr_cena_pudelka2 ON pudelka;
DROP FUNCTION IF EXISTS fn_cena_pudelka2();

CREATE FUNCTION fn_cena_pudelka2()
    RETURNS TRIGGER AS
$$

DECLARE
    wiersz RECORD;
    koszt1 NUMERIC(7,2);
    cena1 NUMERIC(7,2);

BEGIN
    FOR wiersz IN SELECT idpudelka FROM zawartosc z WHERE z.idczekoladki = new.idczekoladki
    LOOP
        SELECT SUM(koszt*sztuk) + 0.9 INTO koszt1
            FROM pudelka p
            NATURAL JOIN zawartosc z
            JOIN czekoladki c USING(idczekoladki)
        WHERE idpudelka = wiersz.idpudelka
        GROUP BY cena;

        SELECT cena INTO cena1
            FROM pudelka
        WHERE idpudelka = wiersz.idpudelka;

        IF cena1 < 1.05*koszt1 THEN
            cena1 := 1.05*koszt1;
        END IF;

        UPDATE pudelka SET cena=cena1
        WHERE idpudelka = wiersz.idpudelka;

    END LOOP;

    RETURN NULL;
END;

$$
LANGUAGE plpgsql;

CREATE TRIGGER tr_cena_pudelka2
    AFTER UPDATE ON czekoladki
    FOR EACH ROW EXECUTE PROCEDURE fn_cena_pudelka2();
