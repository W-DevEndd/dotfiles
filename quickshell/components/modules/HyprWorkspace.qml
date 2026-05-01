import QtQuick
import Quickshell.Hyprland
import "../base/"
Row {
    spacing: 5
    // width: childrenRect.width

    Repeater {
        model: Hyprland.workspaces

        Item {
            height: parent.height
            width: height
            Label {
                anchors.centerIn: parent
                text: modelData.id
            }
        }
    }
}
