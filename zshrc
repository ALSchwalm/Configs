# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gallois"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias install="sudo apt-get install"
alias search="apt-cache search"
alias update="sudo apt-get update && sudo apt-get upgrade"
alias grep="egrep"
alias wget='wget -c'
alias open=""
alias emacsn="emacsclient -n"

alias -g G='| egrep'

alias -s pdf=evince
alias -s zip=file-roller
alias -s rar=file-roller
alias -s bz2=file-roller
alias -s gz=file-roller
alias -s deb="sudo gdebi"
alias -s torrent=transmission-gtk

alias -s mkv=vlc
alias -s mp4=vlc
alias -s mov=vlc
alias -s avi=vlc
alias -s mpg=vlc
alias -s wmv=vlc

alias -s txt="echo 'Opened in existing emacs' && emacsclient -n"
alias -s org="echo 'Opened in existing emacs' && emacsclient -n"
alias -s c="echo 'Opened in existing emacs' && emacsclient -n"
alias -s cpp="echo 'Opened in existing emacs' && emacsclient -n"
alias -s h="echo 'Opened in existing emacs' && emacsclient -n"
alias -s js="echo 'Opened in existing emacs' && emacsclient -n"
alias -s hpp="echo 'Opened in existing emacs' && emacsclient -n"
alias -s py="echo 'Opened in existing emacs' && emacsclient -n"

function apt-list-packages {
    dpkg-query -W --showformat='${Installed-Size} ${Package} ${Status}\n' | grep -v deinstall | sort -n | awk '{print $1" "$2}'
}

function move_up() { 
    BUFFER="cd .."
    zle accept-line
}

function move_back() { 
  BUFFER="cd -"
  zle accept-line
}

zle -N move_up
zle -N move_back

bindkey "^[[1;3D" move_up
bindkey "^[[1;3C" move_back

if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
    PS1='$ '
fi


# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Don't prompt for a huge list, menu it!
zstyle ':completion:*:default' menu 'select=0'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git extract autojump colored-man torrent)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export TERM=xterm-256color
export PATH="/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
