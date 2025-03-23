{ pkgs, lib, ... }:
let 
	mod = "Mod4";
	lock = "swaylock -f -c 000000 -i ${./linux_terminal_wallpaper.png}";
in {
	services.kanshi = {
		enable = true;
		settings = [
			{
				profile.name = "undocked";
				profile.outputs = [{
					criteria = "eDP-1";
					mode = "1920x1080";
					position = "0,0";
				}];
			}
			{
				profile.name = "docked_home";
				profile.outputs = [
				{
					criteria = "eDP-1";
					mode = "1920x1080";
					position = "0,0";
				}
				{
					criteria = "LG Electronics LG HDR 4K 212NTTQ6M817";
					mode = "3840x2160";
					position = "1920,0";
				}];
				profile.exec = [
					"${pkgs.sway}/bin/swaymsg workspace 9, move workspace to eDP-1"	
				];
			}
			{
				profile.name = "docked_work";
				profile.outputs = [
				{
					criteria = "eDP-1";
					mode = "1920x1080";
					position = "0,0";
				}
				{
					criteria = "Goldstar Company Ltd 25BL55WY 109NTPC0W192";
					mode = "1920x1200";
					position = "1920,0";
				}
				{
					criteria = "Goldstar Company Ltd 25BL55WY 109NTZN0W221";
					mode = "1920x1200";
					position = "3840,0";
				}];
				profile.exec = [
					"${pkgs.sway}/bin/swaymsg workspace 9, move workspace to eDP-1"	
				];
			}
		];
	};

	wayland.windowManager.sway = {
		enable = true;
		config = {
			modifier = mod;

			input = {
				"*" = { xkb_layout = "pt"; };
				"type:touchpad" = {
					tap = "enabled";
					natural_scroll = "enabled";
				};
			};

			output = {
				"*"  = { bg = "${./linux_terminal_wallpaper.png} fill"; };
			};

			bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];
			menu = "fuzzel";
			terminal = "kitty";

			window = {
				titlebar = false;
				border = 2;
			};

			colors = {
				background = "#FFFFFF80";
				focused = {
					border = "#FFFFFF80";
					background = "#FFFFFF80";
					text = "#FFFFFF80";
					indicator = "#FFFFFF80";
					childBorder = "#FFFFFF80";
				};
				focusedInactive = {
					border = "#FFFFFF80";
					background = "#FFFFFF80";
					text = "#FFFFFF80";
					indicator = "#FFFFFF80";
					childBorder = "#FFFFFF80";
				};
				unfocused = {
					border = "#FFFFFF80";
					background = "#FFFFFF80";
					text = "#FFFFFF80";
					indicator = "#FFFFFF80";
					childBorder = "#FFFFFF80";
				};
				urgent = {
					border = "#FFFFFF80";
					background = "#FFFFFF80";
					text = "#FFFFFF80";
					indicator = "#FFFFFF80";
					childBorder = "#FFFFFF80";
				};
				placeholder = {
					border = "#FFFFFF80";
					background = "#FFFFFF80";
					text = "#FFFFFF80";
					indicator = "#FFFFFF80";
					childBorder = "#FFFFFF80";
				};
			};

			keybindings = lib.mkOptionDefault {
					"${mod}+x" = "kill";

					"${mod}+space" = "exec ${pkgs.fuzzel}/bin/fuzzel";

					"${mod}+l" = "exec ${lock}";
					"${mod}+Shift+l" = "exec systemctl suspend";

					"${mod}+Control+Shift+Right" = "move workspace to output right";
					"${mod}+Control+Shift+Left" = "move workspace to output left";
					"${mod}+Control+Shift+Down" = "move workspace to output down";
					"${mod}+Control+Shift+Up" = "move workspace to output up";

					"Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot savecopy area";

					"XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
					"XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
					"XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
					"XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
					"XF86MonBrightnessDown" = "exec brightnessctl set 5%";
					"XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
					"XF86AudioPlay" = "exec playerctl play-pause";
					"XF86AudioNext" = "exec playerctl next";
					"XF86AudioPrev" = "exec playerctl previous";
					"XF86Search"  = "exec bemenu-run";
			};

			startup = [
				{ command = "systemctl --user restart xdg-desktop-portal-gtk"; }
				{ command = "systemctl --user restart kanshi"; always = true; }
				{ command = "systemctl --user restart blueman-applet"; always = true; }
				{ command = "systemctl --user restart swayidle"; always = true; }
				{ command = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"; always = true; }
				{ command = ''swayidle -w \
						timeout 540 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
						timeout 600 '${lock}' \
						timeout 900 '[[ $(cat /sys/class/power_supply/AC*/online 2>/dev/null) -eq 0 ]] && systemctl suspend' \
						before-sleep '${lock}'
				''; }
			];
		};

		wrapperFeatures.gtk = true;
	};
}
