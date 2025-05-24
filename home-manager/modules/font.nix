{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.font-awesome
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.droid-sans-mono
  ];
}
