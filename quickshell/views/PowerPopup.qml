import Quickshell
import Quickshell.Wayland
import QtQuick
import "../commons/"
import "../vars/"

PanelWindow {
    id: root

    property var isVisible: false

    anchors {
        top: true
        right: true
    }
    margins {
        top: 5
        right: 5
    }
    implicitWidth: content.width
    implicitHeight: content.height

    exclusionMode: ExclusionMode.Normal
    exclusiveZone: 0

    color: "transparent"
    visible: root.isVisible

    Rectangle {
        id: bg
        color: Styles.bgColor
        opacity: (Number(root.isVisible) * Styles.bgAlpha)
        width: root.implicitWidth
        height: root.implicitHeight
        radius: Styles.cornerRadius1

        border {
            width: Styles.bgBorderW
            color: Styles.bgBorderColor
        }
    }
    Column {
        id: content
        width: 500
        height: 700
        opacity: Number(root.isVisible)
    }
}
