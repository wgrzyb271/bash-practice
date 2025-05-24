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
# Zadanie 6.
# Odnaleźć w katalogu `bbb` plik, którego zawartość pokrywa się z zawartością
# pliku `bardzo tajna treść` (jest on w katalogu `ddd`) i skopiować znaleziony
# plik do katalogu `ddd`, jeśli jeszcze go tam nie ma.
#

SRC="bbb"
DEST="ddd"
TEXT=$(cat "$DEST/bardzo tajna treść")
echo zawartosc pliku:
echo "$TEXT"
echo
echo znaleziony podobny plik:
FILE=$(grep -rl "$TEXT" "$SRC")
# wyciagniecie nazwy pliku ze sciezki
FILE_NAME=$(basename "$FILE")
echo "$FILE"
echo FILE NAME: "$FILE_NAME"


echo
echo przed operacja w "$DEST":
ls "$DEST"
echo

# sprawdzenie czy plik istnieje w katalogu
if [ ! -f "$DEST/$FILE_NAME" ]; then
	echo w katalogu "$DEST" nie ma takiego pliku...Kopiuje
	cp "$FILE" "$DEST"
else
	echo w katalogu "$DEST" juz jest plik "$FILE_NAME"
fi

echo
echo po operacji w "$DEST":
ls "$DEST"
