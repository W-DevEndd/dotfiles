import Quickshell;
import QtQuick;
import "root:/";

PanelWindow {
    id: root;

    property real opacity: 1.0;

    anchors {
        top: true;
        left: true;
        right: true;
    }

    implicitHeight: 36;
    color: "transparent";

    Rectangle {
        id: bg;
        width: root.width;
        height: root.height;
        color: Catppuccin.base;
    }
}
