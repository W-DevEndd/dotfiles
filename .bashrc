#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export PS1="󰣇 \w  "
export PATH="$PATH:$HOME/.local/bin"

if [ -f /etc/profile.d/bash_completion.sh ]; then
    /etc/profile.d/bash_completion.sh
fi

git-commit ()
{
    git add .
    git commit -m "$@"
}

git-push ()
{
    git-commit "$@"
    git push
}

