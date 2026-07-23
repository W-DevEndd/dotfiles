import Quickshell
import QtQuick
import "root:/"

PanelWindow {
    id: root

    focusable: true

    property real opacity: 1.0
    color: "transparent"

    property int gaps: 0
    property int radius: 0
    
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
        radius: root.radius

        x: root.gaps
        y: root.gaps

        Row {
            id: content
            width: parent.width
            height: 400

            padding: 8
            spacing: 8

            Loader {
                id: generalContent
                Component.onCompleted: generalContent.setSource("./quicksettings/GeneralSettings.qml", {
                    width: content.width - content.padding * 2
                })
            }
        }
    }
}
