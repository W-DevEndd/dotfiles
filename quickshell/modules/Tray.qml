import QtQuick
import Quickshell.Services.SystemTray
import "root:/"
import "root:/commons"

ContentPanel {
    id: root

    property int iconPadding: 5;

    width: main.width
    Row {
        id: main
        height: root.height

        Repeater {
            model: SystemTray.items
            delegate: Item {
                height: main.height
                width: height

                Image {
                    source: modelData.icon
                    anchors.centerIn: parent

                    width: parent.width - root.iconPadding * 2
                    height: parent.height - root.iconPadding * 2
                }
            }
        }
    }
}
