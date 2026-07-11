import QtQuick
import QtQuick.Controls
import "root:/commons"


Item {
    id: root

    property string iconFrame:  "󱐋"
    property string valueFrame: "100"

    property string displayIcon: "󱐋"
    property string displayValue: "100"

    property int horizontalPadding: 5
    property int spacing: 5

    Label {
        id: iconPanel
        text: root.iconFrame
        color: "transparent"
        height: root.height
        anchors.left: root.left
        anchors.leftMargin: root.horizontalPadding

        BaseText {
            text: root.displayIcon
            anchors.centerIn: parent
        }
    }
    Label {
        id: valuePanel
        text: root.valueFrame
        color: "transparent"
        height: root.height
        anchors.right: root.right
        anchors.rightMargin: root.horizontalPadding

        BaseText {
            text: root.displayValue
            anchors.centerIn: parent
        }
    }

    Slider {
        id: control
        height: root.height
        width: root.width - 2 * (root.spacing + root.horizontalPadding) - iconPanel.width - valuePanel.width
        x: root.horizontalPadding + iconPanel.width + root.spacing
    }
}
