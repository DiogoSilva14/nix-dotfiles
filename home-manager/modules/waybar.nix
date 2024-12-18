{ config, pkgs, lib, ... }:
{
programs.waybar = {
	enable = true;
	systemd.enable = true;
	style = ''
		${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
		window#waybar {
			background: rgba(17, 17, 17, 0.7);
			border-bottom: none;
		}

		.modules-right {
			opacity: 0.9;
			margin-left: 10px;
			padding: 0px 0px 0px 5px;
		}
	'';

	settings = [{
		output = [
			"eDP-1"
		];
		height = 30;
		layer = "top";
		position = "top";
		tray = { spacing = 10; };
		modules-center = [ "sway/window" ];
		modules-left = [ "sway/workspaces" "sway/mode" ];
		modules-right = [
			"pulseaudio"
			"network"
			"cpu"
			"memory"
			"temperature"
			"battery"
			"clock"
			"tray"
		];
		battery = {
			format = "{capacity}% {icon}";
			format-alt = "{time} {icon}";
			format-charging = "{capacity}% ";
			format-icons = [ "" "" "" "" "" ];
			format-plugged = "{capacity}% ";
			states = {
				critical = 15;
				warning = 30;
			};
		};
		clock = {
			format-alt = "{:%d-%m-%Y}";
			tooltip-format = "{:%d-%m-%Y | %H:%M}";
		};
		cpu = {
			format = "{usage}% ";
			tooltip = false;
		};
		memory = { format = "{used}GiB "; };
		network = {
			interval = 1;
			format-alt = "{ifname}: {ipaddr}/{cidr}";
			format-disconnected = "Disconnected ⚠";
			format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
			format-linked = "{ifname} (No IP) ";
			format-wifi = "{essid} ({signalStrength}%) ";
		};
		pulseaudio = {
			format = "{volume}% {icon} {format_source}";
			format-bluetooth = "{volume}% {icon} {format_source}";
			format-bluetooth-muted = " {icon} {format_source}";
			format-icons = {
				car = "";
				default = [ "" "" "" ];
				handsfree = "";
				headphones = "";
				headset = "";
				phone = "";
				portable = "";
			};
			format-muted = " {format_source}";
			format-source = "{volume}% ";
			format-source-muted = "";
			on-click = "pavucontrol";
		};
		"sway/mode" = { format = ''<span style="italic">{}</span>''; };
		temperature = {
			thermal-zone = 4;
			critical-threshold = 80;
			format = "{temperatureC}°C";
			format-icons = [ "" "" "" ];
		};
	}];
};

fonts.fontconfig.enable = true;

home.packages = with pkgs; [
	font-awesome
];
}

