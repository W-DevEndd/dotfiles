import Quickshell
import QtQuick
import "root:/"
import "./quicksettings/"

Rectangle {
    id: root

    MouseArea { anchors.fill: root }

    color: Catppuccin.base
    border {
        width: 2
        color: Catppuccin.crust
    }

    height: content.height
    width: 333
    radius: root.radius

    clip: true
    Row {
        id: content
        property var isInExtraContent: false
        property int trueHeight: (isInExtraContent ? extraContent.height: generalContent.height) + padding * 2
        // onTrueHeightChanged: root.contentHeight = Math.max(trueHeight, height)
        function loadExtraContent(path: string, opts) {
            extraContent.setSource(path, opts)
        }

        width: parent.width
        height: trueHeight
        Behavior on height { NumberAnimation {
            easing: Easing.OutExpo
            duration: 400
        }}
        // onHeightChanged: if (height === trueHeight) root.contentHeight = trueHeight

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
