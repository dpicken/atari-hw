.PHONY: install-rp2040-fw
install-prebuilt-rp2040-fw: ./prebuilt/atari-fw_$(RP2040_BOARD).uf2
	$(echo_build_message)
	$(echo_recipe)[ -d $(RP2040_MOUNT) ] || (echo $(RP2040_MOUNT): RP2040_MOUNT not available && false)
	$(echo_recipe)cp $^ $(RP2040_MOUNT)
