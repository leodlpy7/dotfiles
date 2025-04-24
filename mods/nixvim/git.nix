{
  ...
}:
{
  plugins.lazygit.enable = true;

  plugins.gitsigns = {
    enable = true;
    settings.diff_opts = {
      algorithm = "minimal";
      ignore_whitespace_change_at_eol = true;
    };
  };

  keymaps = [
    {
      action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
      key = "<leader>gb";
      options.silent = true;
    }
  ];
}
