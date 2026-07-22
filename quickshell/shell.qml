import Quickshell
import Quickshell.Wayland
import "root:/views/"

ShellRoot {
    id: root
    property real shellOpacity: 0.85

    TopBar {
        opacity: root.shellOpacity
    }
}
