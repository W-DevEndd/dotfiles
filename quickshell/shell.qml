import Quickshell
import Quickshell.Wayland
import "root:/views/"

ShellRoot {
    id: root
    property real bgOpacity: 0.85

    TopBar {
        opacity: root.bgOpacity
        // HyprlandWindow.opacity: root.barOpacity
    }

    MenuPopup { opacity: root.bgOpacity }
}
