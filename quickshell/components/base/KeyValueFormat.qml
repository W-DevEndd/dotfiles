
import QtQuick
import "./"

Row {
    width: childrenRect.width
    height: childrenRect.height

    property int leftMargin: 0
    property var useExtraValue: false
    property color keyColor: Theme.lavender
    property string key: "key"
    property color valueColor: Theme.text
    property string value: ""
    property string extraValue: ""

    Item {
        width: parent.leftMargin
        height: parent.height
    }
    Label {
        text: parent.key
        color: parent.keyColor
    }

    Item {
        height: parent.height
        width: 5
    }
    Label{
        text: parent.value
        color: parent.valueColor
    }

    Row {
        // visible: parent.useExtraValue
        clip: true
        height: childrenRect.height
        width: parent.useExtraValue ? childrenRect.width : 0
        Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }

        Item {
            height: parent.height
            width: 1
        }
        Label {
            text: "|"
            color: parent.parent.valueColor
        }
        Item {
            height: parent.height
            width: 1
        }
        Label {
            text: parent.parent.extraValue
            color: parent.parent.valueColor
        }
    }
}
