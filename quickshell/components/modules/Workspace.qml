import QtQuick
import Quickshell.Hyprland
import "../base/"
import "../states/"

Item {
    id: root
    ModulePanel {
        id: checker
        property int firstEmpty: 100
        property int forcused: 1
        height: root.height
        width: height
        anchors.verticalCenter: root.verticalCenter
        border.width: 0

        color: Theme.pink
        radius: 5

        x: (root.height + wsRow.spacing) * (HyprWorkspace.getIndexById(forcused) + (root.forcused > 4 ? root.firstEmpty : 0))
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
                property var workspace: HyprWorkspace.getById(modelData + 1)
                height: root.height
                width: height
                Label {
                    text: modelData + 1
                    color: !parent.workspace ? Theme.overlay2 :
                        parent.workspace.active ? Theme.crust : Theme.text
                    Behavior on color { ColorAnimation { duration: 400; easing: Easing.OutExpo }}
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
                    color: modelData.active ? Theme.crust : Theme.text
                    Behavior on color { ColorAnimation { duration: 400; easing: Easing.OutExpo }}
                    anchors.centerIn: parent
                }
            }
        }
    }
}
