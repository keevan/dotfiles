#/usr/bin/bash

# KITTY TERMINAL

	# Install kitty (download if not already installed)
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
    launch=n

	# Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in your PATH)
	# ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/

	# Place the kitty.desktop file somewhere it can be found by the OS
	cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications
	sudo ln -sf ~/.local/kitty.app/bin/kitty ~/bin/kitty

	# Update the path to the kitty icon in the kitty.desktop file
	sed -i "s/Icon\=kitty/Icon\=\/home\/$USER\/.local\/kitty.app\/share\/icons\/hicolor\/256x256\/apps\/kitty.png/g" ~/.local/share/applications/kitty.desktop

	# Set it as the default terminal
	gsettings set org.gnome.desktop.default-applications.terminal exec 'kitty'

# NEOVIM

	# Install "latest" stable NVIM (if not already installed)
	rm ~/bin/nvim
	curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
	chmod u+x nvim.appimage
	./nvim.appimage --appimage-extract
	./squashfs-root/AppRun --version
	sudo mv squashfs-root /
	sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
	#nvim -- dont need to run it..
	#mv nvim.appimage ~/bin/nvim
