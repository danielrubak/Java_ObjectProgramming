-- 1. Rozpocznij transakcję: begin.
-- 2. Wykonaj szereg dowolnych zapytań DML (insert/update/delete).
-- 3. Sprawdź czy efekty w/w zapytań są widoczne w bazie danych (w tej samej sesji oraz w nowo utworzonej sesji).

-- Odp. Bieżąca transakcja została przerwana.

-- 4. Anuluj transakcję: rollback.
-- 5. Sprawdź czy efekty zapytań z punktu 3 są wciąż widoczne w bazie danych (w tej samej sesji oraz w nowo utworzonej sesji).
-- 6. Powtórz kroki 1-3. Zatwierdź transakcję: commit.
-- 7. Sprawdź czy efekty zapytań z punktu 6 są wciąż widoczne w bazie danych (w tej samej sesji oraz w nowo utworzonej sesji).
-- 8. ★ wykonaj powyższe testy zmieniając poziom izolacji transakcji http://www.postgresql.org/docs/9.1/static/sql-set-transaction.html.
