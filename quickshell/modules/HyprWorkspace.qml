import Quickshell.Hyprland
import QtQuick
import "root:/commons"
import "root:/"

ContentPanel {
    id: root

    width: workspcNumbers.width

    ContentPanel {
        id: focusedScroller
        height: root.height
        width: height

        bgColor: Catppuccin.blue

        x: height * Hyprland.workspaces.values.indexOf(Hyprland.focusedWorkspace)
        Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutExpo } }
    }

    Row {
        id: workspcNumbers
        height: root.height

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
