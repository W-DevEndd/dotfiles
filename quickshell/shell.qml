import Quickshell
import Quickshell.Io // for Process
import QtQuick

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 36

    Text {
        text: "Hello, World!"
        anchols {
            centerIn: parent
        }
    }

    Process {
        
    }


}
