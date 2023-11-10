.PHONY: install uninstall

install:
	@chmod +x ./src/za.sh
	@cp ./src/za.sh /usr/local/bin/za
	@echo "alias za='source /usr/local/bin/za'" >> ~/.bashrc
	@echo "Installation complete. You can now use 'za' to run the script."

uninstall:
	rm /usr/local/bin/za
	@echo "unalias za'" >> ~/.bashrc
	@echo "Uninstallation complete."