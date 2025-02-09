{
  pkgs,
  config,
  ...
}: {
  programs.fish = {
    # use fish
    enable = true;
    # define aliases I use
    shellAliases = {
      # dir / file related
      tree = "eza --tree --group-directories-first --long --group --icons";
      gittree = "eza --tree -a --group-directories-first --long --group --git-ignore --icons";
      ls = "eza --icons";
      ll = "eza -l --icons";
      la = "eza -a --icons";
      lla = "eza -la --group --icons";
      # editor related
      vim = "nvim";
      vi = "nvim";
      # I want to see the fish greeting everytime I clear the screen
      clear = "clear && cd ~ && fastfetch";
    };
    # use starship to configure fish prompt
    interactiveShellInit = "starship init fish | source && fastfetch";
    # define a few functions
    functions = {
      # make dir and directly move into dir just created
      mkdir = {
        body = ''
          command mkdir $argv
          if test $status = 0
            switch $argv[(count $argv)]
              case '-*'
              case '*'
                cd $argv[(count $argv)]
                return
            end
          end
        '';
      };
      # fish greeting message
      fish_greeting = {
        body = '' '';
      # body = ''
      #     echo '                 '(set_color F00)'___
      #       ___======____='(set_color FF7F00)'-'(set_color FF0)'-'(set_color FF7F00)'-='(set_color F00)')
      #     /T            \_'(set_color FF0)'--='(set_color FF7F00)'=='(set_color F00)')    '(set_color red)(whoami)'@'(hostname)'
      #     [ \ '(set_color FF7F00)'('(set_color FF0)'0'(set_color FF7F00)')   '(set_color F00)'\~    \_'(set_color FF0)'-='(set_color FF7F00)'='(set_color F00)')'(set_color yellow)'    Uptime:   '(set_color white)(uptime | sed 's/.*up \([^,]*\), .*/\1/')(set_color red)'
      #      \      / )J'(set_color FF7F00)'~~    \\'(set_color FF0)'-='(set_color F00)')    IP Address: '(set_color white)(wget -qO- ifconfig.me)(set_color red)'
      #       \\\\___/  )JJ'(set_color FF7F00)'~'(set_color FF0)'~~   '(set_color F00)'\)     '(set_color yellow)'Version:    '(set_color white)(echo $FISH_VERSION)(set_color red)'
      #        \_____/JJJ'(set_color FF7F00)'~~'(set_color FF0)'~~    '(set_color F00)'\\
      #        '(set_color FF7F00)'/ '(set_color FF0)'\  '(set_color FF0)', \\'(set_color F00)'J'(set_color FF7F00)'~~~'(set_color FF0)'~~     '(set_color FF7F00)'\\
      #       (-'(set_color FF0)'\)'(set_color F00)'\='(set_color FF7F00)'|'(set_color FF0)'\\\\\\'(set_color FF7F00)'~~'(set_color FF0)'~~       '(set_color FF7F00)'L_'(set_color FF0)'_
      #       '(set_color FF7F00)'('(set_color F00)'\\'(set_color FF7F00)'\\)  ('(set_color FF0)'\\'(set_color FF7F00)'\\\)'(set_color F00)'_           '(set_color FF0)'\=='(set_color FF7F00)'__
      #         '(set_color F00)'\V    '(set_color FF7F00)'\\\\'(set_color F00)'\) =='(set_color FF7F00)'=_____   '(set_color FF0)'\\\\\\\\'(set_color FF7F00)'\\\\
      #                '(set_color F00)'\V)     \_) '(set_color FF7F00)'\\\\'(set_color FF0)'\\\\JJ\\'(set_color FF7F00)'J\)
      #                           '(set_color F00)'/'(set_color FF7F00)'J'(set_color FF0)'\\'(set_color FF7F00)'J'(set_color F00)'T\\'(set_color FF7F00)'JJJ'(set_color F00)'J)
      #                            (J'(set_color FF7F00)'JJ'(set_color F00)'| \UUU)
      #                             (UU)'(set_color normal)
      #  '';
      };
    };
  };
}

