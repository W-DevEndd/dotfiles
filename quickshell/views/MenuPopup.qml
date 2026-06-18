import QtQuick
import Quickshell
import Quickshell.Wayland
import "root:/"

PanelWindow {
    id: root

    property real alpha: Number(PpStates.showMenuPopup)
    Behavior on alpha { NumberAnimation { duration: 400; easing.type: Easing.OutExpo } }

    property real opacity: 1.0

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

    Rectangle {
        id: bg
        color: Catppuccin.base
        opacity: root.opacity * (root.alpha)

        width: root.width
        height: root.height

        radius: 10

        border {
            width: 1
            color: Catppuccin.crust
        }
    }
}
