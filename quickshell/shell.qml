import Quickshell
import QtQuick
import QtQuick.Layouts
import "./components/base"
import "./components/modules"

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }
    color: "transparent"
    aboveWindows: false
    implicitHeight: 36

    RowLayout {
        anchors.centerIn: parent
        height: parent.height - 10
        width: parent.width - 10
        
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }


        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }


        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true

            HorizontalPadding {}
            ModulesGroupBg {
                
                Layout.fillHeight: true
                Layout.preferredWidth: childrenRect.width + 10
                DateTime {
                    anchors.centerIn: parent
                }
            }
        }

    }
}
