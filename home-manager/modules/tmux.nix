{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    extraConfig = ''
      #set -ag status-right '#{sysstat_cpu} | | #{battery_status_bg} Batt: #{battery_icon} #{battery_percentage} #{battery_remain} | %a %h-%d %H:%M '

      # Catppuccin
      set -g @catppuccin_flavour 'mocha'
      set -g @catppuccin_window_left_separator ""
      set -g @catppuccin_window_right_separator " "
      set -g @catppuccin_window_middle_separator " █"
      set -g @catppuccin_window_number_position "right"

      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_default_text "#W"

      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#W"

      set -g @catppuccin_status_modules_right "directory user host session"
      set -g @catppuccin_status_left_separator  " "
      set -g @catppuccin_status_right_separator ""
      set -g @catppuccin_status_right_separator_inverse "no"
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "no"

      set -g @catppuccin_directory_text "#{pane_current_path}"
    '';

    plugins = with pkgs; [
      tmuxPlugins.battery
      tmuxPlugins.catppuccin
      tmuxPlugins.sensible
      tmuxPlugins.sysstat
    ];
  };
}
