import QtQuick
import Quickshell.Hyprland
import "../base/"
Row {
    spacing: 10
    // width: childrenRect.width

    Repeater {
        model: Hyprland.workspaces
        delegate: Rectangle {
            color: modelData.active ?  Theme.blue : Theme.overlay0
            radius: 20
            height: parent.height - parent.padding
            width: modelData.active ? 44 : height
            Behavior on width { NumberAnimation { duration: 400; easing.type: Easing.OutBack } }
            Behavior on color { ColorAnimation { duration: 400 }}
            MouseArea {
                width: parent.width
                height: parent.height
                onClicked: { modelData.activate() }
            }
        }
    }
}
