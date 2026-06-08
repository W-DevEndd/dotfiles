import Quickshell
import QtQuick
import Quickshell.Wayland
import "../vars/"

PanelWindow {
    id: root

    property var visibleBy: false
    property var toggleVisible: () => {}

    anchors { top: true; left: true; right: true; bottom: true }
    margins { top: 0;    left: 0;    right: 0   ; bottom: 0    }
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"

    // Area to close popup
    MouseArea {
        // z: -1
        width: root.width
        height: root.height
        onClicked: root.toggleVisible()
        propagateComposedEvents: false

        Label {
            text: "Click anywhere to close popup"
            color: Styles.textColor2
            anchors {
                bottom: parent.bottom
                bottomMargin: 55
                horizontalCenter: parent.horizontalCenter
            }
        }
    }

    visible: visibleBy
}
