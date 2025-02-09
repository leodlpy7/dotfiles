{
  pkgs,
  config,
  ...
}:
let
  palette = {
    color_1 = "226;13;176";
    # color_1 = "38;2;r;g;b";
    color_2 = "#c52ab8";
    color_3 = "#a24dc1";
    color_4 = "#7a76cb";
    color_5 = "#5f90d2";
    color_6 = "#3cd4dc";
    color_7 = "#1bd5e3";
  };
in {
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        source = "~/.dotfiles/home/services/fastfetch/logo";
      };
      display = {
        # separator = "    ";
        separator = "   ";
      };
      modules = [
        "break"
        {
          type = "os";
          key = " 󱄅";
          keyColor = palette.color_1;
        }
        {
          type = "kernel";
          key = " ";
          keyColor = palette.color_1;
        }
        {
          type = "packages";
          key = " 󰮯";
          keyColor = palette.color_1;
        }
        {
          type = "cpu";
          key = " ";
          keyColor = palette.color_1;
        }
        {
          type = "gpu";
          key = " 󱤓";
          keyColor = palette.color_1;
        }
        {
          type = "memory";
          key = " ";
          keyColor = palette.color_1;
        }
        {
          type = "disk";
          key = " ";
          keyColor = palette.color_1;
        }
      ];
    };
  };
}
