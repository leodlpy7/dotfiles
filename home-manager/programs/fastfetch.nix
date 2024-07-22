{ config, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        source = "~/dotfiles/home-manager/programs/fastfetch-logo";
        color = {
          "1" = "red";
        };
      };
      # display = {
      #   separator = "    ";
      # };
      modules = [
        {
          type = "custom";
          format = "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓";
        }
        "break"
        {
          type = "os";
          key = " OS 󱄅";
        }
        {
          type = "kernel";
          key = " Kernel ";
          keyColor = "white";
        }
        {
          type = "packages";
          key = " Packages 󰮯";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = " WM 󰨇";
          keyColor = "blue";
        }
        # {
        #   type = "terminal";
        #   key = "  ";
        #   keyColor = "magenta";
        # }
        # {
        #   type = "shell";
        #   key = "  ";
        #   keyColor = "yellow";
        # }
        "break"
        {
          type = "custom";
          format = "┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫";
        }
        "break"
        # {
        #   type = "host";
        #   key = "  ";
        #   keyColor = "bright_blue";
        # }
        {
          type = "cpu";
          key = " CPU ";
          keyColor = "bright_green";
        }
        {
          type = "gpu";
          key = " GPU 󱤓";
          keyColor = "red";
        }
        {
          type = "memory";
          key = " Mem 󰍛";
          keyColor = "bright_yellow";
        }
        {
          type = "disk";
          key = " Disk ";
          keyColor = "bright_cyan";
        }
        "break"
        {
          type = "custom";
          format = "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛";
        }
      ];
    };
  };
}
