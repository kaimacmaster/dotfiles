if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nvim'
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/mysql-client@8.0/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/kaimacmaster/Library/Application Support/Herd/config/php/83/"

# Herd injected PHP binary.
export PATH="/Users/kaimacmaster/Library/Application Support/Herd/bin/":$PATH

# Aliases
alias ll='ls -alF'
alias yd='nvm use && yarn dev'
alias yid='nvm use && yarn && yarn dev'
alias nv='nvim'
