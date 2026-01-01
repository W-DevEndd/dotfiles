
export PS1="  \w  "
export PATH="$PATH:$HOME/.local/bin"
export QT_QPA_PLATFORMTHEME="qt6ct"

export DISPLAY=:1
alias tx11="termux-x11 $DISPLAY $@"
alias tcp="tx11 -listen tcp"

xtrun()
{
    xfce4-terminal --hold -e "$@"
}

git-commit ()
{
    git add .
    git commit -m "$@"
}

git-push ()
{
    git-commit $@
    git push
}

# Stupid
#  est -z "$TMUX" && tmux attach || tmux new
