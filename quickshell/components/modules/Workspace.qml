import QtQuick
import Quickshell.Hyprland
import "../base/"
import "../states/"

Item {
    id: root

    property int defaultVisibleCount: 4

    width: wsRow.implicitWidth
    Behavior on width { NumberAnimation { duration: 400; easing.type: Easing.OutBack }}
    ModulePanel {
        id: indicator

        property int workspaceId: Hyprland.focusedWorkspace.id
        property int workspaceIndex: HyprWorkspace.getIndexById(workspaceId)
        property int emtyDefaultCount: 0

        height: root.height
        width: height
        anchors.verticalCenter: root.verticalCenter
        border.width: 0

        color: Theme.pink
        radius: 5

        x: (root.height + wsRow.spacing) * (indicator.workspaceId <= 4 ? (indicator.workspaceId - 1) : (indicator.workspaceIndex + indicator.emtyDefaultCount))
        Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutExpo } }
    }

    Row {
        id: wsRow
        spacing: 5
        Behavior on width { NumberAnimation { duration: 400; easing.type: Easing.OutBack }}
        anchors.verticalCenter: parent.verticalCenter
        // clip: true

        Repeater {
            model: 10

            Item {
                property int workspaceId: modelData + 1
                property var workspace: HyprWorkspace.getById(workspaceId)
                property var isOpened: workspace !== undefined

                visible: workspaceId <= root.defaultVisibleCount || isOpened
                height: root.height
                width: height
                Label {
                    text: modelData + 1
                    color: !parent.workspace ? Theme.overlay2 :
                        parent.workspace.active ? Theme.crust : Theme.text
                    Behavior on color { ColorAnimation { duration: 400; easing: Easing.OutExpo }}
                    anchors.centerIn: parent
                }

                onIsOpenedChanged: {
                    if (workspaceId <= root.defaultVisibleCount) {
                        if (isOpened) indicator.emtyDefaultCount--
                        else indicator.emtyDefaultCount++
                    }
                }
            }
        }
    }
}
