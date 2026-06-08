import Quickshell
import Quickshell.Wayland
import QtQuick
import "../commons/"
import "../vars/"

PanelWindow {
    id: root
    
    anchors {
        top: true
        right: true
    }
    exclusionMode: ExclusionMode.Normal
    exclusiveZone: 0
    visible: PopupStates.showPowerPopup
}
