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
# Zadanie 8.
# Odszukać w katalogu `ccc` wiszące dowiązania i podjąć próbę ich naprawy
# – zakładamy, że wskazywane przez nie nazwy plików są poprawne, ale doszło
# do jakiegoś zamieszania w strukturze katalogów. Należy odszukać pasujących
# plików w katalogach `aaa` i `bbb`, a jeśli odpowiednie pliki istnieją
# to wyświetlić nazwę dowiązania i po dwukropku proponowaną poprawną ścieżkę
# (na przykład: bravo:../aaa/bravo).
#

#!/bin/bash

source='ccc'
dest=(aaa bbb)

# szukanie wiszacych dowiazan
for link in $source/*; do
    # sprawdzenie czy plik nie istnieje i jest dowiazaniem	
    if [ ! -e "$link" ] && [ -L "$link" ];  then
        target=$(readlink "$link")
        filename=$(basename "$target")

	# iterowanie po katalogach
        for dir in "${dest[@]}"; do
            if [ -e "$dir/$filename" ]; then
                echo "$(basename "$link"):../$dir/$filename"
            fi
        done
    fi
done

