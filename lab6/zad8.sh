#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 6 – semestr letni 2020/2021
#
# Celem zajęć jest zapoznanie się z możliwościami narzędzia awk.
#
# Tradycyjnie nie przywiązujemy zbyt dużej wagi do środowiska roboczego.
# Zakładamy, że format i układ danych w podanych plikach nie ulega zmianie,
# ale same wartości, inne niż podane wprost w treści zadań, mogą ulec zmianie,
# a przygotowane zadania wciąż powinny działać poprawnie (robić to, co trzeba).
#
# Wszystkie chwyty dozwolone, ale w wyniku ma powstać tylko to, o czym jest
# mowa w treści zadania – nie generujemy żadnych dodatkowych plików pośrednich.
# Większość rozwiązań powinno sprowadzić się do jednego, zmyślnego wywołania
# programu `awk` z odpowiednimi argumentami.
# 
#

#
# Zadanie 8.
#
# Plik `dodatkowe/lipsum.txt` zawiera przykładowy tekst z generatora
# http://lipsum.pl/. Używając programu awk, proszę przygotować narzędzie,
# które rozbije tekst w podanym pliku wejściowym w taki sposób, aby każda
# linia miała mniej niż 80 znaków (przy czym staramy się zmakymalizować
# liczbę znaków w każdej linii jak to możliwe). Jako wynik programu wyświetlić
# tekst po przekształceniu.
#

awk '
{
  line = $0
  max_len = 80
  start = 1
  len = length(line)
  
  while (start <= len) {
    # szukamy pozycji do ciecia linii
    end = start + max_len - 1
    if (end >= len) {
      print substr(line, start)
      break
    }
    # szukamy ostatniej spacji w obszarze [start, end]
    segment = substr(line, start, max_len)
    space_pos = 0
    for (i = max_len; i > 0; i--) {
      if (substr(segment, i, 1) == " ") {
        space_pos = i
        break
      }
    }
    if (space_pos == 0) {
      # brak spacji w segmencie - lamiemy bez spacji
      print substr(line, start, max_len)
      start += max_len
    } else {
      # ciecie w ostatniej spacji
      print substr(line, start, space_pos - 1)
      start += space_pos
    }
  }
}
' dodatkowe/lipsum.txt

