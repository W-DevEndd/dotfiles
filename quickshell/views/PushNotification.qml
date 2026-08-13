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
            root.notis.append({
                image: noti.image,
                summary: noti.summary,
            })
        }
    }
    property var notis: ListModel {
    }

    anchors {
        right: true
        top: true
    }

    color: "transparent"
    exclusionMode: TopLvl.isFullScreen ? ExclusionMode.Ignore : ExclusionMode.Normal
    WlrLayershell.layer: WlrLayer.Overlay

    implicitWidth: 333
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
            model: root.notis
            delegate: Rectangle {
                id: notiControl
                width: content.width
                height: 96
                radius: root.corner
                color: Catppuccin.base
                border {
                    width: 1
                    color: Catppuccin.crust
                }

                property int padding: 5

                Row {
                    id: r
                    x: notiControl.padding
                    y: notiControl.padding
                    width:  notiControl.width  - notiControl.padding * 2
                    height: notiControl.height - notiControl.padding * 2

                    Image {
                        height: r.height
                        width: height

                        source: modelData.image
                    }
                    Column {
                        anchors.top: r.top
                        BaseText {
                            text: modelData.summary
                        }
                    }
                }
            }
        }
    }
}
