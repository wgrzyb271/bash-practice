#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 3 – semestr letni 2020/2021
#
# Celem zajęć jest pogłębienie wiedzy na temat struktury systemu plików,
# poruszania się po katalogach i kontroli uprawnień w skryptach powłoki.
#
# Przygotowane rozwiązania nie muszą być całkowicie uniwersalne. Zakładamy,
# że ogólna struktura katalogów się nie zmienia (nie będzie już więcej/mniej
# poziomów podkatalogów), jednakże same nazwy i zawartości plików (o ile
# nie są podane wprost w treści zadań) mogą być dowolne i ulegać zmianie,
# a przygotowane rozwiązania nadal powinny działać.
#
# Wszystkie chwyty dozwolone, ale ostatecznie w wyniku ma powstać tylko to,
# o czym mowa w treści zadania – tworzone samodzielnie ewentualne tymczasowe
# pliki pomocnicze należy usunąć.
#

#
# Zadanie 4.
# Utworzyć w katalogu `ddd` dowiązania do katalogów `aaa`, `bbb` i `ccc`.
# Nazwy dowiązań mają być takie same, jak nazwy oryginalnych katalogów.
# Zadbać o to, żeby wielokrotne uruchomienie skryptu nie tworzyło żadnych
# dodatkowych plików/dowiązań wewnętrznych.
#


# cel
TARGET=ddd
# tablica katalogow
ORIGIN=(aaa bbb ccc)
# licznik
counter=0


while [ $counter -lt 3 ]; do
	# aktualny katalog
	current_dir=${ORIGIN[$counter]}
	echo "Przetwarzam $current_dir"
	# utworzenie dowiazan symbolicznych do katalogow jezeli nie istnieje
	if [ ! -L $TARGET/$current_dir ]; then
		echo "Tworzenie dowiazania dla $current_dir"
		ln -s ../$current_dir $TARGET/$current_dir
	fi       	
	# inkrementacja liczika
	((counter++))
done	
