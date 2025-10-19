INCLUDES := $(shell find inc -name "*.inc")

DMG_SOURCES := $(shell find source/dmg -name "*.asm")
DMG_TARGETS := $(DMG_SOURCES:source/dmg/%.asm=roms/dmg/%.gb)

CGB_SOURCES := $(shell find source/cgb -name "*.asm")
CGB_TARGETS := $(CGB_SOURCES:source/cgb/%.asm=roms/cgb/%.gbc)

CGB_DMG_MODE_SOURCES := $(shell find source/cgb_dmg_mode -name "*.asm")
CGB_DMG_MODE_TARGETS := $(CGB_DMG_MODE_SOURCES:source/cgb_dmg_mode/%.asm=roms/cgb_dmg_mode/%.gb)

all: $(DMG_TARGETS) $(CGB_TARGETS) $(CGB_DMG_MODE_TARGETS)

# === DMG ===

roms/dmg/%.o: source/dmg/%.asm $(INCLUDES)
	mkdir -p $(shell dirname $@)
	rgbasm -i inc -P "dmg.inc" -o $@ $<

	$(eval MBC_TYPE := $(shell sed -nr 's#;! MBC_TYPE=([0-9]+)#\1#p' $<))
	$(eval MBC_TYPE := $(or $(MBC_TYPE),"0"))

	$(eval RAM_SIZE := $(shell sed -nr 's#;! RAM_SIZE=([0-9]+)#\1#p' $<))
	$(eval RAM_SIZE := $(or $(RAM_SIZE),"0"))

	$(eval TITLE := $(shell sed -nr 's#;! TITLE=([0-9a-zA-Z]+)#\1#p' $<))
	$(eval TITLE := $(or $(TITLE),"DOCTEST"))

roms/dmg/%.gb: roms/dmg/%.o
	mkdir -p $(shell dirname $(@:roms/%.gb=symbols/%.sym))
	rgblink -t -o $@ -n $(@:roms/%.gb=symbols/%.sym) $<
	rgbfix -jv $@ --ram-size $(RAM_SIZE) --mbc-type $(MBC_TYPE) --title $(TITLE) -p 255

# === CGB ===

roms/cgb/%.o: source/cgb/%.asm $(INCLUDES)
	mkdir -p $(shell dirname $@)
	rgbasm -i inc -P "cgb.inc"  -o $@ $<

	$(eval MBC_TYPE := $(shell sed -nr 's#;! MBC_TYPE=([0-9]+)#\1#p' $<))
	$(eval MBC_TYPE := $(or $(MBC_TYPE),"0"))

	$(eval RAM_SIZE := $(shell sed -nr 's#;! RAM_SIZE=([0-9]+)#\1#p' $<))
	$(eval RAM_SIZE := $(or $(RAM_SIZE),"0"))

	$(eval TITLE := $(shell sed -nr 's#;! TITLE=([0-9a-zA-Z]+)#\1#p' $<))
	$(eval TITLE := $(or $(TITLE),"DOCTEST"))

roms/cgb/%.gbc: roms/cgb/%.o
	mkdir -p $(shell dirname $(@:roms/%.gbc=symbols/%.sym))
	rgblink -t -o $@ -n $(@:roms/%.gbc=symbols/%.sym) $<
	rgbfix -jv $@ --ram-size $(RAM_SIZE)  --mbc-type $(MBC_TYPE) --title $(TITLE) -p 255 -c

# === CGB Compatibilty Mode ===

roms/cgb_dmg_mode/%.o: source/cgb_dmg_mode/%.asm $(INCLUDES)
	mkdir -p $(shell dirname $@)
	rgbasm -i inc -P "cgb.inc" -o $@ $<

	$(eval MBC_TYPE := $(shell sed -nr 's#;! MBC_TYPE=([0-9]+)#\1#p' $<))
	$(eval MBC_TYPE := $(or $(MBC_TYPE),"0"))

	$(eval RAM_SIZE := $(shell sed -nr 's#;! RAM_SIZE=([0-9]+)#\1#p' $<))
	$(eval RAM_SIZE := $(or $(RAM_SIZE),"0"))

	$(eval TITLE := $(shell sed -nr 's#;! TITLE=([0-9a-zA-Z]+)#\1#p' $<))
	$(eval TITLE := $(or $(TITLE),"DOCTEST"))

roms/cgb_dmg_mode/%.gb: roms/cgb_dmg_mode/%.o
	mkdir -p $(shell dirname $(@:roms/%.gb=symbols/%.sym))
	rgblink -t -o $@ -n $(@:roms/%.gb=symbols/%.sym) $<
	rgbfix -jv $@ --ram-size $(RAM_SIZE) --mbc-type $(MBC_TYPE) --title $(TITLE) -p 255


