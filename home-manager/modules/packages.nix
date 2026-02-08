{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    fortune
    uv
    fzf
    oelint-adv
    btop
  ];
  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
}
