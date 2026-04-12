
import QtQuick
import "./"

Row {
    width: childrenRect.width
    spacing: 5

    property string format: "%1%2 %3%4"
    property string prefix: ""
    property string value: ""

    Label {
        textFormat: Text.RichText
        text: parent.format
    }
}
