import Quickshell.Hyprland
import QtQuick
import "root:/commons"

ContentPanel {
    id: root

    width: workspcNumbers.width

    Rectangle {
        id: focusedScroller
        height: root.height
    }

    Row {
        id: workspcNumbers
        height: root.height

        Repeater {
            model: Hyprland.workspaces
            delegate: ContentPanel {
                height: workspcNumbers.height
                width: height

                BaseText {
                    id: numberDisplay
                    text: modelData.id

                    anchors.centerIn: parent
                }
            }
        }
    }
}
