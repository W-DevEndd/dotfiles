pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: root

    property int totalMem: -1
    property int usedMem:  -1

    property int totalSwap: -1
    property int usedSwap: -1

    property int cpuPerc: -1
    property int memPerc: (usedMem / totalMem * 100)
    property int swapPerc: (usedSwap / totalSwap * 100)

    property var _cpuProc: Process {
        running: true
        command: ["sh", "-c", "top -bn1 | grep 'Cpu(s)'"]
        stdout: StdioCollector {
            onStreamFinished: {
                var tmp = this.text.split(/\s+/)
                root.cpuPerc = Math.floor(100 - tmp[7])
            }
        }
    }
    property var _memProc: Process {
        running: true
        command: ["free"]
        stdout: StdioCollector {
            onStreamFinished: {
                // console.log(this.text)
                var tmp = this.text.split('\n')
                var mem = tmp[1].split(/\s+/)
                var swap = tmp[2].split(/\s+/)
                // console.log(mem)
                // console.log(swap)
                if (root.totalMem === -1) { root.totalMem = mem[1] }
                root.usedMem = mem[2]

                if (root.totalSwap === -1) { root.totalSwap = swap[1] }
                root.usedSwap = swap[2]
            }
        }
    }

    property var _timer: Timer {
        running: true
        interval: 1000
        repeat: true
        onTriggered: {
            root._cpuProc.running = true
            root._memProc.running = true
        }
    }
}
