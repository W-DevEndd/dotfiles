import Quickshell
import "root:/views/"

ShellRoot {
    id: root
    property real barOpacity: 0.85
    TopBar {
        opacity: root.barOpacity
    }
}
