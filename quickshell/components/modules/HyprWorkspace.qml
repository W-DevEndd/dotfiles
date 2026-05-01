import QtQuick
import Quickshell.Hyprland
import "../base/"

Item {
    id: root
    ModulePanel {
        id: checker
        property int forcused: 1
        height: root.height
        width: height
        anchors.verticalCenter: root.verticalCenter
        border.width: 0

        color: Theme.overlay0
        radius: 5

        x: (root.height + wsRow.spacing) * (forcused - 1)
        Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutBack }}

        Instantiator {
            model: Hyprland.workspaces
            delegate: QtObject {
                property int id: modelData.id
                property var active: modelData.active
                onActiveChanged: {
                    if (active == true) checker.forcused = id
                }
            }
        }
    }

    Row {
        id: wsRow
        spacing: 5
        width: childrenRect.width
        height: childrenRect.height
        anchors.verticalCenter: parent.verticalCenter

        Repeater {
            model: 4

            Item {
                property var workspaces: Hyprland.workspaces.values[modelData]
                height: root.height
                width: height
                Label {
                    text: modelData + 1
                    color: parent.workspaces ? Theme.text : Theme.overlay2
                    anchors.centerIn: parent
                }
            }
        }
        Repeater {
            model: Hyprland.workspaces

            Item {
                visible: modelData.id > 4
                height: root.height
                width: height
                Label {
                    text: modelData.id
                    color: parent.workspaces ? Theme.text : Theme.overlay2
                    anchors.centerIn: parent
                }
            }
        }
    }
}
