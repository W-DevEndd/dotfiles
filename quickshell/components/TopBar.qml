import Quickshell
import QtQuick
import "./base/"
import "./modules/"

PanelWindow {
    anchors {
        top: true
        right: true
        left: true
    } 
    implicitHeight: 44
    aboveWindows: false
    // color: Theme.base
    color: "transparent"

    Row {
        height: parent.height - 10
        width: childrenRect.width
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: 5
        }
        spacing: 10

        ModulePanel {
            height: parent.height
            width: childrenRect.width + 20

            HyprWorkspace {
                height: parent.height - 20
                width: childrenRect.width
                anchors {
                    centerIn: parent
                }
            }
        }
    }

    Row {
        height: parent.height - 10
        width: childrenRect.width
        anchors.centerIn: parent
        spacing: 10
    }
    
    Row {
        height: parent.height - 10
        width: childrenRect.width
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: 5
        }
        spacing: 10

        ModulePanel {
            height: parent.height
            width: childrenRect.width + 15

            Tray {
                anchors.centerIn: parent
                height: parent.height - 10
                width: childrenRect.width
            }
        }
        ModulePanel {
            height: parent.height
            width: childrenRect.width + 15

            DateTime {
                anchors.centerIn: parent
            }
        }
    }
}
