#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 7 – semestr letni 2020/2021
#
# Celem zajęć jest zapoznanie się z wyrażeniami regularnymi, wykorzystując
# przy tym narzędzia awk i grep oraz wszystkie inne, poznane na zajęciach.
#
# Tradycyjnie nie przywiązujemy zbyt dużej wagi do środowiska roboczego.
# Zakładamy, że format i układ danych w podanych plikach nie ulega zmianie,
# ale same wartości, inne niż podane wprost w treści zadań, mogą ulec zmianie,
# a przygotowane zadania wciąż powinny działać poprawnie (robić to, co trzeba).
#
# Wszystkie chwyty dozwolone, ale w wyniku ma powstać tylko to, o czym jest
# mowa w treści zadania – nie generujemy żadnych dodatkowych plików pośrednich.
#

#
# Zadanie 10.
# Proszę opracować uproszczony konwerter plików z formatu JSON do formatu XML
# i przetworzyć nim plik `dodatkowe/simple.json`. Zakładamy, że wejście stanowi
# zawsze pojedyncza linia, klucze i wartości to proste łańcuchy znaków, złożone
# z liter lub cyfr, pomiędzy cudzysłowami, które są rozdzielone jednym znakiem
# dwukropka i co najmniej jedną spacją, a całe pary klucz-wartość są oddzielone
# od siebie jednym przecinkiem i co najmniej jedną spacją.
#
# Przykład przetworzenia: {"klucz": "wartość"} -> <klucz>wartość</klucz>.
#
# Proszę obsłużyć tworzenie samodomykającego się znacznika (<klucz />), kiedy
# wartość stanowi pusty łańcuch "", a także proszę obsłużyć zagnieżdżenie
# kolejnego zbioru kluczy i wartości.
#

awk '
BEGIN {
  xml = ""           # zmienna przechowujaca wynikowy ciag XML
  level = 0          # aktualny poziom zagniezdzenia w strukturze JSON
}

{
  # Usuwamy wszystkie spacje z wczytanej linii, aby ułatwic przetwarzanie
  gsub(/[[:space:]]+/, "", $0)
  length_line = length($0)  # dlugosc linii po usunieciu spacji
  pos = 1                   # indeks aktualnego znaku w linii

  # Przechodzimy znak po znaku przez cala linie
  while (pos <= length_line) {
    ch = substr($0, pos, 1)  # pobieramy aktualny znak

    if (ch == "{") { 
      # Jezeli znak to '{', to wchodzimy na wyzszy poziom zagniezdzenia
      level++
      pos++
    }

    else if (ch == "}") {
      # Jezeli znak to '}', to zamykamy ostatnio otwarty tag na obecnym poziomie
      if (tag[level] != "") {
        # Dopisujemy do wyniku zamkniecie tagu XML o nazwie zapamietanej na tym poziomie
        xml = xml "</" tag[level] ">"
        tag[level] = ""   # zerujemy nazwę tagu na tym poziomie (zamkniety)
      }
      # Zmniejszamy poziom zagniezdzenia, bo wychodzimy ze struktury
      level--
      pos++
    }

    else if (ch == "\"") {
      # Jezeli znak to cudzyslow, to zaczyna sie klucz w formacie "klucz":

      rest = substr($0, pos)  # pobieramy pozostala czesc linii od pozycji pos

      # Sprawdzamy czy poczatek tekstu to "klucz": - klucz w cudzyslowach zakończony dwukropkiem
      if (match(rest, /^"[^"]+":/)) {
        # Wyciagamy nazwe klucza (bez cudzyslow i dwukropka)
        key = substr(rest, 2, RLENGTH - 3)
        # Zapamietujemy nazwe tagu na poziomie o jeden wyzszym niz aktualny level,
        # bo wartosc tego klucza bedzie na poziomie level+1 (zagniezdzenie)
        tag[level+1] = key

        # Przesuwamy indeks pos o dlugosc znalezionego dopasowania (klucz + ":")
        pos += RLENGTH

        # Pobieramy pozostala czesc linii od nowej pozycji pos, aby sprawdzic wartosc klucza
        val_rest = substr($0, pos)

        # Jezeli wartosc to pusty string "", to generujemy samodomykajacy sie tag XML
        if (match(val_rest, /^""/)) {
          xml = xml "<" key " />"
          tag[level+1] = ""  # tag jest juz zamkniety, wiec zerujemy go
          pos += 2          # przesuwamy pos za pusty string ""
        }
        # Jezeli wartosc to niepusty string "jakas_wartosc"
        else if (match(val_rest, /^"[^"]+"/)) {
          # Wyciagamy wartosc bez cudzyslow
          value = substr(val_rest, 2, RLENGTH - 2)
          # Dodajemy tag otwierajacy, wartosc i tag zamykajacy w XML
          xml = xml "<" key ">" value "</" key ">"
          tag[level+1] = ""  # wartosc juz zamknieta w tagu, wiec zerujemy
          pos += RLENGTH     # przesuwamy pos za wartosc
        }
        # Jezeli wartosc zaczyna sie od '{', czyli mamy zagniezdzenie obiektu
        else if (substr(val_rest, 1, 1) == "{") {
          # Otwarcie tagu dla klucza, dalsza zawartosc bedzie przetwarzana pozniej
          xml = xml "<" key ">"
        }
      } else {
        # Jesli nie trafiamy na "klucz":, to przesuwamy sie o znak dalej (bez zmian)
        pos++
      }
    }

    else {
      # Jezeli znak nie jest istotny (np przecinek, dwukropek itp), to przesuwamy dalej
      pos++
    }
  }
}

END {
  # Po przetworzeniu calej linii wypisujemy wynikowy ciag XML w jednej linii
  print xml
}
' dodatkowe/simple.json

