import QtQuick
import "../base/"

Item {
    id: root
    property var state: false
    property color iconColor: Theme.text

    width: height

    Item {
        anchors.centerIn: parent
        height: parent.height * 0.4
        width: height

        Rectangle {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            height: parent.height
            width: parent.width * 0.4
            radius: width

            color: root.iconColor
        }

        Rectangle {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            height: parent.height
            width: parent.width * 0.4
            radius: width

            color: root.iconColor
        }
    }
}
