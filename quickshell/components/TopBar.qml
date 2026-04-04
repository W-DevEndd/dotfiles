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
    color: Theme.base
    // color: "transparent"

    Row {
        height: parent.height - 10
        width: childrenRect.width
        anchors.left: parent.left
        y: 5
        spacing: 10

        Item { height: parent.height; width: 1}
        ModulePanel {
            height: parent.height
            width: childrenRect.width + 10

            HyprWorkspace {
                height: parent.height - 20
                width: childrenRect.width + 10
                y: 10
                x: 10
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
        anchors.right: parent.right
        y: 5
        spacing: 10

        ModulePanel {
            height: parent.height
            width: childrenRect.width + 10

            Tray {
                height: parent.height - 10
                width: childrenRect.width + 6
                y: 5
                x: 5
            }
        }
        ModulePanel {
            height: parent.height
            width: childrenRect.width + 10

            DateTime {
                y: 5
                x: 5
            }
        }
        Item { height: parent.height; width: 1}
    }
}
