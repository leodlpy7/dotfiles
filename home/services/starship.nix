{
  libs,
  pkgs,
  config,
...
}:
let
  user_color = "#3B4252";
  dir_color = "#434C5E";
  git_color = "#8A24AA";
  time_color = "#B117C3";
in {
  # enable starship to personalize fish prompt
  programs.starship.enable = true;
  # confiugre prompt with starship
  programs.starship.settings = {
    format = "[](${user_color})$username[](fg:${user_color} bg:${dir_color})$directory[](fg:${dir_color} bg:${git_color})$git_branch$git_status[](fg:${git_color} bg:${time_color})$time[ ](fg:${time_color})";
    # set command timeout
    command_timeout = 5000;
    # user name configuration
    username = {
      show_always = true;
      style_user = "bg:${user_color}";
      style_root = "bg:${user_color}";
      format = "[ $user ]($style)";
    };
    # directory configuration
    directory = {
      style = "bg:${dir_color}";
      truncation_length = 3;
      truncation_symbol = "…/";
      format = "[ $path ]($style)";
      # substitutions to shorten long paths
      substitutions = {
        "Documents" = "󰈙 ";
	      "Downloads" = " ";
	      "Music" = " ";
	      "Pictures" = " ";
	      "Wallpapers" = " ";
	      "wallpapers" = " ";
      };
    };
    # git configuration
    git_branch = {
      symbol = " ";
      style = "bg:${git_color}";
      format = "[ $symbol $branch ]($style)";
    };
    git_status = {
      style = "bg:${git_color}";
      format = "[ $all_status $ahead_behind ]($style)";
    };
    # add time at the end of the prompt
    time = {
      disabled = false;
      time_format = "%R"; # hh:mm
      style = "bg:${time_color}";
      format = "[ $time ]($style)";
    };
  };
}
