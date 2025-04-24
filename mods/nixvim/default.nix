{
  pkgs,
  ...
}:
{
  imports = [
    ./git.nix
    ./lsp.nix
    ./nav.nix
    ./opts.nix
  ];

  autoCmd = [
    {
      command = "lua vim.lsp.buf.format()";
      event = [
        "BufWritePre"
      ];
      pattern = [ "*" ];
    }
  ];

  colorschemes.catppuccin.enable = true;

  plugins.cmp =
    let
      border = [
        "╭"
        "─"
        "╮"
        "│"
        "╯"
        "─"
        "╰"
        "│"
      ];
    in
    {
      enable = true;
      settings = {
        sources = [
          {
            name = "path";
          }
          {
            name = "buffer";
          }
        ];
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        };
        window.completion.border = border;
        window.documentation.border = border;
      };
    };

  plugins.cmp-treesitter.enable = true;
  plugins.treesitter = {
    enable = true;
    settings = {
      auto_install = true;
      highlight.enable = true;
    };
  };
}
