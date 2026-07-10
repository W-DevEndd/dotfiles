import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "root:/"
import "root:/commons/"
import "root:/commons/options/"
import "root:/quick_setting/"

PanelWindow {
    id: root

    // visible animation
    property real alpha: Number(PpStates.showMenuPopup)
    Behavior on alpha { NumberAnimation { duration: 400; easing.type: Easing.OutExpo } }
    visible: PpStates.showMenuPopup | alpha !== 0

    color: "transparent"
    property real opacity: 1.0
    property int padding: 5
    property int margin: 5

    // position and size
    anchors {
        top: true
        right: true
    }
    margins.right: margin - 100 * (1 - root.alpha)
    margins.top: margin

    implicitWidth: 400
    implicitHeight: maincontent.height + padding * 2

    // layer
    exclusionMode: TopLvl.isFullScreen ? ExclusionMode.Ignore : ExclusionMode.Normal
    exclusiveZone: 0
    WlrLayershell.layer: WlrLayer.Overlay

    Rectangle {
        id: bg
        color: Catppuccin.base
        opacity: root.opacity * root.alpha
        radius: 10

        width: root.width
        height: root.height
    }

    Column {
        id: maincontent
        opacity: root.opacity * root.alpha

        width: root.implicitWidth - root.padding * 2
        x: root.padding
        y: root.padding

        spacing: 10

        Item {
            width: maincontent.width
            height: sliderPanel.height

            Column {
                id: sliderPanel
                width: parent.width

                spacing: 5
                
                PrimarySlider {
                    id: soundControl
                    rightText: displayValue
                    leftText: SystemStates.mutedSink ? "" : (displayValue >= 40 ? "" :
                        displayValue >= 10 ? "" : "")

                    clickCommand: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", Number(!SystemStates.mutedSink)]
                    dragCommand:  ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", sliderPos]

                    Connections {
                        target: SystemStates
                        function onSinkVolumeChanged() {
                            soundControl.newValue = SystemStates.sinkVolume
                        }
                    }
                }
                PrimarySlider {
                    id: micControl
                    rightText: displayValue
                    leftText: SystemStates.mutedSource ? "" : ""

                    clickCommand: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SOURCE@", Number(!SystemStates.mutedSource)]
                    dragCommand:  ["wpctl", "set-volume", "@DEFAULT_AUDIO_SOURCE@", sliderPos]

                    Connections {
                        target: SystemStates
                        function onSourceVolumeChanged() {
                            micControl.newValue = SystemStates.sourceVolume
                        }
                    }
                }
                PrimarySlider {
                    id: briControl
                    rightText: displayValue
                    leftText: displayValue >= 95 ? "󰛨" :
                    displayValue >= 85 ? "󱩖" :
                    displayValue >= 75 ? "󱩕" :
                    displayValue >= 65 ? "󱩔" :
                    displayValue >= 55 ? "󱩓" :
                    displayValue >= 45 ? "󱩒" :
                    displayValue >= 35 ? "󱩑" :
                    displayValue >= 25 ? "󱩐" :
                    displayValue >= 15 ? "󱩏" :
                    displayValue >= 5 ? "󱩎" : "󰛩"

                    dragCommand:  ["brightnessctl", "set", `${sliderPos * 100 + 1}%`]

                    Connections {
                        target: SystemStates
                        function onBrightnessVolumeChanged() {
                            briControl.newValue = SystemStates.brightnessVolume
                        }
                    }
                }
            }
        }
    }

}
