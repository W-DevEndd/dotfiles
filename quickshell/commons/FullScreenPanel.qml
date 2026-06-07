import Quickshell
import QtQuick
import "../vars/"

PanelWindow {
    id: root

    property var visibleBy: false
    property var toggleVisible: () => {}

    anchors { top: true; left: true; right: true; bottom: true }
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"
    // property int direction: 2
    // property int verticalMargin: 4
    // property int horizontalMargin: 4
    //
    // anchors {
    //     top: direction == 1 || direction == 2
    //     bottom: direction == 3 || direction == 4
    //     left: direction == 1 || direction == 4
    //     right: direction == 2 || direction == 3
    // }

    MouseArea {
        width: root.width
        height: root.height
        onClicked: root.toggleVisible()

        Label {
            text: "Click anywhere to close popup"
            font.bold: true
            anchors {
                bottom: parent.bottom
                bottomMargin: 55
                horizontalCenter: parent.horizontalCenter
            }
        }
    }

    visible: visibleBy
}
