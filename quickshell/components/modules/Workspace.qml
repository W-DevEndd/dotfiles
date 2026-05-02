import QtQuick
import Quickshell.Hyprland
import "../base/"
import "../states/"

Item {
    id: root
    ModulePanel {
        id: checker
        property int firstEmpty: 100
        property int forcused: Hyprland.focusedWorkspace.id
        height: root.height
        width: height
        anchors.verticalCenter: root.verticalCenter
        border.width: 0

        color: Theme.pink
        radius: 5

        x: forcused <= 4 ? (wsRow.height + wsRow.spacing) * (forcused - 1) : 0
        Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutBack }}
    }

    Row {
        id: wsRow
        spacing: 5
        width: childrenRect.width
        Behavior on width { NumberAnimation { duration: 400; easing.type: Easing.OutBack }}
        height: childrenRect.height
        anchors.verticalCenter: parent.verticalCenter
        clip: true

        Repeater {
            model: 10

            Item {
                property int workspaceId: modelData + 1
                property var workspace: HyprWorkspace.getById(workspaceId)

                visible: workspaceId <= 4 || workspace != undefined
                height: root.height
                width: visible ? height : 0
                Label {
                    text: modelData + 1
                    color: !parent.workspace ? Theme.overlay2 :
                        parent.workspace.active ? Theme.crust : Theme.text
                    Behavior on color { ColorAnimation { duration: 400; easing: Easing.OutExpo }}
                    anchors.centerIn: parent
                }
            }
        }
    }
}
