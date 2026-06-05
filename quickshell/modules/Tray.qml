import QtQuick
import Quickshell.Services.SystemTray

Row {
    id: root
    property int itemPadding: 4
    spacing: itemPadding

    Repeater {
        model: SystemTray.items

        delegate: Image {
            source: modelData.icon
            anchors.verticalCenter: root.verticalCenter
            height: root.height - root.itemPadding
            width: height
        }
    }
}
