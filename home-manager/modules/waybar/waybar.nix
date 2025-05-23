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
      "battery"
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
      album-len = 0;
      max-length = 60;
      escape = true;
    };
  }];
};
  
home.packages = [
  pkgs.waybar-mpris
  pkgs.gawk
];
}
