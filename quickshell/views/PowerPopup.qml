import Quickshell
import Quickshell.Wayland
import QtQuick
import "../commons/"
import "../vars/"

PanelWindow {
    id: root

    property var isVisible: false
    property real popupAlpha: Number(isVisible)
    Behavior on popupAlpha { NumberAnimation { duration: 400; easing.type: Easing.OutExpo }}
    onPopupAlphaChanged: console.log(popupAlpha)

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
    visible: root.isVisible || root.popupAlpha != 0

    Rectangle {
        id: bg
        color: Styles.bgColor
        opacity: (root.popupAlpha * Styles.bgAlpha)
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
        opacity: root.popupAlpha
    }
}
