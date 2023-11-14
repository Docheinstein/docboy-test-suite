SOURCES := $(shell find source -name "*.asm")
TARGETS := $(SOURCES:source/%.asm=roms/%.gb)
INCLUDES := $(shell find inc -name "*.inc")

all: $(TARGETS)



roms/%.o: source/%.asm $(INCLUDES)
	mkdir -p $(shell dirname $@)
	rgbasm -h -i inc -o $@ $<

roms/%.gb: roms/%.o
	mkdir -p $(shell dirname $(@:roms/%.gb=symbols/%.sym))
	rgblink -o $@ -n $(@:roms/%.gb=symbols/%.sym) $<
	rgbfix -jv $@ --ram-size 0 --mbc-type 0 --title "DOCTEST" -p 255
