# SFF SD card adapter

An SD card adapter / SIO peripheral emulator for the [SFF system](https://github.com/dpicken/atari-hw/blob/master/doc/sbc.md).

<img src="/jpeg/sbc-sd/assembled.jpeg" width="480">

- [Schematic](/pdf/sbc-sd-schematic.pdf)
- [Layout](/pdf/sbc-sd-layout.pdf)
- [Gerber](https://github.com/dpicken/atari-hw/raw/master/gerber/sbc-sd.zip)
- [BOM](/pdf/sbc-sd-bom.pdf)

The firmware supports:

- Emulating a single Atari disk drive (D1)
- Loading ATRs from the RP2040's flash
- Loading ATRs from an exFat formatted SD card

# Assembly notes

Solder the SD card socket first.

Insert all three pin headers into their respective locations on the SFF motherboard, then:

- Seat the SD card adapter board onto the pin headers
- Seat the waveshare on top of the SD card adapter board

<img src="/jpeg/sbc-sd/sff-rear.jpeg" width="480">

Ensure the stack is level, then the solder the pin headers.

Remove from the SD adapter board from the SFF motherboard and flow solder through the remaining waveshare pins:

<img src="/jpeg/sbc-sd/sd-rear.jpeg" width="480">

Solder the remaining components.
