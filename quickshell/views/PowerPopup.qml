import Quickshell
import Quickshell.Services.UPower
import Quickshell.Wayland
import QtQuick
import "../commons/"
import "../vars/"

PanelWindow {
    id: root

    // Battery
    property var displayDev: UPower.displayDevice
    property int batPerc: displayDev.percentage * 100
    property var isCharging: !UPower.onBattery
    property int remaining: displayDev.timeToEmpty
    property int fullAfter: displayDev.timeToFull

    // PowerProfile
    property var currentPProfile: PowerProfiles.profile

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
        width: 300

        spacing: 2

        padding: 10

        Label {
            color: Styles.textColor2
            text: "Battery"
        }
        Row {
            H1 {
                text: root.batPerc + "%"
                font.pointSize: 32
            }
        }
        Label {
            text: {
                let pfx = root.isCharging ? "Full after: " : "Remaining: ";
                let time = root.isCharging ? root.fullAfter : root.remaining;
                let mins = Math.floor(time / 60) % 60;
                let hours = Math.floor(time / 60 / 60);
                return `${pfx}${hours} h ${mins}m`;
            }
            color: Styles.textColor2
        }
        HorizontalLine {
            width: content.width
        }
        Rectangle {
            anchors.horizontalCenter: content.horizontalCenter
            width: powerModePanel.width
            height: 35
            Row {
                id: powerModePanel
                height: parent.height
                Repeater {
                    model: [PowerProfile.PowerSaver, PowerProfile.Balanced, PowerProfile.Performance]
                    Rectangle {
                        height: powerModePanel.height
                        width: height
                    }
                }
            }
        }
    }
}
