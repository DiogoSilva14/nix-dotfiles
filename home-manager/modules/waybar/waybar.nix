{ config, pkgs, lib, ... }:
{
programs.waybar = {
	enable = true;
	style = ''
		${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
		${builtins.readFile ./style.css}
	'';
	settings = [{
		height = 30;
		layer = "top";
		position = "top";
		tray = { spacing = 10; };
		modules-center = [ "custom/waybar-mpris" ];
		modules-left = [ "custom/logo" "sway/workspaces" "sway/mode" "sway/window" ];
		modules-right = [
			"pulseaudio"
			"network"
			"cpu"
			"memory"
			"temperature"
			"battery"
			"custom/tdp"
			"custom/tdp2"
			"clock"
			"tray"
		];
		"custom/logo" = {
			tooltip = false;
			format = "";
		};
		battery = {
			tooltip = false;
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
		"custom/tdp" = {
			interval = 2;
			tooltip = false;
			format = "{}";
			exec = ''test -f /sys/class/power_supply/BAT0/current_now && ${pkgs.gawk}/bin/awk -v current=$(cat /sys/class/power_supply/BAT0/current_now) -v voltage=$(cat /sys/class/power_supply/BAT0/voltage_now) 'BEGIN { printf "  %.1f W  ", current * voltage * 10^-12 }' '';
		};
		"custom/tdp2" = {
			interval = 2;
			tooltip = false;
			format = "{}";
			exec = ''test -f /sys/class/power_supply/BAT0/power_now && ${pkgs.gawk}/bin/awk '{printf "  %.1f W  ", $1*10^-6 }' /sys/class/power_supply/BAT0/power_now'';
		};
		clock = {
			tooltip = false;
			format-alt = "{:%d-%m-%Y}";
			tooltip-format = "{:%d-%m-%Y | %H:%M}";
		};
		cpu = {
			tooltip = false;
			format = "{usage}% ";
		};
		memory = { 
			tooltip = false;
			format = "{used}GiB ";
		};
		network = {
			tooltip = false;
			interval = 1;
			format-alt = "{ifname}: {ipaddr}/{cidr}";
			format-disconnected = "Disconnected ⚠";
			format-ethernet = "{ifname}: {ipaddr}/{cidr}     up: {bandwidthUpBits} down: {bandwidthDownBits}";
			format-linked = "{ifname} (No IP) ";
			format-wifi = "{essid} ({signalStrength}%) ";
		};
		pulseaudio = {
			format = "{volume}% {icon} {format_source}";
			format-bluetooth = "{volume}% {icon} {format_source}";
			format-bluetooth-muted = " {icon} {format_source}";
			format-icons = {
				car = "";
				default = [ "" "" "" ];
				handsfree = "";
				headphones = "";
				headset = "";
				phone = "";
				portable = "";
			};
			format-muted = " {format_source}";
			format-source = "{volume}% ";
			format-source-muted = "";
			on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
		};
		"sway/mode" = { format = ''<span style="italic">{}</span>''; };
		"custom/waybar-mpris"= {
			return-type = "json";
			exec = "${pkgs.waybar-mpris}/bin/waybar-mpris --position --autofocus --pause ''";
			on-click = "${pkgs.waybar-mpris}/bin/waybar-mpris --send toggle";
			on-scroll-up = "${pkgs.waybar-mpris}/bin/waybar-mpris --send next";
			on-scroll-down = "${pkgs.waybar-mpris}/bin/waybar-mpris --send prev";
			escape = true;
		};
		temperature = {
			thermal-zone = 4;
			critical-threshold = 80;
			format = "{temperatureC}°C ";
		};
	}];
};
	
home.packages = [
	pkgs.waybar-mpris
	pkgs.gawk
];
}
