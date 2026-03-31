import Quickshell
import QtQuick
import QtQuick.Layouts
import "./components/base"
import "./components/modules"

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }
    color: "transparent"
    aboveWindows: false
    implicitHeight: 42

    Item {
        anchors.centerIn: parent
        height: parent.height - 10
        width: parent.width - 10

        Row {
            height: parent.height
            width: childrenRect.width
            anchors.left: parent.left
            spacing: 0
            ModulesGroupBg {
                height: parent.height
                width: childrenRect.width

                // RowLayout {
                //     id: hyprwindows_layout
                //     anchors.centerIn: parent
                //     height: parent.height
                //     // width: childrenRect.width
                //     HyprWindow {
                //         // Layout.preferredWidth: contentWidth
                //         Layout.maximumWidth: 300
                //     }
                // }
                HyprWorkspaces {
                    height: parent.height
                }
            }
        }

        Row {
            height: parent.height
            width: childrenRect.width
            anchors.centerIn: parent

            Text { text: "aaa"}
        }

        Row {
            height: parent.height
            width: childrenRect.width
            anchors.right: parent.right

            ModulesGroupBg {
                height:parent.height
                width: datetime.implicitWidth + 10
                DateTime {
                    id: datetime
                    anchors.centerIn: parent
                }
            }
        }
    }
}
