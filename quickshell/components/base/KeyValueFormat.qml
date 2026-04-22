
import QtQuick
import "./"

Row {
    id: root
    width: childrenRect.width
    height: childrenRect.height

    property int leftMargin: 0
    property var showValue: true
    property var useExtraValue: false
    property color keyColor: Theme.lavender
    property string key: "key"
    property color valueColor: Theme.text
    property string value: ""
    property string extraValue: ""

    // Item {
    //     width: parent.leftMargin
    //     height: parent.height
    // }
    Label {
        text: parent.key
        color: parent.keyColor
    }

    Row {
        // visible: parent.useExtraValue
        clip: true
        height: childrenRect.height
        width: !root.showValue ? 0 : root.useExtraValue ? childrenRect.width : value_padding.width + value_text.width
        // onWidthChanged: {
        //     console.log(root.width)
        // }
        Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }

        Item {
            id: value_padding
            height: parent.height
            width: 5
        }
        Label{
            id: value_text
            text: root.value
            color: root.valueColor
        }

        Item {
            height: parent.height
            width: 1
        }
        Label {
            text: "|"
            color: root.valueColor
        }
        Item {
            height: parent.height
            width: 1
        }
        Label {
            text: root.extraValue
            color: root.valueColor
        }
    }
}
