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
# Zadanie 10.
# Napis pozostawiony markerem w toalecie głosił: „dokument tajemnic został
# otwarty – strzeżcie się wrogowie dziedzica”. Uratuj świat, używając programu
# awk jako swojego zaklęcia Patronusa i przetwarzając zawartość dokumentu
# `dodatkowe/doc-tajemnic.txt` (źródło: http://tinyurl.com/doc-tajemnic).
#
# Proszę oszacować objętość zadań zgłoszonych dla każdego prowadzącego,
# rozmianą jako liczbę istotnych znaków (dla uproszczenia pomijamy znaki
# nowych linii) w wierszach pomiędzy wpisami określajacymi prowadzących.
# Przyjmujemy, że określenie prowadzącego następuje po znaku dwukropka
# w linii zawierającej frazę "Prowadzący:" oraz nie zastanawiamy się nad
# sensem tych określeć – czyli wpisy "Jarosław Rudy" i "Doktor Jarosław Rudy"
# traktujemy jako dwie różne osoby. Jako wynik działania programu proszę
# zwrócić liczby znaków i nazwy prowadzących – każda taka para w osobnej linii.
#
# Uwaga! Jeden prowadzący ma dodatkową spację na końcu linii określającej go
# i według przyjętej reguły – traktujemy ten wpis jak osobną osobę!
#

awk '
# znalezienie wzorca "Prowadzący:"
  /Prowadzący:/ {
    split($0, arr, ":")
    name = arr[2] # pobranie nazwy prowadzacego

    # sprawdzenie czy prowadzacy byl juz wczesniej przetwarzany
    if (!(name in seen)) { 
      order[++idx] = name # dodanie prowadzacego do tablicy
      seen[name] = 1 # oznaczenie ze prowadzacy juz wystapil, i nie trzeba dodawac go do tablicy
    }

    current = name
    next # przejcie do nowej linii
  }
  current != "" {
   	 count[current] += length($0) # zliczenie liczby znakow dla tego prowadzacego
  }
  END {
    # wypisanie wynikow	  
    for (i = 1; i <= idx; i++) {
      n = order[i]
      print count[n], n
    }
  }
' dodatkowe/doc-tajemnic.txt

