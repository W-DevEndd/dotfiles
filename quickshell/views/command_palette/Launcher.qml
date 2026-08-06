import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import "root:/"
import "root:/commons/"

ListView {
    id: root

    property string inpText: ""

    function handleEnter() { root.currentItem.execute() }
    property var handleClose: () => {}

    height: Math.min(childrenRect.height, 500)
    model: ScriptModel {
        values: {
            const allApps = (
                root.inpText.startsWith("/") ? PpStates.cmpCustomCommands :
                [...DesktopEntries.applications.values].sort((a, b) => a.name.localeCompare(b.name))
            );

            const filteredApps = allApps.filter(app => 
                app.name.toLowerCase().includes(root.inpText.toLowerCase())
            );
            if (!filteredApps.length) return [{
                name: "Run `" + root.inpText + "` as sh",
                icon: "application-x-shellscript",
                execute: () => { Quickshell.execDetached(["sh", "-c", root.inpText]) },
            }]
            root.currentIndex = 0;

            return filteredApps
        }
    }

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

    delegate: Loader {
        id: desktopItem

        width: root.width
        height: 40

        function execute() {
            modelData.execute();
            if (!modelData.dontCloseOnExec) root.handleClose();
        }
        Component{
            id: itemComponent
            Item {
                width: desktopItem.width
                height: desktopItem.height

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
                    anchors.fill: parent

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
        asynchronous: true
        sourceComponent: itemComponent
    }
}
