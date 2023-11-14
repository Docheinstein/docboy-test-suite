## DocBoy Test Suite

Collection of test roms for GameBoy (written to support the accurate development
of the [DocBoy](https://github.com/Docheinstein/docboy) emulator).

This is supposed to verify accurate behaviors (at T-Cycle level) of PPU, timers, interrupts.
Be sure to pass at least [Blagg](https://github.com/retrio/gb-test-roms) `cpu_instrs` and a good part of [Mooneye](https://github.com/Gekkio/mooneye-test-suite) `acceptance` before using this suite.

The tests require at least the implementation of a minimal PPU in order to see the outcome of the tests.

In particular, **horizontal** lines are shown if the test is **passed**.

**Success**\
![Success](images/success.png)

**Fail**\
![Fail](images/fail.png)
## Build

```
make
```