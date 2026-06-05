import QtQuick
import Quickshell.Hyprland
import QtQuick
import "../commons/"
import "../vars/"

Item {
    id: root

    property int indicatorMargin: 4
    property int focusedWorkspaceId: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 1;
    width: numbers.width

    // Primary Indicator
    Rectangle {
        color: Styles.textColor
        height: root.height - root.indicatorMargin
        width: height
        radius: 5

        x: root.indicatorMargin / 2 + (root.focusedWorkspaceId - 1) * root.height
        Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutExpo }}

        anchors.verticalCenter: root.verticalCenter
    }
    // WorkspaceNumbers
    Row {
        id: numbers

        property var update: false
        Repeater {
            model: 10

            Item {
                id: it
                property int thisWorkspaceId: modelData + 1
                property var thisWorkspace: undefined
                Connections {
                    target: HyprWorkspace
                    function onUpdateChanged() {
                        it.thisWorkspace = HyprWorkspace.getById(thisWorkspaceId);
                        text.color = Qt.binding(() => { return it.thisWorkspace ? (
                            it.thisWorkspace.active ? Styles.textColor3 : Styles.textColor
                        ) : Styles.textColor2})
                    }
                }
                height: root.height
                width: height
                Label {
                    id: text
                    anchors.centerIn: parent
                    text: it.thisWorkspaceId
                    color: Styles.textColor2
                    Behavior on color { ColorAnimation { duration: 400; easing: Easing.OutExpo }}
                }
            }
        }

    }
}
