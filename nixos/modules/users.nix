{ pkgs, ... }: {
  users.users.dps = {
    isNormalUser = true;
    description = "dps";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "libvirtd" "dialout" ];
    shell = pkgs.zsh;
  };
  users.users.emma = {
    isNormalUser = true;
    description = "emma";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "libvirtd" "dialout" ];
    shell = pkgs.zsh;
  };
}
