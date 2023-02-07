.PHONY: install_%
install_%: $(BUILD_DIR)/pld/%.pld.o
	$(echo_build_message)
	$(echo_recipe)minipro -p ATF22V10C -w $^
