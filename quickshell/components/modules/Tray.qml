import QtQuick
import Quickshell.Services.SystemTray
import QtQuick.Controls
import Quickshell
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

            Image {
                source: modelData.icon
                height: parent.height - 4
                width: height
                anchors.centerIn: parent
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: modelData.activate()
                PopupWindow {
                    visible: hoverHandler.hovered
                    anchor.item: parent
                }
                focus: false
                
            }
        }
    }
}
