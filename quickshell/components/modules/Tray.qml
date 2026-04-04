import QtQuick
import Quickshell.Services.SystemTray 
import "../base/"

Row {
    spacing: 5

    Repeater {
        model: SystemTray.items
        delegate: Rectangle {
            HoverHandler{ id: hoverHandler}
            height: parent.height
            width: height
            color: hoverHandler.hovered ? Theme.overlay2 : "transparent"
        }
    }
}
