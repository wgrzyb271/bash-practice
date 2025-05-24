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
# Zadanie 8.
# Przetworzyć zawartość pliku `dodatkowe/sensors.txt` i wyświetlić całą jego
# zawartość, ale podmieniając w locie zapisane tam wartości temperatur ze skali
# Celsjusza na Fehrenheita: T[°F] = T[°C] * 9/5 + 32.

awk '{
    line = $0
    while (match(line, /\+[0-9]{2,3}\.[0-9]°C/)) {
        tempC = substr(line, RSTART+1, RLENGTH-2)
        tempF = tempC * 9/5 + 32
        # sformatuj do jednej cyfry po przecinku i dodaj °F
        replacement = sprintf("+%.1f°F", tempF)
	# polaczenie zmodyfikowanej linii w calosc
        line = substr(line, 1, RSTART-1) replacement substr(line, RSTART+RLENGTH)
    }
    print line
}' dodatkowe/sensors.txt

