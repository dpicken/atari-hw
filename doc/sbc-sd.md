# SFF SD card adapter

An SD card adapter / SIO peripheral emulator for the [SFF system](https://github.com/dpicken/atari-hw/blob/master/doc/sbc.md).

<img src="/jpeg/sbc-sd/assembled.jpeg" width="480">

- [Schematic](/pdf/sbc-sd-schematic.pdf)
- [Layout](/pdf/sbc-sd-layout.pdf)
- [Gerber](https://github.com/dpicken/atari-hw/raw/master/gerber/sbc-sd.zip)
- [BOM](/pdf/sbc-sd-bom.pdf)

The firmware supports:

- Emulating an Atari disk drive (D1)
- Loading ATR and XEX images from the microcontroller's flash
- Loading ATR and XEX images from an exFat formatted SD card

# Assembly notes

Solder the SD card socket first, then the remaining SMT components:

<img src="/jpeg/sbc-sd/smt.jpeg" width="480">

Solder pin headers to the rear of the board and finally the waveshare RP2040:

<img src="/jpeg/sbc-sd/underside.jpeg" width="480">
