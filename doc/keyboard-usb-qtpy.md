# USB Keyboard Controller

Proof-of-concept USB keyboard controller for 8-bit Atari systems.

Limitations:

- Atari keyboard is not usable whilst the controller is powered (the POKEY and GTIA level shifters are permanently enabled).
- The controller's /RESET signal is not level shifted (not a problem in practice)

## BOM

- [QT PY RP2040](https://www.adafruit.com/product/4900)
- [POKEY Interposer](/doc/pokey-interposer.md)
- [GTIA Interposer](/doc/gtia-interposer.md)
- Breadboard
- 2.54 mm pin headers
- 6 pin, 5 pin and 2 pin 2.54mm female jumper leads

## Assembly

It's advisable to flash the controller prior to installation.  There's a pre-built binary blob in this repository: [./firmware/atari-fw_qtpy.u2f](/firmware/atari-fw_qtpy.u2f).  See [atari-fw](https://github.com/dpicken/atari-fw#install-firmware-qt-py-rp2040) for further details.

If necessary, desolder POKEY and GTIA from the Atari PCB and install DIP sockets in their place.

The interposers use SMD components.  It is possible to hand solder them.  Basic requirements are a temperature controlled soldering iron, magnification, fine tweezers, plenty of flux, leaded solder and steady hands:

<img src="/jpeg/keyboard-usb/pokey-interposer.jpeg" height="100"> <img src="/jpeg/keyboard-usb/gtia-interposer.jpeg" height="100">

The SIP socket strips are mounted on the top side of the interposers and soldered.  DIP sockets between an interposer and the Atari PCB socket may be necessary to establish good contact.  Insert GTIA and POKEY into their interposer:

![assembled-interposers.jpeg](/jpeg/keyboard-usb/assembled-interposers.jpeg)

Install the assembled interposers:

![installed-interposers.jpeg](/jpeg/keyboard-usb/installed-interposers.jpeg)

Bridge the 5V USB host jumper on the underside of the QT PY:

![controller-5v-bridge.jpeg](/jpeg/keyboard-usb/controller-5v-bridge.jpeg)

Build a break-out board (on a soldered or solderless breadboard):

|QT PY|POKEY interposer J1|POKEY interposer J2|GTIA interposer J1 |65O2C  |
|-----|-------------------|-------------------|-------------------|-------|
|5V   |                   |Pin 1              |                   |       |
|3V   |Pin 1              |                   |Pin 1              |       |
|GND  |Pin 2              |Pin 2              |Pin 2              |       |
|RX   |Pin 3              |                   |                   |       |
|SCK  |Pin 4              |                   |                   |       |
|MI   |Pin 5              |                   |                   |       |
|MO   |Pin 6              |                   |                   |       |
|TX   |                   |                   |Pin 3              |       |
|SCL  |                   |                   |Pin 4              |       |
|SDA  |                   |                   |Pin 5              |       |
|A3   |                   |                   |                   |Pin 40 |

![controller-breakout.jpeg](/jpeg/keyboard-usb/controller-breakout.jpeg)

Connect the controller to the interposers with jumper cables:

![wiring.jpeg](/jpeg/keyboard-usb/wiring.jpeg)

Connect a USB keyboard:

![result.jpeg](/jpeg/keyboard-usb/result.jpeg)
