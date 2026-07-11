pragma Singleton
import Quickshell.Io
import QtQuick

QtObject {
    id: root

    // ---
    // Main Properties
    // ---

    property real sinkVolume: -1
    property var mutedSink: undefined

    property real sourceVolume: -1
    property var mutedSource: undefined

    property real brightnessVolume: -1

    // ---
    // Logical Engines
    // ---

    // flags
    property var _isUpdatingSinkVolume: false
    property var _isUpdatingSourceVolume: false
    property var _isUpdatingMutedSink: false
    property var _isUpdatingMutedSource: false

    // listener
    onSinkVolumeChanged: {
    }

    property var _pavuListener: Process {
        command: ["sh", "-c", 'pactl subscribe | grep --line-buffered -E "sink|source"']
        running: true
        stdout: SplitParser {
            onRead: {
                root._getAudioVol.running = true
            }
        }
    }
    property var _brightnessListener: Process {
        command: ["sh", "-c", 'udevadm monitor --subsystem=backlight | grep --line-buffered "change"']
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
                var value = this.text.trim().split(/\s+/)
                root.brightnessVolume = Number(value[value.length - 1].match(/\d+/)[0]) / 100
            }
        }
    }
    property var _getAudioVol: Process {
        command: ["sh", "-c", "(wpctl get-volume @DEFAULT_AUDIO_SINK@; wpctl get-volume @DEFAULT_AUDIO_SOURCE@)"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                var value = this.text.split("\n");
                value = value.filter(it => it !== "");
                value.map((it, id) => {
                    value[id] = it.split(/\s+/);
                });

                root.sinkVolume = Number(value[0][1]);
                root.sourceVolume = Number(value[1][1]);
                root.mutedSink = value[0].includes("[MUTED]");
                root.mutedSource = value[1].includes("[MUTED]");
            }
        }
    }

    // system updater
    property var _updateSinkVolume: Process {
        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", root.sinkVolume]
        onStarted: root._isUpdatingSinkVolume = true
        onExited: root._isUpdatingSinkVolume = false
    }
}
