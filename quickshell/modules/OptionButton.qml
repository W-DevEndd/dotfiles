import QtQuick
import QtQuick.Controls
import Quickshell
import "../commons/"
import "../vars/"

Item {
    id: root

    width: height

    Button {
        id: btn
        anchors.fill: root
        onClicked: PopupStates.toggleShowSystemPopup()
        background: Rectangle {
            visible: PopupStates.showSystemPopup
            radius: 5
            color: Styles.primary2 
        }
    }

    Label {
        id: icon
        text: ""
        anchors.centerIn: root
        x: root.padding / 2
    }
}
