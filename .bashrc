
# Xorg
export DISPLAY=:1
export QT_QPA_PLATFORMTHEME="qt6ct"

# Bash
export PS1="  \w  "
export PATH="$PATH:$HOME/.local/bin"
if [ -f $PREFIX/etc/profile.d/bash_completion.sh ]; then
    $PREFIX/etc/profile.d/bash_completion.sh
fi

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

