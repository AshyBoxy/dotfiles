if status is-interactive
    # Commands to run in interactive sessions can go here
	abbr --add conf "cd ~/.config"
	abbr --add update "sudo pacman -Syu && yay && flatpak update"	

	sleep 0.05
	fastfetch -l steamOS
	fortune -s -n 100
	export LANG=en_US.UTF-8
	export LC_ALL=en_US.UTF-8
end

thefuck --alias | source

# Created by `pipx` on 2026-03-20 01:13:52
set PATH $PATH /home/Nick/.local/bin
