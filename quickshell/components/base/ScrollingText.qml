import QtQuick
import Quickshell

Item {
    id: root
    property int speed: mainText.implicitWidth * 15
    property int implicitSpeed: 500

    property string text: ""
    property int spacing: 10
    property int maxWidth: 300
    height: childrenRect.height
    width: Math.min(maxWidth, mainText.implicitWidth)
    clip: true

    Behavior on width { NumberAnimation { duration: root.implicitSpeed ; easing.type: Easing.InOutExpo } }

    Row {
        id: textRow
        width: childrenRect.width
        Behavior on x { NumberAnimation { duration: root.implicitSpeed ; easing.type: Easing.InOutExpo } }
        Label {
            id: mainText
            text: root.text
        }
    }
    onTextChanged: {
        root.implicitSpeed = 500
        timer.stop()
        textRow.x = 1
        textRow.x = 0
        timer.restart()
    }

    function scroll() {
        textRow.x = textRow.x == 0 ? -(mainText.implicitWidth - root.width) : 0
    }

    Timer {
        id: timer
        interval: root.implicitSpeed
        repeat: true
        running: true
        onTriggered: {
            root.implicitSpeed = Qt.binding(() => { return root.speed })
            root.scroll()
        }
    }
}
