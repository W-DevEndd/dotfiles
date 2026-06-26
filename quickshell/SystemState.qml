pragma Singleton
import Quickshell.Io
import QtQuick

QtObject {
    property var _pavuListener: Process {
        command: ["sh", "-c", 'pactl subscribe | grep --line-buffered -E "sink|source"']
        running: true
        stdout: SplitParser {
            onRead: {
                getAudioVol.running = true
            }
        }
    }
    property var _getAudioVol: Process {
        command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@; wpctl get-volume @DEFAULT_AUDIO_SOURCE@"]
        stdout: StdioCollector {
            onStreamFinished: {
                console.log(this.text)
            }
        }
    } 
}
