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

    // Popup
    property var isVisible: PopupStates.showSystemPopup
    property real popupAlpha: Number(isVisible)
    Behavior on popupAlpha { NumberAnimation { duration: 400; easing.type: Easing.OutExpo }}
    visible: root.isVisible || root.popupAlpha != 0
    color: "transparent"

    // Keybinds
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    Shortcut {
        sequence: "Escape"
        onActivated: PopupStates.showSystemPopup = false
    }

    // Size
    property int padding: 10
    implicitWidth: content.width + padding * 2
    implicitHeight: content.height + padding * 2
    exclusionMode: ExclusionMode.Normal
    WlrLayershell.layer: WlrLayer.Overlay
    exclusiveZone: 0

    // Position
    anchors {
        top: true
        right: true
    }
    margins {
        right: Styles.windowGaps - 1 / 3 * width * (1 - popupAlpha)
        top: Styles.windowGaps
    }

    // Background
    Rectangle {
        id: bg
        color: Styles.bgColor
        width: root.implicitWidth
        height: root.implicitHeight
        opacity: root.popupAlpha * Styles.bgAlpha
        radius: Styles.cornerRadius1
        border {
            width: Styles.bgBorderW
            color: Styles.bgBorderColor
        }
    }

    // Main Content
    Column {
        id: content
        width: 300
        height: 100

        x: root.padding
        y: root.padding
    }
}
