import Quickshell
import Quickshell.Wayland
import QtQuick
import "root:/"
import "root:/utils/"

PanelWindow {
    id: root

    readonly property int scrWidth:  Quickshell.screens[0].width
    readonly property int scrHeight: Quickshell.screens[0].height

    WlrLayershell.layer: WlrLayer.Background
    exclusionMode: ExclusionMode.Ignore

    color: "transparent"
    
    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }

    Image {
        id: wallpaper
        anchors.fill: parent
        sourceSize {
            width: root.scrWidth
            height: root.scrHeight
        }
        fillMode: Image.PreserveAspectCrop
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignVCenter
        smooth: true
        asynchronous: true
    }

    Connections {
        target: ShellStates
        function onCurrentWallpaperChanged() {
            wallpaper.source = ShellStates.currentWallpaper.path
        }
    }
}
