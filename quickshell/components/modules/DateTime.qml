
import "../../"
import "../base/"
import QtQuick
import QtQuick.Layouts

BaseLabel {
    property string format: "dddd MMMM dd, yyyy - hh:mm:ss AP"
    property var now: new Date()
    text: Qt.formatDateTime(now, format)

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: parent.now = new Date()
    }
}
