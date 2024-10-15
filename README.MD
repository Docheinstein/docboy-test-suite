## DocBoy Test Suite

Collection of test roms for GameBoy and GameBoy Color (written to support the accurate development
of the [DocBoy](https://github.com/Docheinstein/docboy) emulator).

This suite verifies emulation at T-Cycle level.
Be sure to pass at least [Blagg](https://github.com/retrio/gb-test-roms) `cpu_instrs` and a good part of [Mooneye](https://github.com/Gekkio/mooneye-test-suite) `acceptance` before using this suite.

The tests require at least the implementation of a minimal PPU in order to see the outcome of the tests.

The output of most of the test is either **horizontal** lines if the test is **passed** or **vertical** lines if the test is **failed**.

**Success**\
![Success](results/success.png)

**Fail**\
![Fail](results/fail.png)

For all the other tests you can find the expected output in the `results` folder.

## Build

```
make
```