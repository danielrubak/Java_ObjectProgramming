-- Zadanie 7.1, oprogramowanie: dia

-- Narysuj diagram związków encji według poniższego opisu:
-- 1. Każda firma ma 4 działy, a każdy dział należy do jednej firmy.
-- 2. Każdy dział ma przynajmniej jednego pracownika, a każdy pracownik pracuje w jednym dziale.
-- 3. Każdy pracownik może mieć (lub nie mieć) przynajmniej jednego podwładnego, a każdy podwładny ma jednego zwierzchnika.
-- 4. Każdy pracownik może mieć (lub nie mieć) historię swojego zatrudnienia.

-----------------------------------
-- Zadanie 7.2, oprogramowanie: dia

-- Narysuj diagram związków encji według poniższego opisu.
-- Firmy specjalizują się w prowadzeniu kursów informatycznych i projektów badawczych. Każda firma zatrudnia co najmniej 3, a maksymalnie 30 instruktorów. Firma oferuje co najmniej 1, a maksymalnie 5 kursów z zaawansowanych technologii, z których każdy jest prowadzony przez zespół szkoleniowy złożony z co najmniej dwóch instruktorów. Firma może (ale nie musi) prowadzić projekty badawcze. Liczba prowadzonych projektów nie jest ograniczona. Każdy instruktor jest przydzielany do maksymalnie dwóch zespołów szkoleniowych i może też być przydzielony do prowadzenia projektów badawczych (dowolnie wielu). Każdy projekt badawczy jest prowadzony przez co najmniej 3 instruktorów. Kursy są realizowane w ramach sesji szkoleniowych (ten sam kurs może być powtarzany w wielu sesjach szkoleniowych, dana sesja dotyczy tylko jednego kursu). W jednej sesji szkoleniowej może uczestniczyć od 5 do 100 uczestników.

-- Uwaga: Lista atrybutów może być zredukowana do kluczy dla silnych zbiorów encji.

-----------------------------------
-- Zadanie 7.3, oprogramowanie: dia

-- Firma AAA zajmuje się organizacją wycieczek autokarowych po Europie. Składa się z wielu oddziałów zlokalizowanych w różnych miastach Polski. Narysuj diagram związków encji według poniższego opisu (uwzględnij tylko nazwy zbiorów encji i klucze główne). Każdy oddział zatrudnia co najmniej 3 pracowników w tym 1 kierownika. Każdy pracownik jest zatrudniony w dokładnie jednym oddziale. Wśród oddziałów wyróżnione są oddziały wojewódzkie, którym nadzorują pozostałe oddziały zlokalizowane na terenie danego województwa. Oddziały wojewódzkie są niezależne (nie są nadzorowane). Każdy oddział oferuje co najmniej jedną wycieczkę, przy czym ta sama wycieczka może być oferowana przez wiele oddziałów (co najmniej 1). Każda wycieczka składa się z od 10 do 45 rezerwacji (miejsc w autokarze). Klienci wykupują rezerwacje w wybranym oddziale.

-- Wskazówki:
-- 1. Można zastosować związek wielokrotny między zbiorami encji Rezerwacje, Klienci i Oddziały.
-- 2. Kwestię nadzorowania przedstaw za pomocą związku rekurencyjnego.

--------------
-- Zadanie 7.4

-- Wyznacz relacje dla poniższego konceptualnego modelu danych. (model znajduje się w pliku 7.4.png)

-----------------------------------
-- Zadanie 7.5, oprogramowanie: dia

-- Zmodyfikuj poniższy model konceptualny usuwając z niego elementy niepożądane z punktu widzenia relacyjnego modelu danych. Wyznacz relacje dla poprawionego modelu. (model znajduje się w pliku 7.5.png)
