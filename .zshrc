# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# autoload -Uz compinit; compinit

# ZVM_INIT_MODE=sourcing
plugins=(
  git
  fzf
  fzf-tab
  zsh-autosuggestions
  zsh-syntax-highlighting
  ohmyzsh-full-autoupdate
)

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else batcat -n --color=always {}; fi"
#
 # export FZF_CTRL_T_OPTS="--preview-window 'down:+{2}-5' --preview '$show_file_or_dir_preview'"
 # export FZF_ALT_C_OPTS="--preview-window 'down:+{2}-5' --preview 'eza --tree --color=always {} | head -200'"
# export FZF_DEFAULT_COMMAND='fd --type file --strip-cwd-prefix --hidden'
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#
# # Advanced customization of fzf options via _fzf_comprun function
# # - The first argument to the function is the name of the command.
# # - You should make sure to pass the rest of the arguments to fzf.
# _fzf_comprun() {
#   local command=$1
#   shift
#
#   case "$command" in
#     cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
#     export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
#     ssh)          fzf --preview 'dig {}'                   "$@" ;;
#     *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
#   esac
# }

# Setting fd as the default source for fzf
# FD_OPTS="--hidden --follow --exclude .git"
# export FZF_CTRL_T_COMMAND="fd --type f $FD_OPTS"
# export FZF_ALT_C_COMMAND="fd --type d $FD_OPTS"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
# export FZF_DEFAULT_OPTIONS="--preview-window down --height 50%"
export FZF_CTRL_R_OPTS="
  --preview 'echo {2..} | batcat --color=always -pl sh'
  --preview-window up:3:wrap
  --color header:italic"

# source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# # Append a command directly

# source $ZSH/oh-my-zsh.sh

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_COLLATE=C

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999

# zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
function my_init() {
  source ~/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit; compinit

setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt GLOB_DOTS
source $ZSH/oh-my-zsh.sh

export BAT_THEME=Coldark-Dark
alias ls="eza -l -a --group-directories-first --icons=always"
alias lst="eza -l -a --group-directories-first --total-size --icons=always"
alias cat="batcat --paging=never"
eval "$(zoxide init zsh)"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin:/home/val/.local/bin"
export RIPGREP_CONFIG_PATH="$HOME/.config/.ripgrep.rc" 
# export PATH="$PATH:/home/val/.local/bin"
export XDG_CONFIG_HOME=$HOME/.config/
alias nv="nvim"
alias lg="lazygit"
alias lzd="sudo /home/val/.local/bin/lazydocker"
alias docker="sudo docker"

eval "$(thefuck --alias fk)"

function sfg() {
  rg --line-number --no-heading --color=always --smart-case $1 | fzf -d ':' --bind='tab:accept,ctrl-w:toggle-preview-wrap,ctrl-p:toggle-preview,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up' --ansi --no-sort --preview-window 'down:+{2}-5' --preview 'batcat --style=numbers --color=always --highlight-line {2} {1}'
}

function go_test() {
  go test './'$1 -list . | sed -e '$ d' | fzf --cycle -m --bind ctrl-o:select-all | sed -z 's/\n/|/g;s/|$/\n/' | xargs -i go test $2 './'$1 -run '('{}')' 
}

 # disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:*' use-fzf-default-opts no
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
zstyle ':completion:*' fzf-search-display true
zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:*' fzf-min-height 20
# zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:complete:*:options' fzf-preview
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -l -a --group-directories-first --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:cd:*' fzf-flags --preview-window=down --height=50% 
zstyle ':fzf-tab:complete:*:*' fzf-flags --preview-window=down --height=50% 

zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
export LESSOPEN='| ~/.config/.lessfilter "%s"'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
# zstyle ':fzf-tab:*' fzf-flags --bind='tab:accept,ctrl-w:toggle-preview-wrap,ctrl-p:toggle-preview'
zstyle ':fzf-tab:*' fzf-bindings 'tab:accept' 'ctrl-w:toggle-preview-wrap' 'ctrl-p:toggle-preview' 'ctrl-d:preview-half-page-down' 'ctrl-u:preview-half-page-up'
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# zstyle ':fzf-tab:complete:ls:*' fzf-preview 'if [ -d $realpath ]; then eza --tree --color=always $realpath ; else batcat -n --color=always $realpath; fi'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

export LS_COLORS="$(vivid generate catppuccin-mocha)"

eval "$(starship init zsh)"

  # autoload -U compinit; compinit
#   [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#   source ~/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh
#
# source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  # autoload -U compinit; compinit

if ! [[ -v TMUX ]]; then
 	tmux new-session -A -s val
fi


