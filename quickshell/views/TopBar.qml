import Quickshell
import Quickshell.Widgets
import QtQuick
import "../commons/"
import "../modules/"
import "../vars/"

PanelWindow {
    id: root

    implicitHeight: Styles.topbarWidth
    property int horizontalPadding: 5
    property int verticalPadding: 4

    aboveWindows: false
    color: "transparent"
    anchors {
        top: true
        left: true
        right: true
    }

    surfaceFormat.opaque: false

    // Background
    Rectangle {
        anchors.fill: parent
        color: Styles.bgColor
        border {
            width: Styles.bgBorderW
        }

        Component.onCompleted: {
            color.a = Styles.bgAlpha
        }
    }

    Row {
        id: leftModules

        height: root.height - root.verticalPadding
        spacing: 5

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: root.horizontalPadding
        }

        Workspaces {
            height: parent.height
        }
        
    }

    Row {
        id: centerModules

        height: root.height - root.verticalPadding
        spacing: 5

        anchors.centerIn: parent

        DateTime { anchors.verticalCenter: parent.verticalCenter }
    }

    Row {
        id: rightModules

        height: root.height - root.verticalPadding
        spacing: 5

        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: root.horizontalPadding
        }

        Tray { height: parent.height - 2; anchors.verticalCenter: parent.verticalCenter }
        Seperator {}
        Battery { height: parent.height }
    }
}
