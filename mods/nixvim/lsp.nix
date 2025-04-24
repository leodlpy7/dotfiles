{
  pkgs,
  ...
}:
{
  plugins.lsp.enable = true;
  plugins.lsp-lines.enable = true;
  plugins.lsp.servers.nixd.enable = true;
  plugins.lsp.servers.nixd.settings.formatting.command = [ "nixfmt" ];
  extraPackages = [
    pkgs.nixfmt-rfc-style
  ];

  plugins.vimtex = {
    enable = true;
    settings.view_method = "zathura";
  };

  globals = {
    tex_flavour = "latex";
    tex_conceal = "abdmg";
  };

  plugins.fidget.enable = true;
}
