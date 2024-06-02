# use starship for fish config
starship init fish | source

# fish greeting
set fish_greeting

# set cmd aliases
alias tree="tree --dirsfirst"
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias l='ls -CF'
alias vim='nvim'
alias vi='nvim'
alias clear="clear && cd ~ && fish_greeting"
