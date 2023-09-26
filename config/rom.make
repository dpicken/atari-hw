ROM_OS := third-party/rom/os.rom
ROM_BASIC := third-party/rom/basic.rom

.PHONY: $(BUILD_DIR)/sbc.rom.unverified
$(BUILD_DIR)/sbc.rom.unverified: $(ROM_OS) $(ROM_BASIC) | $(BUILD_DIR)
	$(echo_build_message)
	$(echo_recipe)cat $(ROM_OS) <(head -c 8192 /dev/zero) $(ROM_BASIC) >$@

$(BUILD_DIR)/sbc-256.rom: $(BUILD_DIR)/sbc.rom.unverified
	$(echo_build_message)
	$(echo_recipe)[ $$(comm -12 <(head -c 16384 $^ | openssl dgst -md5 -binary | xxd -p) <(cat config/rom.os.checksums    | cut -d ' ' -f 1 | sort) | wc -l | sed 's/ //g') = 1 ] || (echo "Error: Unknown OS" && false)
	$(echo_recipe)[ $$(comm -12 <(tail -c  8192 $^ | openssl dgst -md5 -binary | xxd -p) <(cat config/rom.basic.checksums | cut -d ' ' -f 1 | sort) | wc -l | sed 's/ //g') = 1 ] || (echo "Error: Unknown BASIC" && false)
	$(echo_recipe)cat $^ >$@

$(BUILD_DIR)/sbc-512.rom: $(BUILD_DIR)/sbc-256.rom
	$(echo_build_message)
	$(echo_recipe)cat $^ $^ >$@

roms: $(BUILD_DIR)/sbc-256.rom $(BUILD_DIR)/sbc-512.rom

all: roms

.PHONY: install-sbc-rom-256
install-sbc-rom-256: $(BUILD_DIR)/sbc-256.rom
	$(echo_build_message)
	$(echo_recipe)minipro -p AT27C256R@DIP28 -w $^

.PHONY: install-sbc-rom-512
install-sbc-rom-512: $(BUILD_DIR)/sbc-512.rom
	$(echo_build_message)
	$(echo_recipe)minipro -p W27C512@DIP28 -w $^

.PHONY: clean-rom
clean-rom:
	$(echo_recipe)[ ! -d $(BUILD_DIR) ] || rm -f $(BUILD_DIR)/sbc.rom.unverified $(BUILD_DIR)/sbc-???.rom

clean: clean-rom
