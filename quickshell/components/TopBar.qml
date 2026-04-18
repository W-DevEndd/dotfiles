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
            property real padding: 20
            height: parent.height
            width: childrenRect.width + padding

            HyprWorkspace {
                height: parent.height - 20
                width: childrenRect.width
                x: parent.padding / 2
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Row {
        height: parent.height - 10
        width: childrenRect.width
        anchors.centerIn: parent
        spacing: 10

        ModulePanel {
            property real padding: 15
            height: parent.height
            width: childrenRect.width + padding

            Row {
                x: parent.padding / 2
                anchors.verticalCenter: parent.verticalCenter
                height: childrenRect.height
                width: childrenRect.width
                spacing: 10

                Cpu {}
                Mem {}
                Battery {}
            }
        }
    }
    
    Row {
        height: parent.height - 10
        width: childrenRect.width
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: 5
        }
        spacing: 5

        ModulePanel {
            property real padding: 10
            height: parent.height
            width: childrenRect.width + padding

            Tray {
                x: parent.padding / 2
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height - 10
                width: childrenRect.width
            }
        }
        ModulePanel {
            property int padding: 10
            height: parent.height
            width: childrenRect.width + padding

            DateTime {
                x: parent.padding / 2
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        ModulePanel {
            property real padding: 15
            height: parent.height
            width: childrenRect.width + padding

            Row {
                x: parent.padding / 2
                anchors.verticalCenter: parent.verticalCenter
                height: childrenRect.height
                width: childrenRect.width
                spacing: 10

                Volume {}
                Mic {}
            }
        }
    }
}
