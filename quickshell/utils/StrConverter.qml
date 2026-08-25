pragma Singleton
import QtQuick

QtObject {
    id: root
    function byteToH(b, fix = 1) {
        if (b < 1024 ** 1) return b + " B"
        else if (b < 1024 ** 2) return (b / 1024 ** 1).toFixed(fix) + " KiB"
        else if (b < 1024 ** 3) return (b / 1024 ** 2).toFixed(fix) + " MiB"
        else if (b < 1024 ** 4) return (b / 1024 ** 3).toFixed(fix) + " GiB"
        else if (b < 1024 ** 5) return (b / 1024 ** 4).toFixed(fix) + " TiB"
        return b
    }
    function kHzToH(k, fix = 1) {
        if (k < 1000) return k + "KHz"
        else if (k < 1000 ** 2) return (k / 1000 ** 1).toFixed(fix) + " MHz"
        else if (k < 1000 ** 3) return (k / 1000 ** 2).toFixed(fix) + " GHz"
        else if (k < 1000 ** 4) return (k / 1000 ** 3).toFixed(fix) + " THz"

        return k
    }
}
