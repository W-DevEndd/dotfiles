import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: root
    WlrLayershell.layer: WlrLayer.Background
    color: "transparent"
    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }
    Image {
        anchors.fill: parent
        asynchronous: false
        cache: false

        anchors.centerIn: parent
        sourceSize.width: width
        sourceSize.height: height
        source: "/home/w-devendd/.wallpaper/wallpaperflare.com_wallpaper.jpg"
    }
}
