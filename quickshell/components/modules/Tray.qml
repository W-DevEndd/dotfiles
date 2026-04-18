import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import QtQuick.Controls
import Quickshell
import "../base/"

Row {
    spacing: 5

    Repeater {
        model: SystemTray.items
        delegate: Rectangle {
            clip: true
            height: parent.height
            width: height
            Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }
            color: hoverHandler.hovered ? Theme.overlay2 : "transparent"

            HoverHandler{ id: hoverHandler }
            Image {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 2
                }
                source: modelData.icon
                height: parent.height - 4
                width: height
            }
            // Label {
            //     id: appNameText
            //     text: modelData.title
            //     anchors{
            //         left: parent.left
            //         leftMargin: height + 5
            //         verticalCenter: parent.verticalCenter
            //     }
            // }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: modelData.activate()
            }
        }
    }
}
