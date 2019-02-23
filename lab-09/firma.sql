DROP SCHEMA IF EXISTS firma CASCADE;
CREATE SCHEMA firma;

SET search_path TO firma;

DROP TABLE IF EXISTS firma.dzialy;
DROP TABLE IF EXISTS firma.pracownicy;

BEGIN;

CREATE TABLE firma.dzialy
(
    id_dzialu char(5) NOT NULL,
    nazwa varchar(32) NOT NULL,
    lokalizacja varchar(24) NOT NULL,
    kierownik char(5),
    CONSTRAINT dzial_pk PRIMARY KEY(id_dzialu)
);

CREATE TABLE firma.pracownicy
(
  id_pracownika char(5) NOT NULL,
  nazwisko varchar(32) NOT NULL,
  imie varchar(16) NOT NULL,
  data_ur date NOT NULL,
  dzial char(5) NOT NULL,
  stanowisko varchar(24),
  pobory numeric(8, 2),
  CONSTRAINT prac_pk PRIMARY KEY(id_pracownika),
  CONSTRAINT prac_fk FOREIGN KEY(dzial)
    REFERENCES dzialy(id_dzialu) ON UPDATE cascade
);

ALTER TABLE dzialy ADD CONSTRAINT dzial_fk FOREIGN KEY(kierownik) REFERENCES pracownicy(id_pracownika) ON UPDATE cascade;

COMMIT;
