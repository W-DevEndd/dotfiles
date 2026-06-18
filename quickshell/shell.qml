import Quickshell
import Quickshell.Wayland
import "root:/views/"

ShellRoot {
    id: root
    property real barOpacity: 0.85

    // States
    property var showMenuPopup: false
    TopBar {
        opacity: root.barOpacity
        // HyprlandWindow.opacity: root.barOpacity
    }

    MenuPopup { }
}
