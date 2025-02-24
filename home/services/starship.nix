{
  libs,
  pkgs,
  config,
  ...
}:
let
  text_color = "#" + config.lib.stylix.colors.base05;
  dark_text_color = "#" + config.lib.stylix.colors.base03;
  user_color = "#" + config.lib.stylix.colors.base03;
  dir_color = "#" + config.lib.stylix.colors.base04;
  git_color = "#" + config.lib.stylix.colors.base0B;
  error_color = "#" + config.lib.stylix.colors.base08;
in {
  programs.starship = {
    enable = true;
    settings = {
      format = "[](fg:${user_color})$username[](fg:${user_color} bg:${dir_color})$directory[](fg:${dir_color} bg:${git_color})$git_branch$git_status[ ](fg:${git_color})";
      command_timeout = 5000;
      username = {
        show_always = true;
        style_user = "bg:${user_color} fg:${text_color}";
        style_root = "bg:${user_color} fg:${error_color}";
        format = "[ $user ]($style)";
      };
      directory = {
        style = "bg:${dir_color} fg:${text_color}";
        truncation_length = 3;
        truncation_symbol = "…/";
        format = "[ $path ]($style)";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
          "Wallpapers" = " ";
        };
      };
      git_branch = {
        symbol = " ";
        style = "bg:${git_color} fg:${dark_text_color}";
        format = "[ $symbol $branch ]($style)";
      };
      git_status = {
        style = "bg:${git_color} fg:${dark_text_color}";
        format = "[ $all_status $ahead_behind ]($style)";
      };
    };
  };
}
