-- 1. Utwórz widok (perspektywę), który zwraca: identyfikator zamówienia, datę realizacji, nazwę i adres klienta dla każdego zamówienia - zapytanie takie może być używane np. przez dział wysyłki.

SET search_path TO kwiaciarnia;
COMMIT;

DROP VIEW IF EXISTS wysylki;

CREATE VIEW wysylki AS
SELECT idkompozycji, k.nazwa AS klient, o.nazwa AS odbiorca, o.adres || ' ' || o.miasto || ' ' || o.kod AS adres
    FROM klienci k
    NATURAL JOIN zamowienia JOIN odbiorcy o USING(idodbiorcy);
COMMIT;

-- Sprawdzenie:
SELECT * FROM wysylki;

-- 2. Udostępnij widok z poprzedniego zadania innemu użytkownikowi do odczytu (pracownikowi działu zamówień ;))

GRANT SELECT ON wysylki TO other_user;
