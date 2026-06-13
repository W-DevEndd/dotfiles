pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    property int battery: 0;

    function updateSensor() {
    }

    property var _proc: Process {
        running: true
        command: ["sensors"]
        stdout: StdioCollector {
            onStreamFinished: console.log(this.text)
        }
    }
}
