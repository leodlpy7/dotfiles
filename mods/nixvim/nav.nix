{
  ...
}:
{
  keymaps = [
    {
      action = "<cmd>Telescope live_grep<CR>";
      key = "<leader>rg";
      options.silent = true;
    }
    {
      action = "<cmd>Telescope buffers<CR>";
      key = "<leader>tb";
      options.silent = true;
    }
    {
      action = "<cmd>Telescope file_browser<CR>";
      key = "<leader>f";
      options.silent = true;
    }
  ];

  globals.mapleader = " ";

  plugins.telescope = {
    enable = true;
    extensions.file-browser.enable = true;
  };
}
