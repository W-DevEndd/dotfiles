pragma Singleton
import QtQuick
import Quickshell.Hyprland

QtObject {
    id: root
    property var workspaces: Hyprland.workspaces.values

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
