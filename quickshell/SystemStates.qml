pragma Singleton
import Quickshell.Io
import QtQuick

QtObject {
    id: root

    // ---
    // Main Properties
    // ---

    property int brightnessVolume: -1

    // ---
    // Logics
    // ---

    // flags
    property var _isSyncingBrightnessVolume: false

    // listener
    // on_IsSyncingBrightnessVolumeChanged: console.log(_isSyncingBrightnessVolume)
    onBrightnessVolumeChanged: {
        // console.log(brightnessVolume)
        if (root._isSyncingBrightnessVolume) return
        _updateBrightnessVolume.command = ["brightnessctl" , "set", root.brightnessVolume + "%"]
        _updateBrightnessVolume.running = true
    }
    property var _brightnessListener: Process {
        command: ["sh", "-c", 'udevadm monitor --kernel --subsystem=backlight | grep --line-buffered "change"']
        running: true
        stdout: SplitParser {
            onRead: {
                root._getBrightness.running = true
            }
        }
    }

    // system getter
    property var _getBrightness: Process {
        command: ["sh", "-c", 'brightnessctl | grep "Current"']
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                if (root._isSyncingBrightnessVolume) return
                var value = this.text.trim().split(/\s+/)
                root._isSyncingBrightnessVolume = true
                root.brightnessVolume = Number(value[value.length - 1].match(/\d+/)[0])
                root._isSyncingBrightnessVolume = false
            }
        }
    }

    // system updater
    property var _updateBrightnessVolume: Process {
        onStarted: root._isSyncingBrightnessVolume = true
        command: ["brightnessctl", "set"]
        stdout: StdioCollector { onStreamFinished: root._isSyncingBrightnessVolume = false }
    }

    // tester
    property var _test: Timer {
        // running: true
        interval: 3000
        onTriggered: {
            root.brightnessVolume = 20
        }
    }
}
