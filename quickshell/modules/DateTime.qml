import Quickshell
import QtQuick
import "root:/commons/"

ContentPanel {
    id: root

    property int padding: 5
    property string format: "ddd, MMM dd, yyyy 󰧞 hh:mm:ss AP"

    width: txt.width + padding * 2

    BaseText {
        id: txt
        text: Qt.formatDateTime(clock.date, root.format)
        anchors.verticalCenter: root.verticalCenter
        x: root.padding
    }

    SystemClock {
        id: clock
    }
}
