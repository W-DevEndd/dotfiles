import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import "root:/"
import "root:/commons/"

ListView {
    id: root

    property string inpText: ""

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
        width: root.width
        height: 40

        MouseArea {
            anchors.fill: parent
            onClicked: modelData.execute()
            HoverHandler { onHoveredChanged: if (hovered) { root.currentIndex = index }}
        }

        Row {
            anchors.fill: desktopItem

            padding: 4
            spacing: 4

            IconImage {
                height: parent.height - parent.padding * 2
                width: height
                source: modelData.icon ? "image://icon/" + modelData.icon : "image://icon/application-x-executable"
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
