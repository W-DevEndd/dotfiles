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

    property int sinkVolume: (Pipewire.defaultAudioSink && Pipewire.defaultAudioSink.audio) ? Math.round(Pipewire.defaultAudioSink.audio.volume * 100) : -1
    property int sourceVolume: (Pipewire.defaultAudioSource && Pipewire.defaultAudioSource.audio) ? Math.round(Pipewire.defaultAudioSource.audio.volume * 100) : -1

    property var isMutedSink: Pipewire.defaultAudioSink?.audio?.muted ?? null
    property var isMutedSource: Pipewire.defaultAudioSource?.audio?.muted ?? null





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

    onSinkVolumeChanged: {
        if (!Pipewire.defaultAudioSink?.audio) return
        if (root.sinkVolume === Math.round(Pipewire.defaultAudioSink.audio.volume * 100)) return
        Pipewire.defaultAudioSink.audio.volume = root.sinkVolume / 100
    }
    onIsMutedSinkChanged: {
        if (!Pipewire.defaultAudioSink?.audio) return
        Pipewire.defaultAudioSink.audio.muted = isMutedSink
    }

    onSourceVolumeChanged: {
        if (!Pipewire.defaultAudioSource?.audio) return
        if (root.sourceVolume === Math.round(Pipewire.defaultAudioSource.audio.volume * 100)) return
        Pipewire.defaultAudioSource.audio.volume = root.sourceVolume / 100
    }
    onIsMutedSourceChanged: {
        if (!Pipewire.defaultAudioSource?.audio) return
        Pipewire.defaultAudioSource.audio.muted = isMutedSource
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
