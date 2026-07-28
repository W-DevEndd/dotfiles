import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import "root:/"
import "root:/commons/"

ListView {
    id: root

    property string inpText: ""

    property var exitOnEntered: true
    function handleEnter() { root.currentItem.execute() }

    height: Math.min(childrenRect.height, 500)
    model: ScriptModel {
        values: {
            const allApps = DesktopEntries.applications.values;

            return allApps.filter(app => 
                app.name.toLowerCase().includes(root.inpText.toLowerCase())
            );
        }
    }

    highlightFollowsCurrentItem: true
    highlight: Rectangle {
        width: root.width
        height: 40
        color: Catppuccin.surface0
        radius: 10

        Behavior on y { SpringAnimation {
            spring: 3
            damping: 0.2
            duration: 150
        } }
    }
    highlightMoveDuration: 150

    delegate: Item {
        id: desktopItem

        function execute() { modelData.execute() }

        width: root.width
        height: 40

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (root.currentIndex === index) return desktopItem.execute()
                root.currentIndex = index
            }
            HoverHandler {
                // onHoveredChanged: if (hovered) { root.currentIndex = index
                cursorShape: Qt.PointingHandCursor
            }
        }

        Row {
            anchors.fill: desktopItem

            padding: 4
            spacing: 4

            IconImage {
                height: parent.height - parent.padding * 2
                width: height
                source: Quickshell.iconPath(modelData.icon, "image-missing")
            }

            Item {
                height: parent.height - parent.padding * 2
                width: childrenRect.width

                BaseText {
                    anchors.verticalCenter: parent.verticalCenter
                    text: modelData.name
                }
            }
        }
    }
}
