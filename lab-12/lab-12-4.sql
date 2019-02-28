-- Udzielenie dostępu:
-- GRANT prawa ON obiekt TO uzytkownik;

-- Prawa: select, insert, update, delete, create, all privileges,
-- Obiekt: tabela, schemat, baza danych, widok etc.,
-- Uzytkownik: nazwa uzytkownika, public (wszyscy).

-- Odbieranie praw:
-- REVOKE prawa ON obiekt FROM uzytkownik;

-- Informacje o prawach dostępu z poziomu psql można uzyskać za pomocą polecenia \z (albo \dp). Domyślnie prawa dostępu są tylko dla właściciela!!!

-- 1. Udziel dostępu do wykonywania zapytań select 2-giej osobie w grupie do tabeli kompozycje (schemat kwiaciarnia); przetestuj.

CREATE ROLE pisanieFunkcji;
GRANT SELECT ON kwiaciarnia.kompozycje TO pisanieFunkcji;;

-- 2. Udziel dostępu do wykonywania zapytań select 2-giej osobie w grupie do schematu firma; przetestuj.

CREATE SCHEMA firma;
GRANT SELECT ON firma.dzialy TO pisanieFunkcji;
GRANT SELECT ON firma.pracownicy TO pisanieFunkcji;

-- 3. Udziel dostępu do dodawania, usuwania, modyfikacji wierszy 2-giej osobie w grupie do tabeli klienci (schemat kwiaciarnia); przetestuj.

GRANT INSERT, DELETE, UPDATE ON kwiaciarnia.klienci TO pisanieFunkcji;

-- 4. Zezwól 2-giej osobie na tworzenie nowych obiektów w schemacie firma; przetestuj.

GRANT CREATE ON SCHEMA firma TO pisanieFunkcji;

-- 5. Powtórz ćwiczenie zamieniając się rolami.
-- 6. Usuń przyznane prawa. Sprawdź, czy 2-ga osoba może teraz wykonać jakieś operacje.

-- Odp. Wystarczy zamienić wszystkie powyższe polecenia na REVOKE
REVOKE SELECT ON kwiaciarnia.kompozycje FROM pisanieFunkcji;
