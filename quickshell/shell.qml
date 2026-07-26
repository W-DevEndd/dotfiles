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
        id: topbar
        opacity: root.shellOpacity
        cornerSize: root.windowRouding + root.windowGaps
        aboveWindows: true
    }

    PanelWindow {
        id: popupPanel

        WlrLayershell.layer: WlrLayer.Overlay
        focusable: PpStates.showQuickSettings
        visible: quicksettingsLoader.openProgress

        color.a: 0.0

        implicitWidth: 333

        exclusionMode: ExclusionMode.Normal
        anchors {
            top: true
            right: true
            left: true
            bottom: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: popupPanel.closeAll()
        }
        Shortcut {
            sequence: "Escape"
            onActivated: popupPanel.closeAll()
        }

        function closeAll() {
            PpStates.showQuickSettings = false
        }

        Loader {
            id: quicksettingsLoader
            property real openProgress: Number(PpStates.showQuickSettings)
            Behavior on openProgress { NumberAnimation { duration: 400; easing.type: Easing.OutExpo } }

            opacity: openProgress * root.shellOpacity
            anchors {
                top: parent.top
                topMargin: root.windowGaps
                right: parent.right
                rightMargin: root.windowGaps - (100 * (1.0 - openProgress))
            }

            active: openProgress !== 0
            Component.onCompleted: setSource("./views/Quicksettings.qml", { radius: root.windowRouding })
        }
    }
}
