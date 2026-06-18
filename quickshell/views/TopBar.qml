import Quickshell
import QtQuick
import "root:/"
import "root:/commons"
import "root:/modules"

PanelWindow {
    id: root

    property real opacity: 1.0
    property int padding: 4

    aboveWindows: false
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 36
    color: "transparent"

    Rectangle {
        id: bg;
        width: root.width
        height: root.height
        color: Catppuccin.base
        opacity: root.opacity
    }

    Item {
        id: content;
        width: root.width - root.padding * 2
        height: root.height - root.padding * 2
        x: root.padding
        y: root.padding

        opacity: root.opacity

        Row {
            id: leftModules
            anchors.left: content.left
            height: content.height

            spacing: 5

            HyprWorkspace { height: parent.height }
        }

        Row {
            id: middleModules
            anchors.horizontalCenter: content.horizontalCenter
            height: content.height

            spacing: 5
        }

        Row {
            id: rightModules
            anchors.right: content.right
            height: content.height

            spacing: 5

            Tray { height: parent.height }
            DateTime { height: parent.height }
            Menu { height: parent.height }
        }
    }
}
