import Quickshell
import QtQuick

PanelWindow {
    id: root
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 36
    color: "transparent"

    Rectangle {
        id: bg
        width: root.width
        height: root.height
    }
}