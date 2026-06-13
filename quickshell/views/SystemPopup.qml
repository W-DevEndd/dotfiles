import Quickshell
import Quickshell.Services.UPower
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import "../commons/"
import "../vars/"
import "../assets/icons/"

PanelWindow {
    id: root
    property var isVisible: false
    property real popupAlpha: Number(isVisible)
    Behavior on popupAlpha { NumberAnimation { duration: 400; easing.type: Easing.OutExpo }}
    visible: root.isVisible || root.popupAlpha != 0

    anchors {
        top: true
        right: true
    }
    margins {
        right: Styles.windowGaps - 1 / 3 * width * (1 - popupAlpha)
        top: Styles.windowGaps
    }
}
