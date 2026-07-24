import Quickshell
import QtQuick
import "root:/"
import "./quicksettings/"

PanelWindow {
    id: root

    focusable: true

    property real opacity: 1.0
    color: "transparent"

    property int gaps: 0
    property int radius: 0
    
    implicitWidth: 333
    implicitHeight: content.trueHeight + root.gaps * 2

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

        clip: true
        Row {
            id: content
            property var isInExtraContent: false
            property int trueHeight: (isInExtraContent ? extraContent.height: generalContent.height) + padding * 2
            function loadExtraContent(path: string, opts) {
                extraContent.setSource(path, opts)
            }

            width: parent.width
            height: trueHeight
            Behavior on height { NumberAnimation {
                easing: Easing.OutExpo
                duration: 400
            }}

            padding: 8
            spacing: padding
            x: -(generalContent.width + content.spacing) * isInExtraContent
            Behavior on x { NumberAnimation {
                easing: Easing.OutExpo
                duration: 400
            }}

            GeneralSettings {
                id: generalContent
                parentContentContext: content
                width: content.width - content.padding * 2
            }

            Loader {
                id: extraContent
                width: content.width - content.padding * 2
                height: childrenRect.height
                sourceComponent: Item {}
                onLoaded: {
                    item.width = extraContent.width 
                }
            }
        }
    }
}
