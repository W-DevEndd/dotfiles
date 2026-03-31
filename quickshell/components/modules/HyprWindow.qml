import "../base/"
import QtQuick
import Quickshell.Hyprland

BaseLabel {
    text: Hyprland.activeToplevel && Hyprland.activeToplevel.title? Hyprland.activeToplevel.title : "Hyprland"
    wrapMode: Text.NoWrap
    clip: true
    elide: Text.ElideLeft

    // Connections {
    //     target: Hyprland
    //     function onRawEvent(event) {
    //         var name = event.name
    //         var data = event.data
    //
    //         if (name == "activewindowv2") {
    //             print("Hello, World")
    //             print(Hyprland.activeToplevel.title)
    //             print(Hyprland.activeToplevel)
    //         }
    //     }
    // }
}
