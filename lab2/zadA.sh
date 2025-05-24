#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 2 – semestr letni 2020/2021
#
# Celem zajęć jest nabranie doświadczenia w podstawowej pracy z powłoką Bash,
# w szczególności w nawigowaniu po drzewie katalogów i sprawdzaniu uprawnień.
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
# Zadanie 10.
# Stworzyć zestaw nowych plików w katalogu `zasoby` w `ddd`. Nazwy plików
# do utworzenia zostały podane w kilku plikach `nazwy-1`, `nazwy-2`, itd.,
# które również znajdują się w katalogu `ddd`. Zawartość tworzonych plików
# powinna stanowić liczba, mówiąca ile razy dana nazwa została powtórzona
# w plikach źródłowych `nazwa-...` – to znaczy, domyślnie nowo tworzone pliki
# mają mieć jako zawartość zero (0), jeśli dana nazwa się powtórzy (plik już
# istnieje) to zwiększamy tę wartość na jeden, dwa, itd.
# Zadbać o to, aby każde uruchomienie skryptu miało ten sam efekt – czyli
# aby po drugim uruchomieniu nadal istniały pliki o wartości zero.
# Upewnić się przy tym, że nie usuniemy/nadpiszemy niczego, co było pierwotnie
# w katalogu `zasoby` (możemy zmodyfikować tylko pliki, które podano w plikach
# źródłowych `nazwa-...`; każda nazwa to osobna linia w tych plikach).
#

DEST="ddd/zasoby"

# pobranie nazw plikow z plikow typu nazwy-
FILE_NAMES=$(find ddd/nazwy-* -type f -exec cat {} \;)
echo -e "Nazwy plikow:\n" "$FILE_NAMES"

echo "$FILE_NAMES" | sort | uniq -c | while read count name; do
    FILE_PATH="$DEST/$name"

    # utworznie pliku jezeli nie istnieje i dodanie 0, w przeciwynym razie wpisanie liczby wystapien
    if [ ! -f "$FILE_PATH" ]; then
        echo 0 > "$FILE_PATH"
    else    
        echo "$count" > "$FILE_PATH"
    fi
    # Jeśli plik już istnieje — nic nie zmieniamy (idempotencja)
done
