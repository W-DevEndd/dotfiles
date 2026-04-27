pragma Singleton
import QtQuick

QtObject {
    function getIndexByUUID(list, uuid) {
        for (let i = 0; i < list.count; i++) {
            const child = list.get(i)
            if (child.uuid === uuid) { return i }
        }
        return -1
    }

    function setProperty(list, index, key, value) {
        const control = list[index]
        control[key] = value
    }
}
