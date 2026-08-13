import QtQuick
import Quickshell
import Quickshell.Wayland
import "root:/"
import "root:/commons/"

PanelWindow {
    id: root
    // visible: false

    property real opacity: 1.0
    property int gaps: 5
    property int corner: 5

    property var _conn: Connections {
        target: NotificationDaemon

        function onNotification(noti) {
            notiLoader.model.append(noti)
        }
    }

    anchors {
        left: true
        bottom: true
    }

    color: "transparent"
    exclusionMode: TopLvl.isFullScreen ? ExclusionMode.Ignore : ExclusionMode.Normal
    WlrLayershell.layer: WlrLayer.Overlay

    implicitWidth: 500
    implicitHeight: content.height + gaps * 2

    Column {
        id: content
        opacity: root.opacity
        x: root.gaps
        y: root.gaps
        width: root.width - root.gaps * 2
        height: childrenRect.height

        spacing: root.gaps

        Repeater {
            id: notiLoader
            model: ListModel {}
            delegate: Rectangle {
                id: notiControl
                width: content.width
                height: 96
                radius: root.corner
                color: Catppuccin.base
                border {
                    width: 2
                    color: Catppuccin.blue
                }

                property int padding: 12

                Row {
                    id: r
                    x: notiControl.padding
                    y: notiControl.padding
                    width:  notiControl.width  - notiControl.padding * 2
                    height: notiControl.height - notiControl.padding * 2

                    clip: true

                    spacing: 12

                    Image {
                        id: icon
                        height: r.height
                        width: height

                        source: model.image
                    }
                    Flickable {
                        width: r.width - icon.width - r.spacing
                        height: r.height - r.padding

                        contentHeight: contentColumn.height
                        clip: true

                        boundsBehavior: Flickable.StopAtBounds

                        Column {
                            id: contentColumn
                            width: parent.width
                            BaseText {
                                width: parent.width
                                text: model.summary
                                font.bold: true
                                elide: Text.ElideRight
                            }
                            BaseText {
                                width: parent.width
                                text: model.body
                                color: Catppuccin.subtext0

                                wrapMode: Text.WordWrap
                            }
                        }
                    }
                }

                Timer {
                    interval: 5000
                    running: true
                    onTriggered: notiLoader.model.remove(index)
                }

                MouseArea {
                    anchors.fill: notiControl
                    onClicked: notiLoader.model.remove(index)
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
