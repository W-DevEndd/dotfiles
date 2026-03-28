
import "../../"
import QtQuick
import QtQuick.Layouts

Text {
    property string format: "dddd MMMM dd, yyyy - hh:mm:ss AP"
    property var now: new Date()
    text: Qt.formatDateTime(now, format)
    font.pointSize: Theme.fontSize

    color: Theme.text

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: parent.now = new Date()
    }
}
