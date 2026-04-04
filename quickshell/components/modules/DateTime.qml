
import "../base/"
import QtQuick

Label {
    property string format: "dddd, MMMM dd, yyyy '' HH:mm:ss A"
    property var now: new Date()
    text: Qt.formatDateTime(now, format)

    Timer {
        interval: 1
        repeat: true
        running: true
        onTriggered: parent.now = new Date
    }
}
