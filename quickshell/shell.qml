import Quickshell
import Quickshell.Wayland
import QtQuick
import "root:/"
import "root:/views/"
import "root:/utils/"

ShellRoot {
    id: root
    property int windowGaps: 6
    property int windowRouding: 12

    property real shellOpacity: 0.9

    // property var _test: QtObject {
    //     id: test
    //     property var p: null
    //     Component.onCompleted: {
    //         test.p = Cache.cacheWallpaper(Pathlibs.userResolve("~/.wallpapers/elaina.jpg"))
    //     }
    //     property var _timer: Timer {
    //         interval: 1000
    //         repeat: true
    //         running: true
    //         onTriggered: {
    //             console.log(JSON.stringify(test.p, null, 4))
    //         }
    //     }
    // }

    TopBar {
        id: topbar
        opacity: root.shellOpacity
        cornerSize: root.windowRouding + root.windowGaps
        aboveWindows: true
    }

    PanelWindow {
        id: popupPanel

        WlrLayershell.layer: WlrLayer.Overlay
        focusable: PpStates.focusPopup
        visible: quicksettingsLoader.openProgress || commandPaletteLoader.openProgress || osbLoader.openProgress

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
            onClicked: PpStates.handleCloseAll()
        }
        Shortcut {
            sequence: "Escape"
            onActivated: PpStates.handleCloseAll()
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

        OSB {
            id: osbLoader

            property var isReady: false

            property real openProgress: Number(PpStates.showOSB)
            Behavior on openProgress { NumberAnimation { duration: 400; easing.type: Easing.OutExpo } }

            opacity: root.shellOpacity * openProgress
            radius: root.windowRouding

            function handleShow(callback) {
                if (!osbLoader.isReady) return
                if (PpStates.showQuickSettings) return
                PpStates.showOSB = true
                autoHide.restart()
                callback()
            }

            Connections {
                target: SystemStates
                function onSinkVolumeChanged() { osbLoader.handleShow(() => {
                    osbLoader.loadSinkSlider()
                } ) }
            }

            anchors {
                bottomMargin: 64
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            Timer {
                id: autoHide
                interval: 500
                onTriggered: PpStates.showOSB = false
            }

            Timer { interval: 500; running: true; onTriggered: osbLoader.isReady = true }
        }
    }

    Background {}
}
