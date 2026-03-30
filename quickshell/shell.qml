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
                width: childrenRect.width + 10

                RowLayout {
                    anchors.centerIn: parent
                    height: parent.height
                    width: childrenRect.width
                    HyprWindow {
                        // Layout.preferredWidth: contentWidth
                        Layout.maximumWidth: 300
                    }
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
                width: childrenRect.width + 10
                DateTime {
                    anchors.centerIn: parent
                }
            }
        }
    }
}
