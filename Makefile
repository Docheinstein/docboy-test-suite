INCLUDES := $(shell find inc -name "*.inc")

define newline


endef

# <variant-name> <extension> <pre-include-header> <flags>
define define_targets
# Look for all the .asm files under the variant folder
SOURCES_$(1) := $$(shell find source/$(1) -name "*.asm")
TARGETS_$(1) := $$(SOURCES_$(1):source/$(1)/%.asm=roms/$(1)/%.$(2))

roms/$(1)/%.o: source/$(1)/%.asm $$(INCLUDES)
# Build object file
	mkdir -p $$(dir $$@)
	rgbasm -i inc -P $(3) -o $$@ $$<

roms/$(1)/%.$(2): roms/$(1)/%.o
# Link object
	mkdir -p $$(dir $$(@:roms/%.$(2)=symbols/%.sym))
	rgblink -t -o $$@ -n $$(@:roms/%.$(2)=symbols/%.sym) $$<
	rgbfix -v $$@ $(4) -p 255
endef

$(eval $(call define_targets,dmg,gb,dmg.inc))
$(eval $(call define_targets,cgb,gbc,cgb.inc))
$(eval $(call define_targets,cgb_dmg_mode,gb,cgb_dmg_mode.inc))
$(eval $(call define_targets,cgb_dmg_ext_mode,gb,cgb_dmg_ext_mode.inc))

all: $(TARGETS_cgb) $(TARGETS_cgb_dmg_mode) $(TARGETS_cgb_dmg_ext_mode) $(TARGETS_dmg)

clean:
	rm -rf roms symbols

cgb: $(TARGETS_cgb)
cgb_dmg_mode: $(TARGETS_cgb_dmg_mode)
cgb_dmg_ext_mode: $(TARGETS_cgb_dmg_ext_mode)
dmg: $(TARGETS_dmg)

.PHONY: all clean cgb  cgb_dmg_mode cgb_dmg_ext_mode dmg