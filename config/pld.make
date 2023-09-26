.PHONY: install-%
install-%: $(BUILD_DIR)/pld/%.pld.o
	$(echo_build_message)
	$(echo_recipe)minipro -p ATF22V10C -w $^

.PHONY: %.jed
%.jed: $(BUILD_DIR)/pld/%.pld.o
	$(echo_build_message)
	$(echo_recipe)cp $^ prebuilt/$@

.PHONY: distribute
distribute: amu.jed rmu320compy.jed rmu320rambo.jed rmu130xe.jed rmu65xe.jed
	$(echo_build_message)

.PHONY: install-prebuilt-jed-%
install-prebuilt-jed-%: jed/%.jed
	$(echo_build_message)
	$(echo_recipe)minipro -p ATF22V10C -w $^
