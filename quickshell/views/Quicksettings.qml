import Quickshell
import QtQuick
import "root:/"

PanelWindow {
    id: root

    required property var loader

    signal close()
    onClose: {
        opacity = 0
        margins.right = -50
    }

    property real opacity: 1.0
    onOpacityChanged: loader.closed = opacity === 0
    Behavior on opacity { NumberAnimation {
        duration:400
        easing.type: Easing.OutExpo
    }}
    color: "transparent"

    property int gaps: 6
    anchors {
        top: true
        right: true
    }
    
    margins.right: -50
    Behavior on margins.right { NumberAnimation {
        duration: 400
        easing.type: Easing.OutExpo
    }}

    Component.onCompleted: margins.right = 0

    implicitWidth: 440
    implicitHeight: contentPanel.height + root.gaps * 2

    Rectangle {
        id: contentPanel

        opacity: root.opacity
        color: Catppuccin.base
        border {
            width: 2
            color: Catppuccin.crust
        }

        height: content.height
        width: root.width - root.gaps * 2
        radius: 10

        x: root.gaps
        y: root.gaps

        Column {
            id: content
            width: parent.width
            height: 400

            padding: 8
            spacing: 8
        }
    }
}
