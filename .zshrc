TERM=xterm-256color

###########
# Variables
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --inline-info --color=dark,bg+:235,hl+:10,pointer:5'
export ENHANCD_FILTER="fzf:peco:percol"
export ENHANCD_COMMAND='c'
CODESTATS_API_KEY='SFMyNTY.YldGdWRXVnNZbUZqYUd3PSMjTkRJM09RPT0.vAekt1Z3_xoVG4YMwl7aOgc0ni4w4YmreA5_D8OB6qU'

COLOR_NONE='clear'
COLOR_DEFAULT='246'
COLOR_RED='001'
COLOR_YELLOW='208'
COLOR_GREEN='002'
COLOR_BLACK='235'
COLOR_DARKGREY='237'
COLOR_GREY='244'
COLOR_WHITE='255'

################
# General config
export EDITOR='/usr/bin/nano'
export VISUAL='/usr/bin/nano'

#########
# Aliases
alias reload='source ~/.zshrc'

#########
# Plugins
# Check if zplug is installed
# [ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

# zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Enhanced cd
zplug "b4b4r07/enhancd", use:init.sh

# Fuzzy search
# zplug "andrewferrier/fzf-z"
zplug "k4rthik/git-cal", as:command
zplug "peco/peco", as:command, from:gh-r
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf, \
	use:"*${(L)$(uname -s)}*amd64*"
zplug "junegunn/fzf", use:"shell/*.zsh", as:plugin

# Enhanced dir list with git features
zplug "supercrabtree/k"

# Jump back to parent directory
zplug "tarrasch/zsh-bd"

# Simple zsh calculator
zplug "arzzen/calc.plugin.zsh"

# Directory colors
zplug "seebi/dircolors-solarized", ignore:"*", as:plugin

# Load theme
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

# Load zsh plugins
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/copydir", from:oh-my-zsh
zplug "plugins/copyfile", from:oh-my-zsh
zplug "plugins/cp", from:oh-my-zsh
zplug "plugins/dircycle", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/golang", from:oh-my-zsh
zplug "plugins/urltools", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh
zplug "lib/clipboard", from:oh-my-zsh
zplug "plugins/osx", from:oh-my-zsh
zplug "plugins/brew", from:oh-my-zsh, if:"(( $+commands[brew] ))"
zplug "plugins/macports", from:oh-my-zsh, if:"(( $+commands[port] ))"
zplug "plugins/git", from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "plugins/node", from:oh-my-zsh, if:"(( $+commands[node] ))"
zplug "plugins/npm", from:oh-my-zsh, if:"(( $+commands[npm] ))"
zplug "plugins/sudo", from:oh-my-zsh, if:"(( $+commands[sudo] ))"

# Third party plugins
zplug "djui/alias-tips"
zplug "code-stats/code-stats-zsh", from:gitlab
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
# zsh-syntax-highlighting must be loaded after executing compinit command
# and sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2

#########
# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE

# Allow changing directories without `cd`
setopt autocd

# Dont overwrite history
setopt append_history

# Also record time and duration of commands.
setopt extended_history

# Share history between multiple shells
setopt share_history

# Clear duplicates when trimming internal hist.
setopt hist_expire_dups_first

# Dont display duplicates during searches.
setopt hist_find_no_dups

# Ignore consecutive duplicates.
setopt hist_ignore_dups

# Remove superfluous blanks.
setopt hist_reduce_blanks

# Omit older commands in favor of newer ones.
setopt hist_save_no_dups

# Ignore commands that start with space.
setopt hist_ignore_space

##################
# Diverse settings
# Set editor preference to nvim if available.
if (( $+commands[nvim] )); then
	alias vim='() { $(whence -p nvim) $@ }'
else
	alias vim='() { $(whence -p vim) $@ }'
fi

# Generic command adaptations
alias grep='() { $(whence -p grep) --color=auto $@ }'
alias egrep='() { $(whence -p egrep) --color=auto $@ }'

##############
# Key Bindings

# Common CTRL bindings.
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^f" forward-word
bindkey "^b" backward-word
bindkey "^k" kill-line
bindkey "^d" delete-char
bindkey "^y" accept-and-hold
bindkey "^w" backward-kill-word
bindkey "^u" backward-kill-line
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^F" history-incremental-pattern-search-forward

# Do not require a space when attempting to tab-complete.
bindkey "^i" expand-or-complete-prefix

# Fixes for alt-backspace and arrows keys
bindkey '^[^?' backward-kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
#bindkey "^[[C" forward-word
#bindkey "^[[D" backward-word

# https://github.com/sickill/dotfiles/blob/master/.zsh.d/key-bindings.zsh
tcsh-backward-word () {
  local WORDCHARS="${WORDCHARS:s#./#}"
  zle emacs-backward-word
}
zle -N tcsh-backward-word
bindkey '\e[1;3D' tcsh-backward-word
bindkey '\e^[[D' tcsh-backward-word # tmux

tcsh-forward-word () {
  local WORDCHARS="${WORDCHARS:s#./#}"
  zle emacs-forward-word
}
zle -N tcsh-forward-word
bindkey '\e[1;3C' tcsh-forward-word
bindkey '\e^[[C' tcsh-backward-word # tmux

tcsh-backward-delete-word () {
  local WORDCHARS="${WORDCHARS:s#./#}"
  zle backward-delete-word
}
zle -N tcsh-backward-delete-word
bindkey "^[^?" tcsh-backward-delete-word # urxvt

#############
# Completions

zstyle ':completion:*' rehash true
#zstyle ':completion:*' verbose yes
#zstyle ':completion:*:descriptions' format '%B%d%b'
#zstyle ':completion:*:messages' format '%d'
#zstyle ':completion:*:warnings' format 'No matches for: %d'
#zstyle ':completion:*' group-name ''

# case-insensitive (all), partial-word and then substring completion
zstyle ":completion:*" matcher-list \
  "m:{a-zA-Z}={A-Za-z}" \
  "r:|[._-]=* r:|=*" \
  "l:|=* r:|=*"

zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}

#########
# Startup

# Load SSH and GPG agents via keychain.
setup_agents() {
  [[ $UID -eq 0 ]] && return

  if (( $+commands[keychain] )); then
	local -a ssh_keys gpg_keys
	for i in ~/.ssh/**/*pub; do test -f "$i(.N:r)" && ssh_keys+=("$i(.N:r)"); done
	gpg_keys=$(gpg -K --with-colons 2>/dev/null | awk -F : '$1 == "sec" { print $5 }')
    if (( $#ssh_keys > 0 )) || (( $#gpg_keys > 0 )); then
	  alias run_agents='() { $(whence -p keychain) --quiet --eval --inherit any-once --agents ssh,gpg $ssh_keys ${(f)gpg_keys} }'
	  #[[ -t ${fd:-0} || -p /dev/stdin ]] && eval `run_agents`
	  unalias run_agents
    fi
  fi
}

setup_agents
unfunction setup_agents

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

if zplug check "seebi/dircolors-solarized"; then
  which gdircolors &> /dev/null && alias dircolors='() { $(whence -p gdircolors) }'
  which dircolors &> /dev/null && \
	  eval $(dircolors ~/.zplug/repos/seebi/dircolors-solarized/dircolors.256dark)
fi

if zplug check "zsh-users/zsh-syntax-highlighting"; then
	#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor line)
	ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

	typeset -A ZSH_HIGHLIGHT_STYLES
	ZSH_HIGHLIGHT_STYLES[cursor]='bg=yellow'
	ZSH_HIGHLIGHT_STYLES[globbing]='none'
	ZSH_HIGHLIGHT_STYLES[path]='fg=white'
	ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=grey'
	ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
	ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan'
	ZSH_HIGHLIGHT_STYLES[function]='fg=cyan'
	ZSH_HIGHLIGHT_STYLES[command]='fg=green'
	ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'
	ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'
	ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=yellow'
	ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta'
	ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=cyan,bold'
	ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=green,bold'
	ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=magenta,bold'
	ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow,bold'
fi

if zplug check "b4b4r07/enhancd"; then
  ENHANCD_DOT_SHOW_FULLPATH=1
	ENHANCD_DISABLE_HOME=0
fi

if zplug check "bhilburn/powerlevel9k"; then
  # Load Nerd Fonts with Powerlevel9k theme for Zsh
  POWERLEVEL9K_MODE='nerdfont-complete'
  # Customise the Powerlevel9k prompts
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    os_icon
    battery
    # ram
    # load
    # newline
    ssh
    dir
    dir_writable
    vcs
  )
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status
    command_execution_time
    # custom_vuejs
    go_version
    php_version
    node_version
    nvm
    custom_wifi_signal
  )
  POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
  POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='$ '
  POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
  POWERLEVEL9K_PROMPT_ON_NEWLINE=true
  POWERLEVEL9K_WHITESPACE_BETWEEN_LEFT_SEGMENTS=' '

  # DIR
  POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND=$COLOR_NONE
  POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND=$COLOR_RED

  # Wifi signal
  POWERLEVEL9K_CUSTOM_WIFI_SIGNAL='custom_wifi_signal'
  POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND=$COLOR_DARKGREY
  custom_wifi_signal(){
    local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I)
    local airport=$(echo $output | grep 'AirPort' | awk -F': ' '{print $2}')

    if [ "$airport" = "Off" ]; then
      local color="%F{grey58}"
      echo -n "%{$color%}Wifi Off \ufaa9"
    else
      local ssid=$(echo $output | grep ' SSID' | awk -F': ' '{print $2}')
      local speed=$(echo $output | grep 'lastTxRate' | awk -F': ' '{print $2}')
      local color="%F{grey58}"

      [[ $speed -gt 100 ]] && color='%F{green}'
      [[ $speed -lt 50 ]] && color='%F{red}'

      echo -n "%{$color%}$speed Mbps \ufaa8"
    fi
  }

  # Status
  POWERLEVEL9K_STATUS_OK_BACKGROUND=$COLOR_BLACK
  POWERLEVEL9K_STATUS_OK_FOREGROUND=$COLOR_GREEN
  POWERLEVEL9K_STATUS_ERROR_BACKGROUND=$COLOR_BLACK
  POWERLEVEL9K_STATUS_ERROR_FOREGROUND=$COLOR_RED

  # Execution time
  POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
  POWERLEVEL9K_TIME_BACKGROUND=$COLOR_BLACK
  POWERLEVEL9K_COMMAND_TIME_FOREGROUND=$COLOR_DEFAULT
  POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=$COLOR_BLACK
  POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$COLOR_DEFAULT

  # RAM
  POWERLEVEL9K_RAM_ICON=$'\uf799'
  POWERLEVEL9K_RAM_BACKGROUND=$COLOR_NONE
  POWERLEVEL9K_RAM_FOREGROUND=$COLOR_DEFAULT

  # Battery info
  POWERLEVEL9K_BATTERY_LOW_BACKGROUND=$COLOR_BLACK
  POWERLEVEL9K_BATTERY_LOW_FOREGROUND=$COLOR_RED
  POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND=$COLOR_BLACK
  POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND=$COLOR_GREEN
  POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND=$COLOR_BLACK
  POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND=$COLOR_GREEN
  POWERLEVEL9K_BATTERY_DISCONNECTED_BACKGROUND=$COLOR_BLACK
  POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND=$COLOR_YELLOW
  POWERLEVEL9K_BATTERY_LOW_THRESHOLD=15
  POWERLEVEL9K_BATTERY_VERBOSE=false
  POWERLEVEL9K_BATTERY_STAGES=($'\uf244 ' $'\uf243 ' $'\uf242 ' $'\uf241 ' $'\uf240 ')

  # Dir settings
  POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
  POWERLEVEL9K_SHORTEN_STRATEGY='Default'

  # VCS
  POWERLEVEL9K_VCS_GIT_GITHUB_ICON=$'\uf09b'
  POWERLEVEL9K_VCS_GIT_GITLAB_ICON=$'\uf296'
  POWERLEVEL9K_VCS_GIT_ICON=$'\ue702'
  POWERLEVEL9K_VCS_BRANCH_ICON=''
  POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$COLOR_BLACK
  POWERLEVEL9K_VCS_CLEAN_BACKGROUND='springgreen4'
  POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$COLOR_BLACK
  POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='203'
  POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$COLOR_BLACK
  POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='179'
  POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-remotebranch git-tagname)

  # Create a custom VueJS prompt section
  # POWERLEVEL9K_CUSTOM_VUEJS="echo -n '\ufd42' VueJS"
  # POWERLEVEL9K_CUSTOM_VUEJS_FOREGROUND=$COLOR_BLACK
  # POWERLEVEL9K_CUSTOM_VUEJS_BACKGROUND=$COLOR_GREY

  # GO version
  POWERLEVEL9K_GO_VERSION_FOREGROUND=$COLOR_BLACK
  POWERLEVEL9K_GO_VERSION_BACKGROUND=$COLOR_GREY

  # PHP version
  POWERLEVEL9K_PHP_VERSION_FOREGROUND=$COLOR_BLACK
  POWERLEVEL9K_PHP_VERSION_BACKGROUND=$COLOR_GREY

  # NVM
  POWERLEVEL9K_NVM_FOREGROUND=$COLOR_GREY
  POWERLEVEL9K_NVM_BACKGROUND=$COLOR_GREY
fi

# Then, source plugins and add commands to $PATH
zplug load

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# Source defined functions.
[[ -f ~/.zsh_functions ]] && source ~/.zsh_functions

# Source local customizations.
[[ -f ~/.zsh_rclocal ]] && source ~/.zsh_rclocal

# Source exports and aliases.
[[ -f ~/.zsh_exports ]] && source ~/.zsh_exports
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

#######
# Paths
export GOPATH=$HOME/Projects/personal/Go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin


#ZLE_RPROMPT_INDENT=0

# vim: ft=zsh