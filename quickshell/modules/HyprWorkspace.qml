import Quickshell.Hyprland
import QtQuick
import "root:/commons"
import "root:/"

ContentPanel {
    id: root

    property int padding: 5
    width: workspcNumbers.width
    Behavior on width { NumberAnimation { duration: 400; easing.type: Easing.OutExpo } }

    Rectangle {
        id: focusedScroller
        height: root.height - root.padding
        width: height

        color: Catppuccin.red
        radius: 6

        y: root.padding / 2
        x: root.padding / 2 + (height + root.padding) * Hyprland.workspaces.values.indexOf(Hyprland.focusedWorkspace)
        Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutExpo } }
    }

    Row {
        id: workspcNumbers
        height: root.height
        clip: true

        move: Transition {
            NumberAnimation { 
                property: "x"
                duration: 400 
                easing: Easing.OutExpo
            }
        }

        Repeater {
            model: Hyprland.workspaces
            delegate: Item {
                height: workspcNumbers.height
                width: height


                BaseText {
                    id: numberDisplay
                    text: modelData.id
                    color: Hyprland.focusedWorkspace === modelData ? Catppuccin.base : Catppuccin.text
                    Behavior on color { ColorAnimation { duration: 400; easing: Easing.OutExpo } }

                    anchors.centerIn: parent
                }
            }
        }
    }
}
