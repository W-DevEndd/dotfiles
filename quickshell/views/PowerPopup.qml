import Quickshell
import Quickshell.Wayland
import QtQuick
import "../commons/"
import "../vars/"

FullScreenPanel {
    id: root
    visibleBy: PopupStates.showPowerPopup
    toggleVisible: PopupStates.toggleShowPowerPopup
    
    PanelWindow {
        id: mainPopup

        implicitWidth: 100
        implicitHeight: 100

        color: "transparent"
        visible: root.visibleBy

        WlrLayershell.layer: WlrLayer.Overlay

        Rectangle {
            id: popupBg
            anchors.fill: parent
            color: Styles.bgColor
            opacity: Styles.bgAlpha
            // Component.onCompleted: color.a = Styles.bgAlpha
            radius: Styles.cornerRadius1
            border {
                width: Styles.bgBorderW
                color: Styles.bgBorderColor
            }
        }
    }
}
