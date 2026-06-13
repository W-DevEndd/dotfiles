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

    // Battery
    property var displayDev: UPower.displayDevice
    property int batPerc: displayDev.percentage * 100
    property var isCharging: !UPower.onBattery
    property int remaining: displayDev.timeToEmpty
    property int fullIn: displayDev.timeToFull

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
        right: Styles.windowGaps - 1 / 3 * width * (1 - popupAlpha)
        top: Styles.windowGaps
    }

    implicitWidth: content.width
    implicitHeight: content.height
    exclusionMode: ExclusionMode.Normal
    WlrLayershell.layer: WlrLayer.Overlay
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
        width: 233

        spacing: 5

        padding: 10

        // top text panel
        Item {
            width: content.width - content.padding * 2
            height: childrenRect.height

            Label {
                color: Styles.textColor2
                text: "Battery"
            }
        }

        // primally text panel
        Item {
            width: content.width - content.padding * 2
            height: childrenRect.height
            H1 {
                text: root.batPerc + "%"
                font.pointSize: 32
                anchors.left: parent.left
            }
            H1 {
                text: BatteryNerd.value
                font.pointSize: 36
                anchors.right: parent.right
            }
        }

        // Time to full/empty
        Label {
            text: {
                let pfx = root.isCharging ? "Full in: " : "Remaining: ";
                let time = root.isCharging ? root.fullIn : root.remaining;
                let mins = Math.floor(time / 60) % 60;
                let hours = Math.floor(time / 60 / 60);
                return `${pfx}${hours} h ${mins}m`;
            }
            color: Styles.textColor2
        }

        HorizontalLine {
            width: content.width - 2 * content.padding
        }

        Label {
            text: "Mode:"
        }

        // Power Mode Toggles
        Item {
            id: powerModePanel
            height: 55
            width: content.width - content.padding * 2

            // Background
            Rectangle {
                height: powerModePanel.height
                width: powerModePanel.width
                radius: Styles.cornerRadius2
                color: Styles.bgColor1
            }

            // Indicator
            Rectangle {
                id: primamySlider
                height: powerModePanel.height
                width: height
                radius: Styles.cornerRadius2
                color: Styles.primary
                x: (powerModePanel.width / 2) * root.currentPProfile - ((width / 2) * root.currentPProfile)
                Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutExpo }}
            }

            Repeater {
                // model: [PowerProfile.PowerSaver, PowerProfile.Balanced, PowerProfile.Performance]
                model: [0, 1, 2]

                delegate: Button {
                    property var mode: {
                        switch (modelData) {
                            case 0: return PowerProfile.PowerSaver;
                            case 1: return PowerProfile.Balanced;
                            case 2: return PowerProfile.Performance;
                        }
                    }

                    height: powerModePanel.height
                    width: height

                    anchors {
                        left: modelData === 0 ? powerModePanel.left : undefined
                        horizontalCenter: modelData === 1 ? powerModePanel.horizontalCenter : undefined
                        right: modelData === 2 ? powerModePanel.right : undefined
                    }

                    background: null

                    icon.width: width
                    icon.height: height
                    icon.source: {
                        let path = "";
                        switch (modelData) {
                            case 0:
                                path = "../assets/icons/power-saver.svg";
                                break;
                            case 1:
                                path = "../assets/icons/balanced.svg";
                                break;
                            case 2:
                                path = "../assets/icons/performance.svg";
                                break;
                        }

                        return Qt.resolvedUrl(path);
                    }
                    icon.color: mode == root.currentPProfile ? Styles.bgColor1 : Styles.primary
                    Behavior on icon.color { ColorAnimation { duration: 400; easing: Easing.OutExpo  } }

                    onClicked: PowerProfiles.profile = mode
                }
            }
        }
    }
}
