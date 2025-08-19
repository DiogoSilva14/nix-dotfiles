{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neofetch
    fortune
    uv
    fzf
    hyprland

    (pkgs.python311.withPackages (ppkgs: [
      ppkgs.ollama
    ]))
  ];
  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
}
