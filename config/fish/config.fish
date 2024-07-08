# use starship for fish config
starship init fish | source

# fish greeting
set fish_greeting

# set cmd aliases
alias tree="eza --tree --group-directories-first --long --group"
alias ls="eza"
alias ll="eza -l"
alias la="eza -a"
alias lla="eza -la --group"
alias vim="nvim"
alias vi="nvim"
alias clear="clear && cd ~ && fish_greeting"
