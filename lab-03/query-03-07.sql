\echo <!DOCTYPE html>
\echo <html>
\echo <body>
\echo
\echo <h1>Wynik</h1>
\H
\pset border 2
SELECT idmeczu,
(CASE WHEN(gospodarze[1] > goscie[1])THEN 1 ELSE 0 END+
 CASE WHEN (gospodarze[2] > goscie[2]) THEN 1 ELSE 0 END +
 CASE WHEN (gospodarze[3] > goscie[3]) THEN 1 ELSE 0 END +
 CASE WHEN (gospodarze[4] > goscie[4]) THEN 1 ELSE 0 END +
 CASE WHEN (gospodarze[5] > goscie[5]) THEN 1 ELSE 0 END)
|| ':' ||
(CASE WHEN(gospodarze[1] < goscie[1])THEN 1 ELSE 0 END+
 CASE WHEN (gospodarze[2] < goscie[2]) THEN 1 ELSE 0 END +
 CASE WHEN (gospodarze[3] < goscie[3]) THEN 1 ELSE 0 END +
 CASE WHEN (gospodarze[4] < goscie[4]) THEN 1 ELSE 0 END +
 CASE WHEN (gospodarze[5] < goscie[5]) THEN 1 ELSE 0 END)
AS "wynik" FROM statystyki;
\echo
\echo </body>
\echo </html>
