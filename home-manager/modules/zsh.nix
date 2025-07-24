{ config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases =
    let
      flakeDir = "~/nix-dotfiles";
      fhsDir = "${flakeDir}/home-manager/modules/fhs";
    in {
      rebuild = "sudo nixos-rebuild switch --flake ${flakeDir} && home-manager switch --flake ${flakeDir}";
      hms = "nix run nixpkgs#home-manager -- switch --flake ${flakeDir}";
      nix-up = "
        cd ${flakeDir} &&
        nix flake update &&
        git add flake.lock &&
        git commit -m \"Update\" &&
        git push;
        cd -
      ";
      fhs = "nix develop ${fhsDir}";

      fd = "cd ${flakeDir}";

      v = "nvim";
    };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "fzf"
      ];
      theme = "agnoster";
    };

    initContent = ''
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
        . ~/.nix-profile/etc/profile.d/nix.sh
      fi

      export PATH=$PATH:~/.local/bin
      export NIXDOTFILES=~/nix-dotfiles

      sh -c '
      cd $NIXDOTFILES &&
      LAST_UP=$(git --no-pager log -1 --date=default --format="%ct" -- flake.lock) &&
      NOW=$(date +%s) &&
      DIFF=$((NOW - LAST_UP)) &&
      echo "Last nix update: $(($DIFF/86400)) days, $(date -d@$DIFF -u +%H) hours and $(date -d@$DIFF -u +%M) minutes"'
    '';
  };
}
