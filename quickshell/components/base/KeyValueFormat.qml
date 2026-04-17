
import QtQuick
import "./"

Row {
    width: childrenRect.width
    height: childrenRect.height
    spacing: 5

    property var useExtraValue: false
    property color keyColor: Theme.lavender
    property string key: "key"
    property color valueColor: Theme.text
    property string value: ""
    property string extraValue: ""

    Label {
        text: parent.key
        color: parent.keyColor
    }

    Label{
        text: parent.value
        color: parent.valueColor
    }

    Item {
        // visible: parent.useExtraValue
        clip: true
        height: childrenRect.height
        width: parent.useExtraValue ? childrenRect.width : 0
        Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }

        Label {
            text: parent.parent.extraValue
            visible: parent.parent.valueColor
        }
    }
}
