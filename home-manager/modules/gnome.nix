{ config, pkgs, lib, ... }:
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
          "gsconnect@andyholmes.github.io"
        ];
        favorite-apps = [
          "com.brave.Browser.desktop"
          "brave-browser.desktop"
          "org.gnome.Nautilus.desktop"
          "com.spotify.Client.desktop"
          "spotify.desktop"
          "kitty.desktop"
          "md.obsidian.Obsidian.desktop"
          "obsidian.desktop"
        ];
      };

      "org/gnome/desktop/background" = {
        picture-uri-dark = "${config.home.homeDirectory}/nix-dotfiles/home-manager/modules/wallpaper.jpg";
      };

      "org/gnome/desktop/screensaver" = {
        picture-uri = "${config.home.homeDirectory}/nix-dotfiles/home-manager/modules/wallpaper.jpg";
        lock-delay = lib.gvariant.mkInt32 900;
      };

      "org/gnome/desktop/session" = {
        idle-delay = lib.gvariant.mkInt32 300;
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
    gnomeExtensions.gsconnect
  ];
}
