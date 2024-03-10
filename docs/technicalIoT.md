# Rust on the uNode embedded controller development board

The uNode (pronounced microNode) development board was designed in 1994, with a 10 unit production run in 2015.

The board exposes all the pins on a connector to the 80C552 microcontroller, as well as providing on board RTC, RAM, a 16 key keypad, a 2X24 character LCD screen, and an RS232 port.

Power is supplied at 9V, which is regulated on-board. There is an onboard battery keeping RAM values static, and RTC functioning in the absence of power 9V power.

The board has a bootloader mode, selected with a dip switch, that allows code to be streamed in on the serial port, and stored in RAM, for execution in run mode. The bootloader mode also supports setting the RTC, and serial baud rate.

## Toolchain installation

This is being recorded for when we want to automate build environment build.

- Note: The tool-chain needs to run on Linux, I shelled into a workstation from my Macbook to do the following:
- `git clone https://github.com/meta-rust/meta-rust.git`
- `git clone https://git.yoctoproject.org/poky`
- `cd poky && git checkout -b honister origin/honister && cd -`
- `git clone https://git.openembedded.org/meta-openembedded`
- `cd meta-openembedded && git checkout -b honister origin/honister && cd -`
- `cd pokey`
- Add rust lines to `BBLAYERS` in `conf/bblayers.conf`:

```text
  /mnt/data/tmp/meta-openembedded/meta-oe \
  /mnt/data/tmp/meta-rust \`
```

- Add `rust-hello-world` file to build directory:

```rust
inherit cargo

SRC_URI = "git://github.com/meta-rust/rust-hello-world.git;protocol=https;branch=master"
SRCREV="e0fa23f1a3cb1eb1407165bd2fc36d2f6e6ad728"
LIC_FILES_CHKSUM="file://COPYRIGHT;md5=e6b2207ac3740d2d01141c49208c2147"

SRC_URI += "\
    file://0001-enable-LTO.patch \
    "

SUMMARY = "Hello World by Cargo for Rust"
HOMEPAGE = "https://github.com/meta-rust/rust-hello-world"
LICENSE = "MIT | Apache-2.0"

S = "${WORKDIR}/git"

BBCLASSEXTEND = "native"
```

- `bitbake rust-hello-world`
- Initial run reported missing toolchain dependencies: `sudo apt install chrpath diffstat liblz4-tool`
- Second run failed due to broken pipe, after an hour or so.
- Third run failed due to broken pipe

- For Rasperry Pi pico: `MACHINE should be set to "raspberrypi-pico"`

- `git clone --recurse-submodules https://github.com/ahcbb6/meta-raspberrypi-baremetal.git`

### Main references

- <https://michael2012z.medium.com/rust-with-yocto-eab41476cd7b>
- <https://jaycarlson.net/embedded-linux/>
- <https://github.com/ahcbb6/meta-raspberrypi-baremetal>
