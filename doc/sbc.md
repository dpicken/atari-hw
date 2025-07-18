# Small Form Factor (SFF) Atari 8-bit compatible system

<img src="/jpeg/sbc/sbc-cased.jpeg" width="480">

<img src="/jpeg/sbc/sbc.jpeg" width="480">

Specs:

- Original Atari chipset (Sally, Antic, GTIA, Pokey, PIA)
- Two simple programmable logic devices (ATF22V10C) implement address-space decoding and extended RAM:
  - AMU ("Address Management Unit") decodes the 16 bit address space
  - RMU ("Ram Management Unit") supports 320 KiB (compy or rambo) or 128 KiB (130XE) or 64 KiB (65XE) RAM
- 32 KiB ROM (OS, BASIC)
- USB keyboard interface (via a Raspberry Pi RP-series microcontroller board)
- Audio/Video header
- SIO header
- S-Video connector
- 3.5mm audio socket
- 6.5mm x 2.5mm power jack (5V)

Hardware:

- [SFF Motherboard](/doc/sbc-motherboard.md)
- [SFF Audio/Video adapter](/doc/sbc-av.md)
- [SFF SD card adapter](/doc/sbc-sd.md)
- [SFF Case](/doc/sbc-case.md)

Atari self-test:

<img src="/jpeg/sbc/self-test.jpeg" width="480">

Load a game:

<img src="/jpeg/sbc/game.jpeg" width="480">

## Build ROM, AMU, RMU and RP-series microcontroller images

Clone the following repos:

    git clone https://github.com/dpicken/atari-hw.git
    git clone https://github.com/dpicken/atari-fw.git
    git clone https://github.com/dpicken/fab.git

Acquire Atari's XL/XE OS and BASIC ROM images and copy them to `./atari-fw/third-party/rom`, e.g.

    cp ~/Downloads/OS_REV3_XE.rom ./atari-hw/third-party/rom/os.rom
    cp ~/Downloads/BASIC_C.rom    ./atari-hw/third-party/rom/basic.rom
    make -C ./atari-hw roms

Optional: To (re)build the (pre-built) AMU and RMU images, install [rust](https://www.rust-lang.org/tools/install), then install [galette](https://github.com/simon-frankau/galette), e.g.

    git clone https://github.com/simon-frankau/galette
    bash -c "cd galette; cargo build --release"
    cp galette/target/release/galette ~/bin/
    PATH=$PATH:~/bin
    make -C ./atari-hw distribute

Optional: To (re)build the (pre-built) RP-series microcontroller firmware:

    make -C ./atari-fw distribute

## Install images

The ROM, AMU and RMU can be programmed with a `TL866 II Plus` and the `minipro` software.  Install the minipro, e.g.

    brew install minipro

Change into the atari-hw repo:

    cd ./atari-hw

### AMU

To program the AMU with support for 320 KiB RAM (compy, separate Sally/Antic banking):

    make install-prebuilt-jed-amu320compy

To program the AMU for all other RAM configurations:

    make install-prebuilt-jed-amu

### RMU

To program the RMU with support for 320 KiB RAM (compy, separate Sally/Antic banking):

    make install-prebuilt-jed-rmu320compy

To program the RMU with support for 320 KiB RAM (rambo, combined Sally/Antic banking):

    make install-prebuilt-jed-rmu320rambo

To program the RMU with support for 128 KiB RAM (130XE, separate Sally/Antic banking):

    make install-prebuilt-jed-rmu130xe

To program the RMU with support for 64 KiB RAM (65XE / 800XL):

    make install-prebuilt-jed-rmu65xe

### ROM

A 27C256 compatible ROM/EPROM/EEPROM provides the OS and BASIC.

To program a AT27C256 OTP ROM:

    make install-sbc-rom-256

To program a W27C512 EEPROM:

    make install-sbc-rom-512

### RP-series microcontroller

The following RP2040/RP2350 boards are supported:

  - [adafruit qtpy rp2040](https://www.adafruit.com/product/4900) (supports a USB keyboard and builtin ATR library)
  - [pimoroni tiny2350](https://shop.pimoroni.com/products/tiny-2350?variant=42092638699603) (supports a USB keyobard and builtin ATR library)
  - [waveshare rp2040 zero](https://www.waveshare.com/rp2040-zero.htm) (supports a USB keyboard, builtin ATR library and [SFF SD card adapter](https://github.com/dpicken/atari-hw/blob/master/doc/sbc-sd.md))

Connect a supported board to the build host, then boot it into it's bootloader (hold the boot button then press and release the reset button).  Next, copy the appropriate firmware to the `RPI-RP2` drive/mount (adjust the `RP_MOUNT` option as necessary)...

To program an adafruit qtpy rp2040:

    RP_MOUNT=/Volumes/RPI-RP2 RP_BOARD=adafruit_qtpy_rp2040 make install-prebuilt-rp-fw

To program a pimoroni tiny2350:

    RP_MOUNT=/Volumes/RP2350 RP_BOARD=pimoroni_tiny2350 make install-prebuilt-rp-fw

To program a waveshare rp2040 zero:

    RP_MOUNT=/Volumes/RPI-RP2 RP_BOARD=waveshare_rp2040_zero make install-prebuilt-rp-fw

(See [atari-fw](https://github.com/dpicken/atari-fw) for the firmware source).
