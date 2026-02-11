# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export USRLOCALBIN_PATH="/usr/local/bin"
export LOCALBIN_PATH="/Users/atcodes/.local/bin"
export GDPR_PATH="/Users/atcodes/dev/AlumnIQ/gdpr"
export NPM_GLOBALS="/Users/atcodes/.npm_globals/bin"
export MY_GLOBALS="/Users/atcodes/.bin"
export PATH="$PATH:$HOME/.opencode/bin"
export PATH="$GDPR_PATH:$NPM_GLOBALS:$MY_GLOBALS:$USRLOCALBIN_PATH:$LOCALBIN_PATH:$PATH"
export PATH="$PATH:/opt/homebrew/opt/postgresql@15/bin" #postgres 15

# Path to your oh-my-zsh installation.
export ZSH="/Users/atcodes/.oh-my-zsh"
export IQ_DEV_HOME=$HOME/DEV/AlumnIQ
export IQ_DEVELOPER=TUTTLE
export IQ_LOCALWEB_DEVELOPER_NAME="AdamTuttle"
## IQ localweb docker compose uses this for aws credentials
export HOMEDIR=$HOME

# Use 1password SSH Agent
export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
#zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git gitfast zsh-syntax-highlighting brew sudo node npm safe-paste)

source $ZSH/oh-my-zsh.sh

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

alias zshrc='cursor $HOME/.zshrc' #edit this file
alias zs='source $HOME/.zshrc'    #reload this file

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias lgdot='lazygit --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'

alias rm="trash"
alias e="cursor"
alias cc="claude"
alias cat="bat"
alias ls="exa"
alias ll="exa -al"
alias lg="lazygit"
alias ldo="lazydocker"
alias mysql="docker run -it --rm mysql bash"
alias dps='docker ps'
alias dc='docker compose'
alias ok2merge='labeloktomerge-prs'
alias usingport='lsof -nP -i4TCP:$1 | grep LISTEN'

alias mcp-screenshot-on='claude mcp add screenshot -- node /Users/atcodes/DEV/mcp-screenshot/dist/index.js'
alias mcp-screenshot-off='claude mcp remove screenshot'

#git stuffs
alias uu='git status -sb | grep UU'
alias stpush="abort-if-stash-not-empty && git stash save && push && git stash pop"
alias cwd="pwd | pbcopy"
alias pushx="git branch | grep \* | cut -d ' ' -f2 | xargs git push -u origin"
alias push="git pull && git push"
alias pusht="git push && git push --tags"
alias pull="git pull"
alias merge="git merge"
alias sha="git rev-parse HEAD | cut -c1-8 | tr -d '\n' | pbcopy"
alias cherry="git cherry-pick"
alias main="git checkout main"
alias conflicts="git diff --name-only | uniq | grep -v '\.min\.' | grep -v 'cache-admin.md5' | grep -v 'cache-pubsite.md5' | xargs code"
alias cleaned="git diff --name-only | uniq | xargs git add && git status -sb"
alias update="npx npm-check --update"
alias co='git checkout'
prune() {
	git pull --prune && git branch -vv | grep gone] | node -e "process.stdin.on('data', (data) => {data.toString().split('\n').map(line => { x = line.split(' ')[2]; if (x) console.log(x)})});" | xargs git branch -D
}

# fpl ("fix package lock") for use when both package.json and package-lock.json get conflicted at the same time
alias fpl="rm -f package-lock.json && npm install --package-lock-only"

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

## Enable Zoxide (alternative to z): https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

## Enable fzf: https://github.com/junegunn/fzf
# [ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

## https://github.com/marlonrichert/zsh-autocomplete
# source $HOME/.bin/zsh-autocomplete/zsh-autocomplete.plugin.zsh

## TODO: document adding this to lazygit?
## git diff cli provided by delta: https://github.com/dandavison/delta

# setup github copilot cli commands
# eval "$(github-copilot-cli alias -- "$0")"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# running with certain 1password secrets available as ENV vars
opat() {
	op run --account my.1password.com --env-file="$HOME/.config/op/personal.env" -- "$@"
}
# load all env vars from personal.env into the current session (allows skip opat before commands)
opatsession() {
	while IFS='=' read -r key ref; do
		[[ -z "$key" || "$key" =~ ^# ]] && continue
		export "$key"="$(op read "$ref" --account my.1password.com)"
	done < "$HOME/.config/op/personal.env"
}

# opencode
export PATH=/Users/atcodes/.opencode/bin:$PATH
