INCLUDES := $(shell find inc -name "*.inc")

define newline


endef

# <variant-name> <extension> <pre-include-header>
define define_targets
# Look for all the .asm files under the variant folder
SOURCES_$(1) := $$(shell find source/$(1) -name "*.asm")
TARGETS_$(1) := $$(SOURCES_$(1):source/$(1)/%.asm=roms/$(1)/%.$(2))

roms/$(1)/%.o: source/$(1)/%.asm $$(INCLUDES)
# Build object file
	mkdir -p $$(dir $$@)
	rgbasm -i inc -P $(3) -o $$@ $$<

# Set default values
	$$(eval MBC_TYPE := 0)
	$$(eval RAM_SIZE := 0)
	$$(eval TITLE := DOCTEST)
	$$(eval OLD_LICENSE := 0)
	$$(eval NEW_LICENSE := 0)
	$$(eval COLOR_ONLY := 0)
	$$(eval COLOR_COMPATIBLE := 0)

# Parse options from source file in the form ";! <VAR>=<VALUE>"
# Note: shell command replaces newlines with whitespaces: replace them back with newlines
# so that eval can consider them as separate commands (variable definitions).
	$$(eval $$(subst ;,$$(newline),$$(shell sed -nr 's#;! ([A-Z_]+)=([0-9A-Za-z_]+)#\1 := \2;#p' $$<)))

# Convert flag options into actual flags
	$$(eval COLOR_ONLY_FLAG := $$(if $$(filter 1,$$(COLOR_ONLY)),"-C"))
	$$(eval COLOR_COMPATIBLE_FLAG := $$(if $$(filter 1,$$(COLOR_COMPATIBLE)),"-c"))

roms/$(1)/%.$(2): roms/$(1)/%.o
# Link object
	mkdir -p $$(dir $$(@:roms/%.$(2)=symbols/%.sym))
	rgblink -t -o $$@ -n $$(@:roms/%.$(2)=symbols/%.sym) $$<
	rgbfix -jv $$@ --ram-size $$(RAM_SIZE) --mbc-type $$(MBC_TYPE) --title $$(TITLE) \
		--old-license $$(OLD_LICENSE) --new-licensee $$(NEW_LICENSE) \
		$$(COLOR_ONLY_FLAG) $$(COLOR_COMPATIBLE_FLAG) -p 255
endef

$(eval $(call define_targets,dmg,gb,dmg.inc))
$(eval $(call define_targets,cgb,gbc,cgb.inc))
$(eval $(call define_targets,cgb_dmg_mode,gb,cgb.inc))

all: $(TARGETS_cgb) $(TARGETS_cgb_dmg_mode) $(TARGETS_dmg)

clean:
	rm -rf roms symbols

dmg: $(TARGETS_dmg)
cgb: $(TARGETS_cgb)
cgb_dmg_mode: $(TARGETS_cgb_dmg_mode)

.PHONY: all clean dmg cgb cgb_dmg_mode