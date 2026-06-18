import QtQuick
import "root:/"
import "root:/commons/"

ContentPanel {
    id: root

    width: height

    BaseText {
        anchors.centerIn: root
        text: "󰍜"
    }

    MouseArea {
        anchors.fill: root
        onClicked: PpStates.showMenuPopup = !PpStates.showMenuPopup
    }
}
