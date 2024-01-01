# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export GLOBAL_PYTHON_VER="3.10.8"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$HOME/.poetry/bin:$HOME/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/ryan/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=powerlevel10k/powerlevel10k

plugins=(git z fzf zsh-completions zsh-syntax-highlighting docker docker-compose task)
zstyle ':completion:*:*:make:*' tag-order 'targets'
autoload -Uz compinit && compinit

# Source local zsh related stuff
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local
[[ ! -f ~/.zsh.plugin.local ]] || source ~/.zsh.plugin.local

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
alias vim=nvim

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Local aliases
[[ ! -f ~/.aliases.local ]] || source ~/.aliases.local

shutdown_now() {
  echo -n "Shutdown now?"
  read REPLY

  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo "Bye"
    sudo shutdown now
  fi
}

alias copy="xsel -b"
alias clc="git rev-parse HEAD | copy"  # Copy last commit hash
alias cwo=". ./start_env.sh"
alias gc-="git checkout -"
alias gcn="git commit --no-verify"
alias gcor='gco $(grecent | fzf)'
alias gma="git checkout master"
alias grecent="git for-each-ref --sort=-committerdate --count=20 --format='%(refname:short)' refs/heads/"
alias gsh="git show"
alias gtmp="git checkout tmp"
alias rbm='git rebase $(git_main_branch) -i'
alias rb="grbi @^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
alias rt="gb | grep rt."
alias watch="watch "  # Just to get alias working for the command to be watched (only the first alias epxands)
alias shut=shutdown_now
alias gs='git status'

if type "kubectl" &> /dev/null ; then
    source <(kubectl completion zsh)
    complete -F __start_kubectl kl
    alias kl="kubectl"
    export KUBECONFIG=~/.kube/config.d/default.config
fi

# Enable alias for `thefuck`
eval $(thefuck --alias)

# venv stuff
setup_virtualenv() {
    export VIRTUALENVWRAPPER_PYTHON=/home/ryan/.pyenv/versions/3.10.8/bin/python
    source /home/ryan/.pyenv/versions/${GLOBAL_PYTHON_VER}/bin/virtualenvwrapper.sh
}
setup_virtualenv

# pyenv stuff
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

export SSH_USER=ryan

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/usr/local/go/bin

