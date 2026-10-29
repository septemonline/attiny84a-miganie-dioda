# Miganie diodą LED na ATtiny84A

[![Kompilacja](https://github.com/septemonline/attiny84a-miganie-dioda/actions/workflows/kompilacja.yml/badge.svg)](https://github.com/septemonline/attiny84a-miganie-dioda/actions/workflows/kompilacja.yml)

Pierwszy program na mikrokontroler AVR: dioda LED na pinie **PB1** zapala się i gaśnie co sekundę. To „Hello World” elektroniki, a przy okazji cały proces od pustego układu do działającego prototypu: podłączenie programatora USBasp, kod w C, kompilacja i wgranie przez avrdude.

> 📖 **Ten kod jest częścią artykułu na blogu SEPTEM:**
> **[Jak zaprogramować mikrokontroler AVR ATtiny84A-PU](https://septemonline.com/kurs-szkolenie/jak-zaprogramowac-mikrokontroler-avr-attiny84a-pu/)**
>
> W artykule znajdziesz schemat, zdjęcia połączeń, wyjaśnienie każdej linijki programu, konfigurację Microchip Studio i rozwiązania najczęstszych błędów. To repozytorium zawiera tylko gotowy kod.

## Co jest potrzebne

| Element | Uwagi |
|---|---|
| ATtiny84A-PU | obudowa PDIP-14, fabrycznie taktowany 1 MHz |
| Programator USBasp | dowolny zgodny z USBasp |
| Dioda LED czerwona + rezystor 150 Ω | rezystor ogranicza prąd diody do ok. 20 mA |
| Kondensator ceramiczny 100 nF | między VCC a GND, jak najbliżej układu |
| Płytka stykowa i przewody | |

## Połączenia

**Dioda:** pin 3 (PB1) → rezystor 150 Ω → anoda diody, katoda → GND.

| Pin ATtiny84A | Funkcja |
|---|---|
| 1 | VCC (1,8–5,5 V) |
| 14 | GND |
| 3 | PB1 – wyjście na diodę |

**Programator USBasp** (złącze 10-pinowe):

| USBasp | ATtiny84A |
|---|---|
| 2 – VCC | 1 – VCC |
| 10 – GND | 14 – GND |
| 5 – RST | 4 – RESET |
| 1 – MOSI | 7 – PA6 (MOSI) |
| 9 – MISO | 8 – PA5 (MISO) |
| 7 – SCK | 9 – PA4 (SCK) |

Piny liczymy od wcięcia na obudowie, przeciwnie do ruchu wskazówek zegara. Podczas programowania układ zasila USBasp. Nie podłączaj w tym czasie innego zasilania.

## Kompilacja i wgranie

### Microchip Studio

Utwórz projekt *GCC C Executable Project* dla ATtiny84A, wklej zawartość [`src/main.c`](src/main.c) i wgraj program avrdude podpiętym pod *External Tools*. Konfiguracja krok po kroku jest [w artykule](https://septemonline.com/kurs-szkolenie/jak-zaprogramowac-mikrokontroler-avr-attiny84a-pu/#jak-dodac-programator-usbasp-do-microchip-studio).

### Z linii poleceń

Potrzebujesz `avr-gcc`, `avr-libc`, `make` i `avrdude`:

- **Windows:** [avr-gcc od Zak Kemble](https://blog.zakkemble.net/avr-gcc-builds/) albo kompilator z Microchip Studio, [avrdude z GitHuba](https://github.com/avrdudes/avrdude/releases),
- **Linux:** `sudo apt install gcc-avr avr-libc binutils-avr avrdude make`,
- **macOS:** `brew tap osx-cross/avr && brew install avr-gcc avrdude`.

```sh
make          # kompilacja → build/miganie.hex
make wgraj    # wgranie przez USBasp
make clean    # sprzątanie
```

Gotowy plik `.hex` z każdej zmiany w repozytorium możesz też pobrać z zakładki [Actions](https://github.com/septemonline/attiny84a-miganie-dioda/actions) (artefakt `miganie-hex`).

## Struktura

```
src/main.c                        program
Makefile                          kompilacja i wgrywanie (avr-gcc + avrdude)
.github/workflows/kompilacja.yml  automatyczna kompilacja na GitHubie
```

## Seria artykułów

1. [Dioda świecąca, bateria i rezystor](https://septemonline.com/kurs-szkolenie/dioda-swiecaca-bateria-i-rezystor/) – pierwszy obwód, bez mikrokontrolera
2. **[Jak zaprogramować mikrokontroler AVR ATtiny84A-PU](https://septemonline.com/kurs-szkolenie/jak-zaprogramowac-mikrokontroler-avr-attiny84a-pu/)** – ten projekt
3. [Jak zaprogramować przycisk w AVR ATtiny](https://septemonline.com/kurs-szkolenie/jak-zaprogramowac-przycisk-w-avr-attiny/) – odczyt stanu wejścia

Więcej artykułów o elektronice i programowaniu jest na blogu: **[septemonline.com/kursy-i-szkolenia](https://septemonline.com/kursy-i-szkolenia/)**.

## Licencja

[MIT](LICENSE) – kod możesz dowolnie wykorzystywać, także komercyjnie.
