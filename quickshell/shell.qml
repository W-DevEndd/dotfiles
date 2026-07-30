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
        focusable: PpStates.showPopup
        visible: quicksettingsLoader.openProgress || commandPaletteLoader.openProgress

        color.a: 0.0

        exclusionMode: TopLvl.isFullScreen ? ExclusionMode.Ignore : ExclusionMode.Normal
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
            PpStates.showCommandPalette = false
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

            active: openProgress !== 0.0
            Component.onCompleted: setSource("./views/Quicksettings.qml", { radius: root.windowRouding })
        }

        Loader {
            id: commandPaletteLoader
            property real openProgress: Number(PpStates.showCommandPalette)
            Behavior on openProgress { NumberAnimation { duration: 400; easing.type: Easing.OutExpo } }

            opacity: root.shellOpacity
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: -100 * (1.0 - openProgress)
            }

            active: openProgress !== 0.0
            Component.onCompleted: setSource("./views/CommandPalette.qml", {
                contentLoaderActive: Qt.binding(function() { return PpStates.showCommandPalette }),
                radius: root.windowRouding,
                handleClose: () => { PpStates.showCommandPalette = false },
            })
        }
    }

    // Background { }
}
