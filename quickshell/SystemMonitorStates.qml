pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: root

    property var totalMem: -1
    property var usedMem:  -1

    property var totalSwap: -1
    property var usedSwap: -1

    property int cpuPerc: -1
    property int memPerc: ((usedMem / totalMem) * 100)
    property int swapPerc: ((usedSwap / totalSwap) * 100)

    property var mounts: []
    function refreshMounts() {
        root._mountProc.running = true
    }

    property var netDown: -1
    property var netUp: -1
    property int netDownPerS: 0
    property int netUpPerS: 0

    property var netDownHistory: []
    property var netUpHistory: []

    // onNetDownPerSChanged: console.log(netDownPerS)
    // onNetUpPerSChanged: console.log(netUpPerS)

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
                if (root.totalMem === -1) { root.totalMem = mem[1] * 1024 }
                root.usedMem = mem[2] * 1024

                if (root.totalSwap === -1) { root.totalSwap = swap[1] * 1024 }
                root.usedSwap = swap[2] * 1024
            }
        }
    }
    property var _netProc: Process {
        running: true
        command: ["cat", "/proc/net/dev"]
        stdout: StdioCollector {
            onStreamFinished: {
                var tmp = this.text.split('\n')
                var wlp = tmp.find(l => l.includes("wlp2s0:")).trim().split(/\s+/)
                // console.log(wlp)
                var down = wlp[1]
                var up = wlp[9]

                if (root.netDown !== -1) root.netDownPerS = down - root.netDown
                if (root.netUp !== -1) root.netUpPerS = up - root.netUp

                netDownHistory.push(netDownPerS);
                if (netDownHistory.length > 20) netDownHistory.shift()
                // console.log(JSON.stringify(netDownHistory, null))

                netUpHistory.push(netUpPerS);
                if (netUpHistory.length > 20) netUpHistory.shift()
                // console.log(JSON.stringify(netUpHistory, null))

                root.netDown = down
                root.netUp = up
            }
        }
    }
    property var _mountProc: Process {
        property var listing: true
        property var whiteList
        running: true
        command: ["lsblk", "-o", "MOUNTPOINTS"]
        stdout: StdioCollector {
            onStreamFinished: {
                if (root._mountProc.listing) {
                    root._mountProc.whiteList = this.text.split('\n').filter(p => p.trim()[0] === '/')
                    root._mountProc.listing = false
                    root._mountProc.exec(["df", "--output=target,used,size"])
                } else {
                    var arr = []
                    root._mountProc.listing = true
                    var tmp = this.text.split('\n')
                    for (const l of tmp) {
                        var ll = l.split(/\s+/)
                        if (!root._mountProc.whiteList.includes(ll[0])) continue
                        arr.push({
                            name:  ll[0],
                            used:  ll[1],
                            total: ll[2],
                        })
                    }
                    root.mounts = arr
                }
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
            root._netProc.running = true
        }
    }
}
