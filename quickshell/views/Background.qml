import Quickshell
import Quickshell.Wayland
import QtQuick
import "root:/"
import "root:/utils/"

PanelWindow {
    id: root
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
        cache: false
    }
    Connections {
        target: ShellStates
        function onCurrentWallpaperChanged() {
            wallpaper.source = Cache.cachedWallpaperPath(ShellStates.currentWallpaper)
            // console.log(Cache.cachedWallpaperPath(ShellStates.currentWallpaper))
        }
    }
}
