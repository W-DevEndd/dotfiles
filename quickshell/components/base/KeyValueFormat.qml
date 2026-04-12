
import QtQuick
import "./"

Row {
    width: childrenRect.width
    height: childrenRect.height
    spacing: 5

    property color keyColor: Theme.lavender
    property string key: "key"
    property color valueColor: Theme.text
    property string value: ""

    Label {
        text: parent.key
        color: parent.keyColor
    }

    Label{
        text: parent.value
        color: parent.valueColor
    }
}
