import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "root:/"
import "root:/commons/"
import "root:/commons/option/"

PanelWindow {
    id: root

    property real alpha: Number(PpStates.showMenuPopup)
    Behavior on alpha { NumberAnimation { duration: 400; easing.type: Easing.OutExpo } }

    property real opacity: 1.0
    property int padding: 5

    visible: PpStates.showMenuPopup | alpha !== 0

    margins.right: 0 - 100 * (1 - root.alpha)

    exclusionMode: TopLvl.isFullScreen ? ExclusionMode.Ignore : ExclusionMode.Normal
    exclusiveZone: 0
    WlrLayershell.layer: WlrLayer.Overlay

    color: "transparent"

    anchors {
        top: true
        right: true
    }

    implicitWidth: 400
    implicitHeight: maincontent.height + padding * 2

    Column {
        id: maincontent
        opacity: root.opacity * root.alpha

        width: root.implicitWidth - root.padding * 2
        x: root.padding
        y: root.padding

        spacing: 10

        ContentPanel1 {
            width: maincontent.width
            height: sliderPanel.height

            Column {
                id: sliderPanel
                width: parent.width

                OptionSlider {
                    id: soundControl
                    width: sliderPanel.width

                    leftText: Math.floor(sliderPos * 100)
                    onSliderMoved: Quickshell.execDetached(["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", sliderPos])
                }
            }
        }
    }

    Process {
        id: pavuListener
        command: ["sh", "-c", 'pactl subscribe | grep --line-buffered -E "sink|source"']
        running: true
        stdout: SplitParser {
            onRead: console.log("aaa")
        }
    }
}
