import QtQuick
import Quickshell

Item {
    id: root
    property int speed: mainText.implicitWidth * 15
    property string text: ""
    property int spacing: 10
    property int maxWidth: 300
    height: childrenRect.height
    width: Math.min(maxWidth, mainText.width)
    Behavior on width { NumberAnimation { duration: 500 ; easing.type: Easing.InOutExpo } }
    clip: true
    Row {
        id: textRow
        width: childrenRect.width
        Behavior on x { NumberAnimation { duration: root.speed ; easing.type: Easing.InOutExpo } }
        Label {
            id: mainText
            text: root.text
            onImplicitWidthChanged: {
                textRow.x = 0
            }
        }

        function scroll() { textRow.x = textRow.x == 0 ? -(mainText.width - root.width) : 0 }
        // Item {
        //     height: parent.height
        //     width: root.spacing
        // }
        // Label{
        //     text: root.text
        // }
    }

    Timer {
        interval: 1
        running: mainText.width > root.width || textRow.x != 0
        onTriggered: {
        }
    }
    Timer {
        id: timer
        interval: root.speed + 1000
        running: mainText.width > root.width || textRow.x != 0
        repeat: true
        onTriggered: {
            textRow.scroll()
        }
    }
}
