import Quickshell
import "./views/"
import "./commons/"
import "./vars/"

ShellRoot {
    id: root

    TopBar {}
    PowerPopup {
        isVisible: PopupStates.showPowerPopup
    }
    SystemPopup { isVisible: PopupStates.showSystemPopup }
}
