-- Zadanie 9.1, baza danych: kwiaciarnia

-- Tworzona baza danych ma stanowić podstawę dla istnienia internetowej kwiaciarni. Z jednej strony ma ona umożliwić klientowi wybór jednej lub kilku z gotowych kompozycji z oferty kwiaciarni. Przy złożeniu zamówienia klient musi podać swoje dane (identyfikator i hasło) lub zarejestrować się w systemie jeśli jest nowym klientem (korzysta z kwiaciarni pierwszy raz). Poza tym klient musi określić, gdzie mają dostarczone zostać kwiaty i osobę, której mają one zostać przekazane. Z drugiej strony baza danych ma stanowić podstawę zarządzania kwiaciarnią. Powinny być w niej przechowywane informacje o aktualnych zasobach kwiaciarni (ilości poszczególnych kompozycji) i automatycznie zgłaszane zapotrzebowanie na wyczerpujące się zasoby.

-- Przygotuj skrypt implementujący bazę danych kwiaciarnia zgodnie z przedstawionym poniżej projektem i opisem.
-- Uwaga: Baza danych kwiaciarnia ma zostać umieszczona w schemacie kwiaciarnia (patrz zadanie 1.1).
-- Uwaga: zapis maksymalnie n znaków oznacza, że należy użyć typ varchar(n). Zapis dokładnie n znaków oznacza, że należy użyć typ char(n).

-- Schemat bazy danych znajduje się w pliku: kwiaciarnia2.png

-- Tabela: klienci
-- -idklienta - typ znakowy, maksymalnie 10 znaków (tzn. użyć varchar(10)), klucz główny,
-- -haslo - typ znakowy, maksymalnie 10 znaków, minimum 4 znaki, wymagane,
-- -nazwa - typ znakowy, maksymalnie 40 znaków, wymagane,
-- -miasto - typ znakowy, maksymalnie 40 znaków, wymagane,
-- -kod - typ znakowy, dokładnie 6 znaków, wymagane,
-- -adres - typ znakowy, maksymalnie 40 znaków, wymagane,
-- -email - typ znakowy, maksymalnie 40 znaków,
-- -telefon - typ znakowy, maksymalnie 16 znaków, wymagane,
-- -fax - typ znakowy, maksymalnie 16 znaków,
-- -nip - typ znakowy, dokładnie 13 znaków,
-- -regon - typ znakowy, dokładnie 9 znaków,

-- Tabela: kompozycje
-- -idkompozycji - typ znakowy, dokładnie 5 znaków (tzn. użyć char(5)), klucz główny,
-- -nazwa - typ znakowy, maksymalnie 40 znaków, wymagane,
-- -opis - typ znakowy, maksymalnie 100 znaków,
-- -cena - typ numeryczny z dokładnością do 2 cyfr po przecinku, minimalna cena to 40.00 zł,
-- -minimum - typ całkowity,
-- -stan - typ całkowity,

-- Tabela: odbiorcy
-- -idodbiorcy - typ serial, klucz główny,
-- -nazwa - typ znakowy, maksymalnie 40 znaków, wymagane,
-- -miasto - typ znakowy, maksymalnie 40 znaków, wymagane,
-- -kod - typ znakowy, dokładnie 6 znaków, wymagane,
-- -adres - typ znakowy, maksymalnie 40 znaków, wymagane,

-- Tabela: zamowienia
-- -idzamowienia - typ całkowity, klucz główny,
-- -idklienta - typ znakowy, maksymalnie 10 znaków, klucz obcy, wymagane,
-- -idodbiorcy - typ całkowity, klucz obcy, wymagane,
-- -idkompozycji - typ znakowy, dokładnie 5 znaków, klucz obcy, wymagane,
-- -termin - data, wymagane,
-- -cena - typ numeryczny z dokładnością do 2 cyfr po przecinku,
-- -zaplacone - typ logiczny,
-- -uwagi - typ znakowy, maksymalnie 200 znaków,

-- Tabela: historia
-- -idzamowienia - typ całkowity, klucz główny,
-- -idklienta - typ znakowy, maksymalnie 10 znaków,
-- -idkompozycji - typ znakowy, dokładnie 5 znaków,
-- -cena - typ numeryczny z dokładnością do 2 cyfr po przecinku,
-- -termin - data,

-- Tabela: zapotrzebowanie
-- -idkompozycji - typ znakowy, dokładnie 5 znaków, klucz główny i klucz obcy,
-- -data - data.

-- Tworzenie bazy w pliku kwiaciarnia.sql

--------------------------------------
-- Zadanie 9.2, baza danych: kwiaciarnia

-- 1. Wykonaj skrypt tworzący relacje w bazie danych kwiaciarnia.

\i kwiaciarnia.sql

-- 2. Przygotuj odpowiednio dane z pliku kwiaciarnia2dane-tekst.txt i zaimportuj je do bazy danych.

COPY kwiaciarnia.klienci FROM STDIN NULL '';
msowins	msowins	Magdalena Sowinska	Krakow	30-362	ul. Ceglarska 4/101	msowins@wp.pl	(012) 664 46 99	(012) 664 46 99	707-709-12-13
mbabik	mbabik	Malgorzata Babik	Krakow	31-466	ul. Akacjowa 4	mbabik@wp.pl	609 101 101		687-988-66-66
mfibak	mfibak	Marta Fibak	Zielonki	32-087	Zielonki 4	mfibak@wp.pl	(012) 622 22 85	(012) 622 22 85	121-657-09-08
dniemcz	dniemcz	Damian Niemczyk	Slomniki	32-090	ul. Niecala 9	dniemcz@wp.pl	(012) 444 44 57	(012) 444 44 57	345-675-99-87
gurbanik	gurbanik	Grzegorz Urbanik	Wieliczka	32-020	ul. Kwiatowa 33	gurbanik@wp.pl	0 609 506 606		435-987-45-55
pjurecz	pjurecz	Pawel Jureczek	Wieliczka	32-020	ul. Legionow 4/53	pjurecz@wp.pl	(012) 411 18 88		707-709-12-14
msrokiew	msrokiew	Marcin Srokiewicz	Krakow	30-362	ul. Ceglarska 45/12	msrokiew@wp.pl	609 102 102		687-988-66-67
bzameck	bzameck	Beata Zamecka	Krakow	31-450	ul. Ulanow 21/64	bzameck@wp.pl	(012) 634 77 09		121-657-09-09
gkiwi	gkiwi	Gabriela Kiwi	Krakow	31-464	ul. Majowa 45/2	gkiwi@wp.pl	(012) 630 00 12	(012) 630 00 12	345-675-99-88
jkajdeck	jkajdeck	Jan Kajdecki	Krzeszowice	32-065	ul. Piastowska 22/45	jkajdeck@wp.pl	(012) 655 77 98	(012) 655 77 98	435-987-45-56
acygan	acygan	Andrzej Cygan	Krakow	30-838	ul. Heleny 24/1	acygan@wp.pl	0 609 200 300		707-709-12-15
ztylutek	ztylutek	Zofia Tylutek	Krakow	30-034	ul. Koscielna 45/100	ztylutek@wp.pl	(012) 612 12 56		687-988-66-68
msitarz	msitarz	Marcin Sitarz	Wieliczka	32-020	ul. Kwiatowa 2	msitarz@wp.pl	609 100 101		121-657-09-10
ppsiarek	ppsiarek	Paulina Psiarek	Niepolomice	32-005	ul. Wielicka 56	ppsiarek@wp.pl	0 607 200 201		345-675-99-89
Ilipska	Ilipska	Iwona Lipska	Wieliczka	32-020	ul. Urocza 8/7	Ilipska@wp.pl	(012) 433 55 55	(012) 433 55 55	435-987-45-57
mmoraw	mmoraw	Malgorzata Morawiec	Krzeszowice	32-065	ul. Mila 576/5	mmoraw@wp.pl	(012) 633 55 71		707-709-12-16
abazarek	abazarek	Anna Bazarek	Krakow	31-546	ul. Aleja Pokoju 21/23	abazarek@wp.pl	(012) 611 11 23		687-988-66-69
msowin	msowin	Marek Sowinski	Krakow	30-362	ul. Ceglarska 4/101	msowin@wp.pl	(012) 664 46 99	(012) 664 46 99	121-657-09-11
mpalka	mpalka	Monika Palka	Krakow	31-335	ul. Chabrowa 43	mpalka@wp.pl	0 502 322 323		345-675-99-90
jmichno	jmichno	Jacek Michno	Wieliczka	32-020	ul. Urocza 85/7	jmichno@onet.pl	(012) 433 55 56		707-709-12-14
llipecki	llipecki	lukasz Lipecki	Wieliczka	32-020	ul. Urocza 7/66	llipecki@onet.pl	605 200 200		687-988-66-67
dkopera	dkopera	Dorota Kopera	Slomniki	32-090	ul. Niecala 6	dkopera@onet.pl	(012) 444 44 56	(012) 444 44 56	121-657-09-09
lwitek	lwitek	lukasz Witek	Niepolomice	32-005	ul. Mala 2	lwitek@onet.pl	(012) 666 66 66	(012) 666 66 66	345-675-99-88
bzamecka	bzamecka	Barbara Zamecka	Krakow	31-450	ul. Ulanow 21/64	bzamecka@onet.pl	(012) 634 77 09	(012) 634 77 09	435-987-45-56
mrusinek	mrusinek	Magdalena Rusinek	Krakow	30-362	ul. Ceglarska 78/6	mrusinek@onet.pl	(012) 664 44 45		707-709-12-15
kkot	kkot	Karol Kot	Krakow	30-383	ul. Obozowa 44/122	kkot@onet.pl	(012) 677 88 80		687-988-66-68
akulfon	akulfon	Anna Kulfon	Krzeszowice	32-065	ul. Mila 22/66	akulfon@onet.pl	(012) 677 88 81		121-657-09-10
ksowa	ksowa	Karolina Sowa	Skawina	32-050	ul. Mila 3	ksowa@onet.pl	(012) 444 44 44	(012) 444 44 44	345-675-99-89
azarek	azarek	Artur zarek	Krakow	30-059	ul. Aleja A. Mickiewicza 46/75	azarek@onet.pl	(012) 645 45 48		435-987-45-57
rkapusta	rkapusta	Ryszard Kapusta	Krakow	31-464	ul. Majowa 1	rkapusta@onet.pl	(012) 645 45 49	(012) 645 45 49	707-709-12-16
azator	azator	Adam Zator	Krakow	31-450	ul. Ulanow 27/52	azator@onet.pl	(012) 634 77 09		687-988-66-69
gkopicz	gkopicz	Grzegorz Kopiczynski	Wieliczka	32-020	ul. Os. Kosciuszki 12	gkopicz@onet.pl	0 502 400 487		121-657-09-11
kkorzec	kkorzec	Katarzyna Korzecka	Krakow	30-383	ul. Obozowa 57/6	kkorzec@onet.pl	(012) 677 88 88	(012) 677 88 88	345-675-99-90
wzakon	wzakon	Waldemar Zakoniecki	Skawina	32-050	ul. Wrzesniowa 44	wzakon@onet.pl	(012) 677 88 89		435-987-45-58
akopicz	akopicz	Anna Kopiczynska	Wieliczka	32-020	ul. Os. Kosciuszki 12	akopicz@onet.pl	0 502 400 487		707-709-12-17
mmisiek	mmisiek	Maciej Misiek	Niepolomice	32-005	ul. Rynek 5/17	mmisiek@onet.pl	(012) 651 51 52	(012) 651 51 52	687-988-66-70
kkowal	kkowal	Konrad Kowal	Wieliczka	32-020	ul. OSP Trabki 52	kkowal@onet.pl	(012) 411 15 57	(012) 411 15 57	121-657-09-12
kderen	kderen	Karolina Deren	Krakow	30-838	ul. Heleny 5/23	kderen@onet.pl	(012) 632 66 66	(012) 632 66 66	345-675-99-91
zkamien	zkamien	Zofia Kamien	Krakow	31-990	ul. Wadowicka 45/22	zkamien@interia.pl	(012) 633 88 88		707-709-12-14
pzegadlo	pzegadlo	Piotr Zegadlo	Bochnia	32-701	ul. Wygoda 13/13	pzegadlo@interia.pl	(014) 557 55 66		687-988-66-67
pkoper	pkoper	Pawel Koper	Krakow	30-650	ul. Makowa 1/19	pkoper@interia.pl	0 608 350 334		121-657-09-09
mkon	mkon	Mariola Kon	Bochnia	32-701	ul. Wygoda 29/1	mkon@interia.pl	0 502 100 222		345-675-99-88
rrusinek	rrusinek	Robert Rusinek	Krakow	30-362	ul. Ceglarska 78/6	rrusinek@interia.pl	(012) 664 44 45		435-987-45-56
posa	posa	Paulina Osa	Skawina	32-050	ul. Krakowska 4	posa@interia.pl	(012) 442 78 78	(012) 442 78 78	707-709-12-15
aenglert	aenglert	Anna Englert	Krakow	31-990	ul. Wadowicka 3/67	aenglert@interia.pl	(012) 611 22 44	(012) 611 22 44	687-988-66-68
koral	koral	FHU Koral	Bochnia	32-700	ul. Legionow Polskich 23/11	koral@interia.pl	(014) 611 77 77	(014) 611 77 77		590096454
caro	caro	SC Caro	Wieliczka	32-020	ul. Kwiatowa 77	caro@interia.pl	(012) 402 21 65			650043357
amanda	amanda	Sklep Amanda	Krakow	31-406	ul. Aleja 29 Listopada 153/88	amanda@interia.pl	0 607 222 345 			709990260
sp17	sp17	SP nr 17	Bochnia	32-700	ul. Kazimierza Wielkiego 4/67	sp17@interia.pl	(014) 611 77 63			769937163
karolina	karolina	HFU Karolina	Wieliczka	32-020	ul. Legionow 4/53	karolina@interia.pl	(012) 411 18 88	(012) 411 18 88		829884066
\.

COPY kwiaciarnia.kompozycje FROM STDIN NULL '';
buk1	Bukiet 1	roze, trachelium, jagodzina, ti-tin, fizelina	95.00	3	3
buk2	Bukiet 2	rozyczki rodeo i inne kwiaty, fizelina	75.00	3	4
buk3	Bukiet 3	gozdziki, margerytki, santini, kapustka, jagodzina, magic mushrums, papier	90.00	3	4
ko1	Kosz 1	21 roz pomaranczowych, duzo zieleni i kosz z palakiem	250.00	4	4
ko2	Kosz rozyczek	tuzin czerwonych rozyczek, molucella, gips, sizal, koszyk czerwony z palakiem	120.00	10	12
ko3	Kosz mix	gladiole, gerbery, sloneczniki mini, leuki, kolorowe liscie, kosz z palakiem	250.00	4	5
susz	Kompozycja suszona	suszone i preparowane owoce, warzywa i czesci roslin	70.00	2	2
ko4	Koszyk gozdzikowy	gozdziki mini w roznych kolorach, gips, molucella, zatrwian, koszyk z kolnierzem	95.00	3	4
ko5	Hiacynty w koszyku	kosz wiklinowy z hiacyntami i przybraniem	110.00	4	4
don1	Biala azalia	biala azalia z dekoracja w koszyku	120.00	4	4
don2	Rozowa azalia	rozowa azalia z dekoracja w koszyku	120.00	4	5
kw1	Orchidea rozowa	galaz cymbidium, zielona dekoracja, patyki, liscie	95.00	3	4
ko6	Kosz z azalia	azalia, aglomena, wstazka, sizal, kosz z palakiem	70.00	3	3
buk4	Wiazanka czerwona	11 roz Amor i przybranie	90.00	8	9
buk5	Bukiecik serc	3 czerwone rozyczki, serduszka, zielen, podklad sizalowy	75.00	15	16
kw2	Ikebana z rozami	czerwone rozyczki midi, kwiaty sezonowe, ikebana	50.00	6	7
ko7	Kwitnacy kosz	cyklamen, hiacynty, ST. Paula, bluszcze, kosz z palakiem, dekoracja	115.00	4	4
kw3	Sloneczniki z lilia	lilie orientalne, sloneczniki, zeniszek, assengai, mulumbecia, dzbanuszek	100.00	4	4
kw4	Strelicje	5 strelicji, mandzuria, wazon	240.00	4	5
kw5	Anturium latem	3 anturia, kapusta, knofia, roza herbaciana, margerytka, pteris	145.00	5	5
\.

COPY kwiaciarnia.odbiorcy(nazwa,miasto,kod,adres) FROM STDIN NULL '';
Slawomir Zeganek	Krakow	30-059	Al A. Mickiewicza 4/3
Dorota Pszczolka	Slomniki	32-090	ul. Wiosenna 8
Wioletta Barszcz	Skawina	32-050	ul. zwirki i Wigury 7/11
Monika Kotarek	Wieliczka	32-020	ul. OSP Trabki 5
Wojciech Skalecki	Skawina	32-050	ul. Krakowska 34
Malgorzata Mis	Wieliczka	32-020	ul. Krakowska 2/6
Piotr Tynski	Krakow	31-235	ul. Banacha 3/4
Pawel Engel	Krzeszowice	32-065	ul. Daszynskiego 7/55
Malgorzata Korbicz	Krzeszowice	32-065	ul. Piastowska 55/4
Jakub Pionek	Wieliczka	32-020	ul. Krakowska 44/12
Katarzyna Nawarek	Niepolomice	32-005	ul. Wielicka 22
Konrad Misiek	Niepolomice	32-005	ul. Rynek 5/17
Monika Bazarek	Krakow	31-546	ul. Aleja Pokoju 21/23
Anna Bykowska	Krakow	30-145	ul. Hamernia 25/11
Paulina Sitarz	Wieliczka	32-020	ul. Kwiatowa 2
Joanna Galecki	Krzeszowice	32-065	ul. Krakowska 44/23
Justyna Kiwi	Krakow	31-464	ul. Majowa 45/2
Marcin Rympinski	Niepolomice	32-005	ul. Mala 76
Adam Gierka	Bochnia	32-701	ul. Wygoda 13/12
Grzegorz Fibak	Zielonki	32-087	Zielonki 4
Mariusz Gancarz	Wieliczka	32-020	ul. Legionow 2/12
Michal Knyszecka	Krakow	30-650	ul. Makowa 7/44
Pawel Skalecki	Skawina	32-050	ul. Krakowska 34
Marcin Szarotka	Skawina	32-050	ul. Wrzesniowa 1
Marcin Kod	Krakow	30-650	ul. Makowa 12/47
Magdalena Szostek	Krakow	30-034	ul. Koscielna 11/88
Lukasz Krawiec	Krzeszowice	32-065	ul. Piastowska 79/4
\.

COPY kwiaciarnia.zamowienia FROM STDIN NULL '';
2703001	msowins	1	buk1	2007-04-27	95.00	n	dolaczyc zyczenia urodzinowe
2703002	mbabik	1	buk2	2007-04-27	75.00	n	dolaczyc zyczenia urodzinowe
2703003	mfibak	2	buk3	2007-04-27	90.00	t	dostarczyc po godzinie 17.00
2803001	dniemcz	3	ko1	2007-04-28	250.00	t
2803002	gurbanik	3	ko2	2007-04-29	120.00	t	dostarczyc na godzine 10.30
2803003	pjurecz	5	ko3	2007-04-29	250.00	n	dolaczyc zyczenia imieninowe
2803004	msrokiew	6	susz	2007-04-29	70.00	n
2803005	bzameck	8	ko4	2007-04-29	95.00	t	dolaczyc zyczenia imieninowe
2903001	gkiwi	10	ko5	2007-04-29	110.00	n	dolaczyc zyczenia imieninowe
2903002	jkajdeck	2	don1	2007-04-30	120.00	t
2903003	acygan	12	buk2	2007-04-30	75.00	t
2903004	ztylutek	9	buk3	2007-04-30	90.00	n	dostarczyc na godzine 10.30
2903005	amanda	9	ko1	2007-04-30	250.00	n	dostarczyc na godzine 12.30
2903006	sp17	10	ko2	2007-05-12	120.00	t	dostarczyc na godzine 10.00
2903007	karolina	15	ko3	2007-05-12	250.00	t	dostarczyc na godzine 11.30
\.

COPY kwiaciarnia.historia(idzamowienia,idklienta,idkompozycji,cena,termin) FROM STDIN NULL '';
2904007	karolina	ko3	250.00	2007-04-12
2904006	karolina	ko2	120.00	2007-04-12
2904005	karolina	ko2	120.00	2007-04-22
2904003	acygan	buk2	75.00	2007-03-30
2904002	acygan	buk2	75.00	2007-03-29
2904001	lwitek	buk2	75.00	2007-03-29

-- 3. Sprawdź (np. wykonując zapytania), czy wszystkie dane zostały zaimportowane do bazy danych.

-- 4. Jak sprawdzić wartość klucza głównego dla ostatnio dodanego rekodu do tabeli odbiorcy w ramach tej samej sesji?

--------------------------------------
-- Zadanie 9.2.1, baza danych: kwiaciarnia

-- Zweryfikuj działanie sekwencji. Otwórz dwie sesje z baza danych (dwa emulatoy terminala) A i B. Wykonaj odpowiednio co następuje.

-- 1. Sesja A: dodaj odbiorcę: Edmund Pasza.
-- 2. Sesja B: dodaj odbiorcę: Ela Budrys.
-- 3. Sesja A: dodaj zamówienie dla Edmunda Paszy; użyj funkcji currval().
-- 4. Sesja B: dodaj zamówienie dla Eli Budrys; użyj funkcji currval().

-- Czy w identyfikatory odbiorcy w tabeli zamowienia są poprawne? Dlaczego?

--------------------------------------
-- Zadanie 9.3, baza danych: firma

-- Przygotuj skrypt implementujący bazę danych firma zgodnie z przedstawionym poniżej opisem.
-- Uwaga: Baza danych ma zostać umieszczona w schemacie firma.

--Relacja dzialy zawiera atrybuty:
-- -iddzialu - typ znakowy, dokładnie 5 znaków, klucz główny,
-- -nazwa - typ znakowy, maksymalnie 32 znaki, wymagane,
-- -lokalizacja - typ znakowy, maksymalnie 24 znaki, wymagane,
-- -kierownik - liczba całkowita, klucz obcy odwołujący się do pola idpracownika w relacji pracownicy.

-- Relacja pracownicy zawiera atrybuty:
-- -idpracownika - liczba całkowita, klucz główny,
-- -nazwisko - typ znakowy, maksymalnie 32 znaki, wymagane,
-- -imie - typ znakowy, maksymalnie 16 znaków, wymagane,
-- -dataUrodzenia - data, wymagane,
-- -dzial - typ znakowy, dokładnie 5 znaków, wymagane, klucz obcy odwołujący się do pola iddzialu w relacji dzialy,
-- -stanowisko - typ znakowy, maksymalnie 24 znaki,
-- -pobory - typ stałoprzecinkowy z dokładnością do 2 miejsc po przecinku.

-- Ponieważ występują cykliczne zależności między relacjami dzialy i pracownicy, klucz obcy w relacji dzialy należy dodać za pomocą polecenia alter table po utworzeniu obu relacji:

-- ALTER TABLE dzialy ADD CONSTRAINT dzial_fk FOREIGN KEY(kierownik)
--     REFERENCES pracownicy(idpracownika) ON UPDATE CASCADE DEFERRABLE;

\i firma.sql

--------------------------------------
-- Zadanie 9.4, oprogramowanie: dia

-- Narysuj schemat bazy danych firma (patrz schematy baz danych na slajdach do wykładu).

--------------------------------------
-- Zadanie 9.5, baza danych: firma

-- 1. Wykonaj skrypt tworzący relacje w bazie danych firma.
-- 2. Przygotuj skrypt z instrukcjami insert into, wstawiający do bazy firma poniższe krotki:
-- ('PH101','Handlowy','Marki',77)
-- ('PR202','Projektowy','Olecko',27)
-- ('PK101','Personalny','Niwka',72)

-- (27,'Kruk','Adam','15/12/1989','PK101','kierownik',2200.00)
-- (270,'Kowalik','Artur','13/12/1988','PK101','analityk',2400.00)
-- (72,'Kowalik','Adam','15/11/1989','PR202','kierownik',2600.00)
-- (720,'Kowalik','Amadeusz','17/12/1988','PK101','analityk',3200.00)
-- (707,'Kukulka','Antoni','15/12/1999','PH101','robotnik',1600.00)
-- (207,'Kowal','Alojzy','15/10/1998','PH101','robotnik',2000.00)
-- (77,'Kowalus','Adam','12/11/1998','PH101','kierownik',5400.00)
-- (1010,'Kawula','Alojzy','15/11/1998','PK101','robotnik',2500.00)

-- Dane stawiamy wewnątrz transakcji:
-- BEGIN;
-- SET CONSTRAINTS dzial_fk DEFERRED;
-- wstawianie danych
-- COMMIT;

BEGIN
;
ALTER TABLE firma.dzialy DROP CONSTRAINT dzial_fk;
INSERT INTO firma.dzialy VALUES ('PH101', 'Handlowy', 'Marki', '77');
INSERT INTO firma.dzialy VALUES ('PR202', 'Projektowy', 'Olecko', '27');
INSERT INTO firma.dzialy VALUES ('PK101', 'Personalny', 'Niwka', '72');

INSERT INTO firma.pracownicy VALUES ('27', 'Kruk', 'Adam', '15/12/1989', 'PK101', 'kierownik', 2200);
INSERT INTO firma.pracownicy VALUES ('270', 'Kowalik', 'Artur', '13/12/1988', 'PK101', 'analityk', 2400);
INSERT INTO firma.pracownicy VALUES ('72', 'Kowalik', 'Adam', '15/11/1989', 'PR202', 'kierownik', 2600);
INSERT INTO firma.pracownicy VALUES ('720', 'Kowalik', 'Amadeusz', '17/12/1988', 'PK101', 'analityk', 3200);
INSERT INTO firma.pracownicy VALUES ('707', 'Kukulka', 'Antoni', '15/12/1999', 'PH101', 'robotnik', 1600);
INSERT INTO firma.pracownicy VALUES ('207', 'Kowal', 'Alojzy', '15/10/1998', 'PH101', 'robotnik', 2000);
INSERT INTO firma.pracownicy VALUES ('77', 'Kowalus', 'Adam', '12/11/1998', 'PH101', 'kierownik', 5400);
INSERT INTO firma.pracownicy VALUES ('1010', 'Kawula', 'Alojzy', '15/11/1998', 'PK101', 'robotnik', 2500);

ALTER TABLE firma.dzialy ADD CONSTRAINT dzial_fk FOREIGN KEY(kierownik)
  REFERENCES firma.pracownicy(id_pracownika) ON UPDATE CASCADE;
COMMIT;

--------------------------------------
-- Zadanie 9.6, baza danych: firma

-- Napisz zapytanie działające na tabelach bazy danych firma, które:

-- 1. Wyświetla nazwisko, wiek oraz roczne pobory pracownika posortowane wg poborów oraz nazwiska (pole pobory w tabeli pracownicy określa pobory miesięczne).

SELECT nazwisko, EXTRACT(year FROM age(data_ur)), 12*pobory FROM firma.pracownicy ORDER BY 3, 1;

-- 2. Wyświetla nazwisko, imię, datę urodzenia, stanowisko, dział i pobory pracownika, który pracuje na stanowisku robotnik lub analityk i zarabia więcej niż 2000 miesięcznie.

SELECT nazwisko, imie, data_ur, stanowisko, dzial, pobory FROM firma.pracownicy WHERE pobory > 2000 AND stanowisko IN ('analityk', 'robotnik');

-- 3. Wyświetla nazwiska i imiona pracowników, którzy zarabiają więcej niż zarabia Adam Kowalik.

SELECT p1.nazwisko, p1.imie FROM firma.pracownicy p1 JOIN firma.pracownicy p2 ON p1.pobory > p2. pobory AND p2.nazwisko = 'Kowalik' AND p2.imie = 'Adam';
SELECT nazwisko, imie FROM firma.pracownicy WHERE pobory > (SELECT pobory FROM firma.pracownicy WHERE nazwisko = 'Kowalik' AND imie = 'Adam');

-- 4. Podnosi zarobki o 10% na stanowisku robotnik.

UPDATE firma.pracownicy SET pobory = 1.1 * pobory WHERE stanowisko = 'robotnik';

-- 5. Oblicza średnie zarobki oraz ilość pracowników na poszczególnych stanowiskach z wyłączeniem stanowisk kierownik.

SELECT stanowisko, round(AVG(pobory), 2) AS "Srednie zarobki", COUNT(*) AS ilosc FROM firma.pracownicy WHERE stanowisko != 'kierownik' GROUP BY stanowisko;
