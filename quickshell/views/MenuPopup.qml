import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "root:/"
import "root:/commons/"
import "root:/commons/option/"

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

                OptionSlider {
                    id: soundControl
                    width: sliderPanel.width

                    leftText: sliderPos * 100 + 0.5 | 0
                    onSliderMoved: {
                        Quickshell.execDetached(["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", sliderPos]);
                    }

                    Connections {
                        target: SystemStates
                        function onSinkVolumeChanged() {
                            (Math.abs(SystemStates.sinkVolume - soundControl.sliderPos) >= 0.005) && (
                                soundControl.newValue = SystemStates.sinkVolume
                            )
                        }
                        // function onMutedSinkChanged() { console.log(SystemStates.mutedSink) }
                        // function onSourceVolumeChanged() { console.log(SystemStates.sourceVolume) }
                        // function onMutedSourceChanged() { console.log(SystemStates.mutedSource) }
                    }
                }
            }
        }
    }

}
