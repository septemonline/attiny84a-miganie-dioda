/*
 * main.c – miganie diodą LED na pinie PB1
 * Mikrokontroler: ATtiny84A, taktowanie 1 MHz (ustawienie fabryczne)
 *
 * Opis krok po kroku:
 * https://septemonline.com/kurs-szkolenie/jak-zaprogramowac-mikrokontroler-avr-attiny84a-pu/
 */

// Taktowanie procesora – musi być zdefiniowane przed dołączeniem util/delay.h
#define F_CPU 1000000UL

#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
    // Ustaw pin PB1 jako wyjście
    DDRB |= (1 << PB1);

    // Pętla nieskończona
    while (1)
    {
        // Zmień stan pinu PB1 na przeciwny
        PORTB ^= (1 << PB1);

        // Odczekaj sekundę
        _delay_ms(1000);
    }
}
