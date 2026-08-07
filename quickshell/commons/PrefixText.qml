import QtQuick
import "root:/"
import "root:/commons/"

Row {
    id: root

    property string prefix: "$"
    property string value: "100"
    property color prefixColor: Catppuccin.blue
    property color valueColor: Catppuccin.text

    spacing: 2

    BaseText {
        anchors.verticalCenter: root.verticalCenter
        text: root.prefix
        color: root.prefixColor
    }
    BaseText {
        anchors.verticalCenter: root.verticalCenter
        text: root.value
        color: root.valueColor
    }
}
