pragma Singleton
import QtQuick
import Quickshell.Hyprland

QtObject {
    id: root
    property var workspaces: Hyprland.workspaces.values
    property var update: false

    // property var _test: Timer {
    //     interval: 1000
    //     repeat: true
    //     running: true
    //     onTriggered: {
    //         console.log(root.workspaces.length)
    //     }
    // }

    function getIndexById(id) {
        for (let i = 0; i < root.workspaces.length; i++) {
            if (workspaces[i].id === id) return i
        }
        return undefined
    }

    function getById(id) {
        var index = root.getIndexById(id)
        return index !== undefined ? root.workspaces[index] : undefined
    }
}
