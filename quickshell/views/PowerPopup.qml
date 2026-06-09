import Quickshell
import Quickshell.Services.UPower
import Quickshell.Wayland
import QtQuick
import "../commons/"
import "../vars/"

PanelWindow {
    id: root

    property var displayDev: UPower.displayDevice
    property int batPerc: displayDev.percentage * 100
    property var isCharging: !UPower.onBattery
    property int remaining: displayDev.timeToEmpty
    property int fullIn: displayDev.timeToFull

    property var isVisible: false
    property real popupAlpha: Number(isVisible)
    Behavior on popupAlpha { NumberAnimation { duration: 400; easing.type: Easing.OutExpo }}

    anchors {
        top: true
        right: true
    }
    margins {
        top: Styles.windowGaps
        right: Styles.windowGaps - 1 / 3 * width * (1 - popupAlpha)
    }

    implicitWidth: content.width
    implicitHeight: content.height
    exclusionMode: ExclusionMode.Normal
    exclusiveZone: 0

    color: "transparent"
    visible: root.isVisible || root.popupAlpha != 0

    // Background
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

    // Main Content
    Column {
        id: content
        opacity: root.popupAlpha

        padding: 5

        Row {
            H1 {
                text: root.batPerc + "%"
            }
        }
        Label {
            text: root.remaining
        }
    }
}
