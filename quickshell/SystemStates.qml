pragma Singleton
import Quickshell.Io
import QtQuick

QtObject {
    id: root
    property real sinkVolume: -1
    property var mutedSink: undefined
    property real sourceVolume: -1
    property var mutedSource: undefined

    property var _pavuListener: Process {
        command: ["sh", "-c", 'pactl subscribe | grep --line-buffered -E "sink|source"']
        running: true
        stdout: SplitParser {
            onRead: {
                root._getAudioVol.running = true
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
}
