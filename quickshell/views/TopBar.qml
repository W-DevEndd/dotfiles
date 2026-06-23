import Quickshell
import Quickshell.Hyprland
import QtQuick
import "root:/"
import "root:/commons"
import "root:/modules"

PanelWindow {
    id: root

    property real opacity: 1.0
    property int padding: 4

    property int cornerSize: 15
    property int h: 36

    aboveWindows: false
    exclusiveZone: h

    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: h + cornerSize
    color: "transparent"

    Canvas {
        id: bg
        opacity: root.opacity

        width: root.width
        height: root.height

        onPaint: {
            var ctx = getContext("2d");


            ctx.fillStyle = Catppuccin.base;
            ctx.beginPath();

            ctx.moveTo(0, 0);
            ctx.lineTo(bg.width, 0);
            ctx.lineTo(bg.width, bg.height);
            ctx.quadraticCurveTo(bg.width, bg.height - root.cornerSize, bg.width - root.cornerSize, bg.height - root.cornerSize);
            ctx.lineTo(root.cornerSize, bg.height - root.cornerSize);
            ctx.quadraticCurveTo(0, bg.height - root.cornerSize, 0, bg.height);
            ctx.fill();
        }
    }

    Item {
        id: content;
        width: root.width - root.padding * 2
        height: root.h - root.padding * 2
        x: root.padding
        y: root.padding

        opacity: root.opacity

        Row {
            id: leftModules
            anchors.left: content.left
            height: content.height

            spacing: 5

            HyprWorkspace { height: parent.height }
        }

        Row {
            id: middleModules
            anchors.horizontalCenter: content.horizontalCenter
            height: content.height

            spacing: 5
        }

        Row {
            id: rightModules
            anchors.right: content.right
            height: content.height

            spacing: 5

            Tray { height: parent.height }
            DateTime { height: parent.height }
            Menu { height: parent.height }
        }
    }
}
