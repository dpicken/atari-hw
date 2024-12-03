.PHONY: install-rp-fw
install-prebuilt-rp-fw: ./prebuilt/atari-fw_$(RP_BOARD).uf2
	$(echo_build_message)
	$(echo_recipe)[ -d $(RP_MOUNT) ] || (echo $(RP_MOUNT): RP_MOUNT not available && false)
	$(echo_recipe)cp $^ $(RP_MOUNT)
