{ pkgs, ... }:
{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
          "tiling-assistant@leleat-on-github"
        ];
        favorite-apps = [
          "brave-browser.desktop"
          "org.gnome.Nautilus.desktop"
          "spotify.desktop"
          "kitty.desktop"
          "obsidian.desktop"
        ];
      };

      "org/gnome/desktop/background" = {
        picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/map-d.svg";
      };

      "org/gnome/desktop/screensaver" = {
        picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/map-d.svg";
      };

      "org/gnome/desktop/interface" = {
        show-battery-percentage = true;
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>t";
        command = "kitty";
        name = "Shell";
      };
    };
  };

  home.packages = with pkgs; [
    gnomeExtensions.tiling-assistant
    gnomeExtensions.appindicator
  ];
}
