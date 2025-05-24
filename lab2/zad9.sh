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
# Zadanie 9.
# W katalogu `zasoby` w `ddd` utworzyć plik `tajne hasła`, który zawierać
# będzie połączoną treść wszystkich plików z katalogu `ccc` (oraz jego
# podkatalogów) – ale tylko takich, które potrafimy przeczytać. Niech każda
# nowa zawartość będzie poprzedzona jakimś wyróżniającym się nagłówkiem
# z nazwą pliku z którego ona pochodzi. Upewnić się także, że w trakcie
# procesu nie zgłoszą nam się problemy z dostępem do plików (to znaczy,
# że na pewno możemy je przeczytać).
#

DEST="ddd/zasoby/tajne hasła"
SOURCE="ccc"

# utworzenie pliku
if [ ! -f "$DEST" ]; then
       touch "$DEST"
	echo "Plik zostal utworzony"
else
	echo "Plik juz istnieje"
fi;

# pobranie tresci
DATA=$(find "$SOURCE" -type f -readable -exec echo "=====> {} <=====" \; -exec cat "{}" \;)
printf "Scalona tresc:\n\n%s" "$DATA"
echo

# zapisanie tresci w pliku
echo "$DATA" > "$DEST"
echo -e  "\nTresc zostala zapisana do pliku" "$DEST\n"
echo "Zawartosc katalogu"
ls $(dirname "$DEST")
