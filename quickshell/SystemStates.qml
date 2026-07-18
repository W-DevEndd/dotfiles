pragma Singleton
import Quickshell.Networking
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick

QtObject {
    id: root

    // ---
    // Main Properties
    // ---

    // Media $ Display control
    property int brightnessVolume: -1

    property int sinkVolume: -1
    property int sourceVolume: (Pipewire.defaultAudioSource && Pipewire.defaultAudioSource.audio) ? Math.round(Pipewire.defaultAudioSource.audio.volume * 100) : 0

    property var isMutedSink: null
    property var isMutedSource: null

    // Networking
    property var wifiEnabled: null
    property var wifiNetworks: null





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
    Binding on sinkVolume {
        value: (Pipewire.defaultAudioSink && Pipewire.defaultAudioSink.audio) ? Math.round(Pipewire.defaultAudioSink.audio.volume * 100) : -1
    }
    Binding on isMutedSink {
        value: Pipewire.defaultAudioSink?.audio?.muted ?? null
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
    Binding on sourceVolume {
        value: (Pipewire.defaultAudioSource && Pipewire.defaultAudioSource.audio) ? Math.round(Pipewire.defaultAudioSource.audio.volume * 100) : -1
    }
    Binding on isMutedSource {
        value: Pipewire.defaultAudioSource?.audio?.muted ?? null
    }
    onIsMutedSourceChanged: {
        if (!Pipewire.defaultAudioSource?.audio) return
        Pipewire.defaultAudioSource.audio.muted = isMutedSource
    }



    Binding on wifiEnabled {
        value: Networking.wifiEnabled
    }
    onWifiEnabledChanged: {
        if (root.wifiEnabled === Networking.wifiEnabled) return
        Networking.wifiEnabled = root.wifiEnabled
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

    property var _getWifi: Instantiator {
        model: Networking.devices
        delegate: QtObject {
            Component.onCompleted: if (modelData.type === DeviceType.Wifi) {
                root.wifiNetworks = modelData.networks
                modelData.scannerEnabled = true
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
