{ config, pkgs, inputs, ... }:
	
{
	imports =
	[
		./hardware-configuration.nix
	];

	# Bootloader.
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/vda";
	boot.loader.grub.useOSProber = true;

	networking.hostName = "nixos";
	# networking.wireless.enable = true;	# Enables wireless support via wpa_supplicant.

	# Enable networking
	networking.networkmanager.enable = true;

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	time.timeZone = "Europe/Vienna";
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "de_AT.UTF-8";
		LC_IDENTIFICATION = "de_AT.UTF-8";
		LC_MEASUREMENT = "de_AT.UTF-8";
		LC_MONETARY = "de_AT.UTF-8";
		LC_NAME = "de_AT.UTF-8";
		LC_NUMERIC = "de_AT.UTF-8";
		LC_PAPER = "de_AT.UTF-8";
		LC_TELEPHONE = "de_AT.UTF-8";
		LC_TIME = "de_AT.UTF-8";
	};

	services.displayManager.defaultSession = "plasma";
	services.displayManager.sddm.enable = true;
	services.displayManager.sddm.wayland.enable = true;
	services.desktopManager.plasma6.enable = true;

	console.keyMap = "pt-latin1";
	services.xserver.xkb.layout = "pt";

	# Enable sound with pipewire.
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};
	
	users.users.dps = {
		isNormalUser = true;
		description = "dps";
		extraGroups = [ "networkmanager" "wheel" ];
#		shell = pkgs.zsh;
#		packages = with pkgs; [
#			zsh
#		];
	};


#	home-manager = {
#		extraSpecialArgs = { inherit inputs; };
#		users = {
#			"dps" = import ./home.nix;
#		};
#	};

	programs.firefox.enable = true;
#	programs.zsh.enable = true;

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
#		neovim
		wget
		git
#		zsh
	];

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	services.openssh.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	system.stateVersion = "24.05";
}
