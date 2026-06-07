import Quickshell
import QtQuick
import "../commons/"
import "../vars/"

FullScreenPanel {
    id: root
    visibleBy: PopupStates.showPowerPopup
    toggleVisible: PopupStates.toggleShowPowerPopup
    
    PopupWindow {
        id: mainPopup

        anchor {
            window: root
            rect.x: root.width
            rect.y: Styles.topbarWidth
        }

        implicitWidth: 100
        implicitHeight: 100

        color: "transparent"
        visible: true

        Rectangle {
            id: popupBg
            anchors.fill: parent
            color: Styles.bgColor
            // opacity: Styles.bgAlpha
            // Component.onCompleted: color.a = Styles.bgAlpha
            radius: Styles.cornerRadius1
            border {
                width: Styles.bgBorderW
                color: Styles.bgBorderColor
            }
        }
    }
}
