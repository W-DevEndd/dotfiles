pragma Singleton
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick

QtObject {
    id: root

    // ---
    // Main Properties
    // ---

    property int brightnessVolume: -1

    property int sinkVolume: -1
    property var isMutedSink: false

    // ---
    // Logics
    // ---

    // flags
    property var _isSyncingBrightnessVolume: false

    // listener
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

    property var _audioTracker: PwObjectTracker {
        objects: [
            Pipewire.defaultAudioSink,
            Pipewire.defaultAudioSource,
        ]
    }

    property var  _sinkListener: Connections {
        target: Pipewire.defaultAudioSink?.audio ?? null
        function onVolumeChanged() { root.sinkVolume = Math.round(Pipewire.defaultAudioSink.audio.volume * 100) }
    }
    onSinkVolumeChanged: {
        if (!Pipewire.defaultAudioSink?.audio) return
        if (root.sinkVolume === Math.round(Pipewire.defaultAudioSink.audio.volume * 100)) return
        Pipewire.defaultAudioSink.audio.volume = root.sinkVolume / 100
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

    // system setter
    property var _updateBrightnessVolume: Process {
        onStarted: root._isSyncingBrightnessVolume = true
        command: ["brightnessctl", "set"]
        onExited: root._isSyncingBrightnessVolume = false
    }

    // tester
    property var _test: Timer {
        // running: true
        interval: 3000
        repeat: true
        onTriggered: {
            console.log(Pipewire.defaultAudioSink.audio.volume)
        }
    }
}
