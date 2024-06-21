{ config, pkgs, libs, ... }:

{
  # enable starship to personalize fish prompt
  programs.starship.enable = true;
  # confiugre prompt with starship
  programs.starship.settings = {
    format = "[](#3B4252)$username[](bg:#434C5E fg:#3B4252)$directory[](fg:#434C5E bg:#4C566A)$git_branch$git_status$git_commit[](fg:#4C566A bg:#86BBD8)$c$java$python[](fg:#86BBD8 bg:#06969A)$docker_context[](fg:#06969A bg:#33658A)$time[ ](fg:#33658A)";
    # set command timeout
    command_timeout = 5000;
    # user name configuration
    username = {
      show_always = true;
      style_user = "bg:#3b4252";
      style_root = "bg:#3b4252";
      format = "[ $user ]($style)";
    };
    # directory configuration
    directory = {
      style = "bg:#434c5e";
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
      style = "bg:#4c566a";
      format = "[ $symbol $branch ]($style)";
    };
    git_status = {
      style = "bg:#4c566a";
      format = "[ $all_status $ahead_behind ]($style)";
    };
    git_commit = {
      style = "bg:#4c566a";
      format = "[ $hash$tag ]($style)";
      commit_hash_length = 7;
      only_detached = false;
    };
    # java configuration
    java = {
      symbol = " ";
      style = "fg:#06969a bg:#86bbd8";
      format = "[ $symbol ]($style)";
    };
    # python configuration
    python = {
      symbol = " ";
      style = "fg:#06969a bg:#86bbd8";
      format = "[ $symbol ]($style)";
    };
    # c configuration
    c = {
      symbol = " ";
      style = "fg:06969a bg:#86bbd8";
      format = "[ $symbol ]($style)";
    };
    # add time at the end of the prompt
    time = {
      disabled = false;
      time_format = "%R"; # hh:mm
      style = "bg:#33658a";
      format = "[ $time ]($style)";
    };
  };
}
