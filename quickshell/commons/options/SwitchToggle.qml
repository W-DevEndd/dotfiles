import QtQuick
import QtQuick.Controls
import "root:/"

Switch {
    id: root

    width: 2 * height

    contentItem: Item {}

    indicator: Rectangle {
        property int margins: 3
        height: parent.height - margins * 2
        width: height
        x: root.visualPosition * ((parent.width - margins * 2) - width) + margins
        y: margins
        Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutExpo }}


        radius: width / 2
        color: Catppuccin.crust
        Behavior on color { ColorAnimation {
            easing: Easing.OutExpo
            duration: 400
        }}
    }
    background: Rectangle {
        height: root.height
        width: root.width

        radius: height / 2
        color: root.checked ? Catppuccin.blue : Catppuccin.surface0
        Behavior on color { ColorAnimation {
            easing: Easing.OutExpo
            duration: 400
        }}
    }
    HoverHandler { cursorShape: Qt.PointingHandCursor}
}
