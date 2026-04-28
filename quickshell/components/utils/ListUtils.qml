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

    // function updateProperty(list, index, key, value) {
    //     list.setProperty(index, )
    // }
}
