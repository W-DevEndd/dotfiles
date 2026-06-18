import QtQuick
import Quickshell
import Quickshell.Wayland
import "root:/"

PanelWindow {
    exclusionMode: TopLvl.isFullScreen ? ExclusionMode.Ignore : ExclusionMode.Normal
    exclusiveZone: 0

    WlrLayershell.layer: WlrLayer.Overlay

    anchors {
        top: true
    }
}
