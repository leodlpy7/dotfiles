{
  pkgs,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "LeoDelpy7";
    userEmail = "leonard.delpy@gmail.com";

    lfs.enable = true;

    aliases = {
      pfusch = "push --force";
      fuckit = "reset --soft HEAD~1";
    };

    extraConfig = {
      pull.rebase = true;
      push.followTags = true;
      merge.conflictstyle = "diff3";
      branch.sort = "-committerdate";
    };
  };
}