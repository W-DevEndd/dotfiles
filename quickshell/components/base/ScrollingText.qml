import QtQuick
import Quickshell

Item {
    id: root
    property int speed: 25
    property string text: ""
    property int spacing: 10
    property int maxWidth: 300
    height: childrenRect.height
    width: Math.min(maxWidth, mainText.width)
    clip: true
    Row {
        id: textRow
        width: childrenRect.width
        Label {
            id: mainText
            text: root.text
        }
        Item {
            height: parent.height
            width: root.spacing
        }
        Label{
            text: root.text
        }
    }

    Timer {
        interval: root.speed
        running: mainText.width > root.width || textRow.x != 0
        repeat: true
        onTriggered: {
            textRow.x -= 1
            if (Math.abs(textRow.x) >= mainText.width + root.spacing) { textRow.x = 0 }
        }
    }
}
