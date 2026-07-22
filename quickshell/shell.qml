import Quickshell
import Quickshell.Wayland
import QtQuick
import "root:/"
import "root:/views/"

ShellRoot {
    id: root
    property real shellOpacity: 0.85

    TopBar {
        opacity: root.shellOpacity
    }

    Loader {
        id: quicksettingsLoader
        property var closed: true
        active: PpStates.showQuickSettings || !closed
        source: "./views/Quicksettings.qml"
        onActiveChanged: setSource(source, {
            loader: quicksettingsLoader,
            opacity: root.shellOpacity,
        })
        onLoaded: {
            closed = false
        }

        Connections { target: PpStates; function onShowQuickSettingsChanged() {
            if (!PpStates.showQuickSettings) quicksettingsLoader.item?.close()
        } }
    }
}
