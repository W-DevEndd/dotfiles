import Quickshell
import Quickshell.Wayland
import QtQuick
import "root:/"
import "root:/views/"

ShellRoot {
    id: root
    property int windowGaps: 6
    property int windowRouding: 12

    property real shellOpacity: 0.85

    TopBar {
        opacity: root.shellOpacity
    }

    Loader {
        id: quicksettingsLoader
        property real componentAlpha: Number(PpStates.showQuickSettings)
        Behavior on componentAlpha { NumberAnimation { duration: 400; easing.type: Easing.OutExpo } }
        active: componentAlpha !== 0
        Component.onCompleted: setSource("./views/Quicksettings.qml", {
            radius: root.windowRouding,
            gaps: root.windowGaps,
            opacity: Qt.binding(function() { return quicksettingsLoader.componentAlpha * root.shellOpacity }),
            focusable: Qt.binding(function () { return PpStates.showQuickSettings }),
        })
        onLoaded: {
            item.anchors.top = true
            item.anchors.right = true
            item.margins.right = Qt.binding(function() {
                return (1.0 - quicksettingsLoader.componentAlpha) * (-100)
            })
        }
    }
}
