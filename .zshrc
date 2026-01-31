# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export DENO_INSTALL="/Users/atcodes/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export LOCALBIN_PATH="/Users/atcodes/.local/bin"
export GDPR_PATH="/Users/atcodes/dev/AlumnIQ/gdpr"
export NPM_GLOBALS="/Users/atcodes/.npm_globals/bin"
export MY_GLOBALS="/Users/atcodes/.bin"
export COMMANDBOX="/Users/atcodes/.bin/commandbox"
export IQ_GITHUB_PKG_WRITE_PAT="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"
export PATH="$GDPR_PATH:$NPM_GLOBALS:$MY_GLOBALS:$COMMANDBOX:$HOME/bin:/usr/local/bin:$LOCALBIN_PATH:$PATH"
export IQ_LOCALWEB_DEVELOPER_NAME="AdamTuttle"

#postgres 15
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/atcodes/.oh-my-zsh"
export IQ_DEV_HOME=~/DEV/AlumnIQ
export IQ_DEVELOPER=TUTTLE
# alias opiq=$IQ_DEV_HOME/~/DEV/AlumnIQiq_platform_devops/op/opiq.sh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

## begin git completion
# https://medium.com/@oliverspryn/adding-git-completion-to-zsh-60f3b0e7ffbc
#zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
#fpath=(~/.zsh $fpath)
#autoload -Uz compinit && compinit
## end git completion

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
zstyle ':omz:update' mode auto      # update automatically without asking
#zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

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
plugins=(git gitfast zsh-syntax-highlighting sudo node npm safe-paste)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

alias mcp-screenshot-on='claude mcp add screenshot -- node /Users/atcodes/DEV/mcp-screenshot/dist/index.js'
alias mcp-screenshot-off='claude mcp remove screenshot'

alias e="cursor"
alias cursor-agent="agent"
alias cl="claude"
alias cat="bat"
alias ls="exa"
alias ll="exa -al"
alias lg="lazygit"
alias ldo="lazydocker"
alias aero="cursor ~/.config/aerospace/aerospace.toml"

alias mysql="docker run -it --rm mysql bash"

alias zshrc='cursor ~/.zshrc'
alias zs='source ~/.zshrc'
alias dps='docker ps'
alias dc='docker compose'
alias ok2merge='labeloktomerge-prs'
alias usingport='lsof -nP -i4TCP:$1 | grep LISTEN'
# alias prune=''
# alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'

prune() {
    git pull --prune && git branch -vv | grep gone] | node -e "process.stdin.on('data', (data) => {data.toString().split('\n').map(line => { x = line.split(' ')[2]; if (x) console.log(x)})});" | xargs git branch -D
}

#git stuffs
alias gitt='git'
alias git='hub'
alias uu='git e | grep UU'
alias stpush="abort-if-stash-not-empty && git stash save && push && git stash pop"
alias cwd="pwd | pbcopy"
alias pushx="git branch | grep \* | cut -d ' ' -f2 | xargs git push -u origin"
alias push="git pull && git push"
alias pusht="push && push --tags"
alias pull="hub sync"
alias sha="git rev-parse HEAD | cut -c1-8 | tr -d '\n' | pbcopy"
alias merge="git merge --no-edit"
alias mergenc="git merge --no-commit"
alias cherry="git cherry-pick"
alias main="git checkout main"
alias master="git checkout master"
alias gs="clear && git st"
alias conflicts="git diff --name-only | uniq | grep -v '\.min\.' | grep -v 'cache-admin.md5' | grep -v 'cache-pubsite.md5' | xargs code"
alias cleaned="git diff --name-only | uniq | xargs git add && git status -sb"
alias update="npx npm-check --update"
alias co='git checkout'

#for use when both package.json and package-lock.json get conflicted at the same time
alias fpl="rm -f package-lock.json && npm install --package-lock-only"

# AlumnIQ git stuff
alias ud="git checkout main-ud"
alias swat="git checkout main-swat"
alias umd="git checkout main-umd"
alias lawr="git checkout main-lawr"
alias sto="git checkout main-sto"
alias van="git checkout main-vanderbilt"
alias cua="git checkout main-cua"
alias aub="git checkout main-auburn"
alias cwru="git checkout main-cwru"
alias ualberta="git checkout main-ualberta"
alias wwu="git checkout main-wwu"
alias customers="echo 'AUBURN,CARLETON,CUA,CWRU,IQ,LAWR,STO,SWAT,UALBERTA,UD,UMD,UNF,VANDERBILT,WWU'"

alias pullall="hub sync"
alias updateqamain="main && git pull && git checkout QA && git pull && merge main --no-edit && git push"
alias updateqaud="ud && git pull && git checkout main-ud-qa && git pull && merge main-ud --no-edit && git push"
alias updateqaswat="swat && git pull && git checkout main-swat-qa && git pull && merge main-swat --no-edit && git push"
alias updateqaumd="umd && git pull && git checkout main-umd-qa && git pull && merge main-umd --no-edit && git push"
alias updateqalawr="lawr && git pull && git checkout main-lawr-qa && git pull && merge main-lawr --no-edit && git push"
alias updateqavan="van && git pull && git checkout main-vanderbilt-qa && git pull && merge main-vanderbilt --no-edit && git push"
alias updateqacua="cua && git pull && git checkout main-cua-qa && git pull && merge main-cua --no-edit && git push"
alias updateqacwru="cwru && git pull && git checkout main-cwru-qa && git pull && merge main-cwru --no-edit && git push"
alias updateqawwu="wwu && git pull && git checkout main-wwu-qa && git pull && merge main-wwu --no-edit && git push"
alias updateqa="updateqamain && updateqaud && updateqaswat && updateqaumd && updateqalawr && updateqavan"

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

## BEGIN: cache ssh keyphrase
env=~/.ssh/agent.env
agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }
agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }
agent_load_env
# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi
unset env
## END: cache ssh keyphrase

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## IQ localweb docker compose uses this for aws credentials
export HOMEDIR=$HOME


## Enables mcfly: https://github.com/cantino/mcfly
# eval "$(mcfly init zsh)"

## Enable Zoxide (alternative to z): https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

## Enable fzf: https://github.com/junegunn/fzf
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## https://github.com/marlonrichert/zsh-autocomplete
# source /Users/atcodes/.bin/zsh-autocomplete/zsh-autocomplete.plugin.zsh

## git diff cli provided by delta: https://github.com/dandavison/delta

# setup github copilot cli commands
eval "$(github-copilot-cli alias -- "$0")"

# bun completions
[ -s "/Users/atcodes/.bun/_bun" ] && source "/Users/atcodes/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/atcodes/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# opencode
export PATH=/Users/atcodes/.opencode/bin:$PATH
