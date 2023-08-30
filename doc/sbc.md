# Atari small form factor motherboard

Work-in-progress small form factor (4" x 4") 8-bit Atari motherboard.

- [Schematic](/pdf/sbc-schematic.pdf)
- [Layout](/pdf/sbc-layout.pdf)
- [BOM](/bom/sbc.pdf)

Specs:

- Original Atari LSI (Sally, Antic, GTIA, Pokey, PIA)
- 320 KiB RAM (rambo)
- 32 KiB ROM
- USB Keyboard controller (RP2040 based)
- Audio/Video signal break-out
- Onboard S-Video connector and 3.5mm audio socket

# WIP: Bring-up

SMT components:

<img src="/jpeg/sbc/bringup-smt.jpeg" width="480">

Fully assembled:

<img src="/jpeg/sbc/bringup-assembled.jpeg" width="480">

Atari self test:

<img src="/jpeg/sbc/bringup-selftest.jpeg" width="480">

Load a game (lashed up to a FujiNet):

<img src="/jpeg/sbc/bringup-fujinet.jpeg" width="480">

# Building images for the programmable devices

Clone the following repos:

    git clone https://github.com/dpicken/atari-hw.git
    git clone https://github.com/dpicken/fab.git

Acquire Atari's XL/XE OS and BASIC ROM images and copy them to `./atari-fw/third-party/rom`, e.g.

    cp ~/Downloads/OS_REV3_XE.rom ./atari-hw/third-party/rom/os.rom
    cp ~/Downloads/BASIC_C.rom    ./atari-hw/third-party/rom/basic.rom

Install [rust](https://www.rust-lang.org/tools/install), then install [galette](https://github.com/simon-frankau/galette), e.g.

    git clone https://github.com/simon-frankau/galette
    bash -c "cd galette; cargo build --release"
    cp galette/target/release/galette ~/bin

Build:

    cd ./atari-hw
    make

## Programmable logic

Two ATF22V10C are used to implement address-space decoding.  The AMU ("Address Management Unit") decodes the 16 bit address space.  The RMU ("Ram Management Unit") will eventually handle extended RAM banking.  They can be programmed with a `TL866 II Plus` and the `minipro` software.

To program the AMU:

    make install_amu

To program the RMU:

    make install_rmu320rambo

## ROM

A 27C256 compatible ROM/EPROM/EEPROM is used to provide the OS and BASIC.

To program a AT27C256 OTP ROM:

    make install-sbc-rom-256

Or, to program a W27C512 EEPROM:

    make install-sbc-rom-512

## QTPY keyboard controller firmware

See [atari-fw](https://github.com/dpicken/atari-fw), or, connect the QTPY to the build host, press and hold both its buttons, then release, then install the pre-built `./firmware/atari-fw_qtpy.uf2`, e.g.

    cp ./firmware/atari-fw_qtpy.uf2 /Volumes/RPI-RP2
