ROM_OS := third-party/atari-rom/OS_REV3_XE
ROM_BASIC := third-party/atari-rom/BASIC_C.rom

.PHONY: $(BUILD_DIR)/sbc.rom.unverified
$(BUILD_DIR)/sbc.rom.unverified: $(ROM_OS) $(ROM_BASIC) | $(BUILD_DIR)
	$(echo_build_message)
	$(echo_recipe)cat $^ <(head -c 8192 /dev/zero) >$@

$(BUILD_DIR)/sbc.rom: $(BUILD_DIR)/sbc.rom.unverified
	$(echo_build_message)
	$(echo_recipe)[ $$(comm -12 <(head -c 16384 $^                | openssl dgst -md5 -binary | xxd -p) <(cat config/rom.os.checksums    | cut -d ' ' -f 1 | sort) | wc -l | sed 's/ //g') = 1 ] || (echo "Error: Unknown OS" && false)
	$(echo_recipe)[ $$(comm -12 <(head -c 24576 $^ | tail -c 8192 | openssl dgst -md5 -binary | xxd -p) <(cat config/rom.basic.checksums | cut -d ' ' -f 1 | sort) | wc -l | sed 's/ //g') = 1 ] || (echo "Error: Unknown BASIC" && false)
	$(echo_recipe)cp $^ $@

all: $(BUILD_DIR)/sbc.rom

.PHONY: install-sbc-rom
install-sbc-rom: $(BUILD_DIR)/sbc.rom
	$(echo_build_message)
	$(echo_recipe)minipro -p AT27C256R@DIP28 -w $^

.PHONY: clean-rom
clean-rom:
	$(echo_recipe)[ ! -d $(BUILD_DIR) ] || rm -f $(BUILD_DIR)/sbc.rom.unverified $(BUILD_DIR)/sbc.rom

clean: clean-rom
