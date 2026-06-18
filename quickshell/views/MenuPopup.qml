import QtQuick
import Quickshell
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

                OptionSlider { width: sliderPanel.width }
            }
        }
        // ContentPanel1 {
        //     width: maincontent.width
        //     height: 100
        // }
        // ContentPanel1 {
        //     width: maincontent.width
        //     height: 100
        // }
        // ContentPanel1 {
        //     width: maincontent.width
        //     height: 100
        // }
    }
}
