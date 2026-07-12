pragma Singleton
import Quickshell.Io
import QtQuick

QtObject {
    id: root

    // ---
    // Main Properties
    // ---

    property int brightnessVolume: -1

    property int sinkVolume: -1

    // ---
    // Logics
    // ---

    // flags
    property var _isSyncingBrightnessVolume: false
    property var _isSyncingSinkVolume: false

    // listener
    // on_IsSyncingBrightnessVolumeChanged: console.log(_isSyncingBrightnessVolume)
    onBrightnessVolumeChanged: {
        // console.log(brightnessVolume)
        if (root._isSyncingBrightnessVolume) return
        _updateBrightnessVolume.exec(["brightnessctl" , "set", root.brightnessVolume + "%"])
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

    onSinkVolumeChanged: {
        if (root._isSyncingSinkVolume) return
        _updateSinkVolume.exec(["wpctl" , "set-volume", "@DEFAULT_AUDIO_SINK@", root.sinkVolume / 100])
    }
    property var _pavuListener: Process {
        running: true
        command: ["sh", "-c", "pactl subscribe | grep --line-buffered -E 'change.*sink |change.*source '"]
        stdout: SplitParser { onRead: root._getPavu.running = true }
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
    property var _getPavu: Process {
        command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@; wpctl get-volume @DEFAULT_AUDIO_SOURCE@"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = this.text.trim().split("\n")
                const sinkVol = Number(lines[0].match(/\d+(\.\d+)?/)[0]) * 100
                const isMutedSink = lines[0].includes("[MUTED]")
                const sourceVol = Number(lines[1].match(/\d+(\.\d+)?/)[0]) * 100
                const isMutedSource = lines[1].includes("[MUTED]")

                if (!root._isSyncingSinkVolume) {
                    root._isSyncingSinkVolume = true
                    root.sinkVolume = sinkVol
                    root._isSyncingSinkVolume = false
                }
            }
        }
    }

    // system setter
    property var _updateBrightnessVolume: Process {
        onStarted: root._isSyncingBrightnessVolume = true
        command: ["brightnessctl", "set"]
        stdout: StdioCollector { onStreamFinished: root._isSyncingBrightnessVolume = false }
    }
    property var _updateSinkVolume: Process {
        onStarted: root._isSyncingSinkVolume = true
        command: ["wpctl", "set"]
        stdout: StdioCollector { onStreamFinished: root._isSyncingSinkVolume = false }
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
