# SFF Motherboard

Motherboard for the [SFF system](https://github.com/dpicken/atari-hw/blob/master/doc/sbc.md).

<img src="/jpeg/sbc-motherboard/tht.jpeg" width="480">

- [Schematic](/pdf/sbc-schematic.pdf)
- [Layout](/pdf/sbc-layout.pdf)
- [Gerber](https://github.com/dpicken/atari-hw/raw/master/gerber/sbc.zip)
- [BOM](/pdf/sbc-bom.pdf)

# Assembly notes

Solder the SMT components first, starting with the voltage level translators and oscillator, then solder the power connector and RP2040 headers:

<img src="/jpeg/sbc-motherboard/smt.jpeg" width="480">

Install a (flashed) RP2040 controller, then test the GTIA osc, start, select and option signals.

Solder the THT components, then install the ICs (flash the ROM, AMU and RMU first):

<img src="/jpeg/sbc-motherboard/assembled.jpeg" width="480">
