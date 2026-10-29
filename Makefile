# Miganie diodą LED – ATtiny84A + USBasp
#
#   make          kompilacja (build/miganie.hex)
#   make wgraj    wgranie programu przez USBasp
#   make clean    usunięcie plików kompilacji
#
# Wymaga avr-gcc i avrdude w PATH.

MCU        = attiny84
AVRDUDE_MCU = attiny84
PROGRAMATOR = usbasp
NAZWA      = miganie
BUILD      = build

CC      = avr-gcc
OBJCOPY = avr-objcopy
SIZE    = avr-size
AVRDUDE = avrdude

CFLAGS = -mmcu=$(MCU) -Os -std=gnu99 -Wall -Wextra

ELF = $(BUILD)/$(NAZWA).elf
HEX = $(BUILD)/$(NAZWA).hex

all: $(HEX)
	$(SIZE) $(ELF)

$(BUILD):
	mkdir -p $(BUILD)

$(ELF): src/main.c | $(BUILD)
	$(CC) $(CFLAGS) -o $@ $<

$(HEX): $(ELF)
	$(OBJCOPY) -O ihex -R .eeprom $< $@

# -B 8: wolniejsze programowanie, bo układ fabrycznie pracuje z 1 MHz
wgraj: $(HEX)
	$(AVRDUDE) -p $(AVRDUDE_MCU) -c $(PROGRAMATOR) -P usb -B 8 -U flash:w:$(HEX):i

clean:
	rm -rf $(BUILD)

.PHONY: all wgraj clean
