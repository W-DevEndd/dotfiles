import "../../"
import "../base/"
import QtQuick
import Quickshell.Hyprland

Row {
    spacing: 10
    padding: 10
    Repeater {
        model: Hyprland.workspaces
        Rectangle {
            height: parent.height - parent.padding * 2
            color: modelData.active ? Theme.blue : Theme.overlay2
            width: modelData.active ? 36 : height
            radius: 15

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log(modelData.activate())
                }
            }

            Behavior on width {
                NumberAnimation {
                    property: "width"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }

            // BaseLabel {
            //     width: parent.width
            //     height: parent.height
            //     font.pointSize: 6
            //     text: "aaaa"
            // }
        }
    }
}
