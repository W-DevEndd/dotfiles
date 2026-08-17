import QtQuick
import "root:/"
import "root:/commons/"

Item {
    id: root

    height: childrenRect.height

    property string prefix: "$"
    property string value: "100"
    property color prefixColor: Catppuccin.blue
    property color valueColor: Catppuccin.text

    BaseText {
        anchors.left: root.left
        text: root.prefix
        color: root.prefixColor
    }
    BaseText {
        anchors.right: root.right
        text: root.value
        color: root.valueColor
    }
}
