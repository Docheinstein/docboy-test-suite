SOURCES := $(shell find source -name "*.asm")
TARGETS := $(SOURCES:source/%.asm=roms/%.gb)
INCLUDES := $(shell find inc -name "*.inc")

all: $(TARGETS)

roms/%.o: source/%.asm $(INCLUDES)
	mkdir -p $(shell dirname $@)
	rgbasm -h -i inc -o $@ $<

	$(eval MBC_TYPE := $(shell sed -nr 's#;! MBC_TYPE=([0-9]+)#\1#p' $<))
	$(eval MBC_TYPE := $(or $(MBC_TYPE),"0"))

	$(eval RAM_SIZE := $(shell sed -nr 's#;! RAM_SIZE=([0-9]+)#\1#p' $<))
	$(eval RAM_SIZE := $(or $(RAM_SIZE),"0"))

roms/%.gb: roms/%.o
	mkdir -p $(shell dirname $(@:roms/%.gb=symbols/%.sym))
	rgblink -o $@ -n $(@:roms/%.gb=symbols/%.sym) $<
	rgbfix -jv $@ --ram-size $(RAM_SIZE) --mbc-type $(MBC_TYPE) --title "DOCTEST" -p 255
