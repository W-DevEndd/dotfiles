
export PS1="  \w  "
export PATH="$PATH:$HOME/.local/bin"
export QT_QPA_PLATFORMTHEME="qt6ct"

export DISPLAY=:1
alias tx11="termux-x11 $DISPLAY $@"
alias tcp="tx11 -listen tcp"
