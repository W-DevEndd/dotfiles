import QtQuick
import Quickshell
import Quickshell.Wayland
import "root:/"
import "root:/commons/"
import "root:/commons/options/"

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
        border {
            color: Catppuccin.crust
            width: 1
        }
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

        Column {
            id: sliderPanel
            width: maincontent.width

            spacing: 5

            OptionSlider {
                id: sinkAudioSlider
                height: 34
                width: parent.width

                displayIcon: SystemStates.isMutedSink ? "" : (
                    currentValue >= 40 ? "" :
                    currentValue >= 10 ? "" : ""
                )

                minValue: 0
                maxValue: 100
                sliderStep: 1
                Binding on currentValue {
                    value: SystemStates.sinkVolume
                }

                onCurrentValueChanged: SystemStates.sinkVolume = sinkAudioSlider.currentValue
                clickIconHandle: () => SystemStates.isMutedSink = !SystemStates.isMutedSink
            }
            OptionSlider {
                id: sourceAudioSlider
                height: 34
                width: parent.width

                displayIcon: SystemStates.isMutedSource ? "" : ""

                minValue: 0
                maxValue: 100
                sliderStep: 1
                Binding on currentValue {
                    value: SystemStates.sourceVolume
                }

                onCurrentValueChanged: SystemStates.sourceVolume = sourceAudioSlider.currentValue
                clickIconHandle: () => SystemStates.isMutedSource = !SystemStates.isMutedSource
            }
            OptionSlider {
                id: briSlider
                height: 34
                width: parent.width

                displayIcon: (
                    currentValue > 96 ? "" :
                    currentValue > 88 ? "" :
                    currentValue > 80 ? "" :
                    currentValue > 73 ? "" :
                    currentValue > 65 ? "" :
                    currentValue > 57 ? "" :
                    currentValue > 50 ? "" :
                    currentValue > 42 ? "" :
                    currentValue > 34 ? "" :
                    currentValue > 26 ? "" :
                    currentValue > 19 ? "" :
                    currentValue > 11 ? "" :
                    currentValue > 3 ? "" : ""
                )

                property real minValue: 0
                property real maxValue: 100
                property real sliderStep: 1
                Binding on currentValue {
                    value: SystemStates.brightnessVolume
                }

                onCurrentValueChanged: SystemStates.brightnessVolume = briSlider.currentValue
            }
        }
    }

}
