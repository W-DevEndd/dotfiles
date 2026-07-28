pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: root

    // States
    property var needTopBar: showQuickSettings
    property var showPopup: showQuickSettings || showCommandPalette

    property var showQuickSettings: false
    property var showCommandPalette: false

    property var customCommands: ListModel {
        ListElement { name: "/wallpaper" }
    }

    // Logic
    property var _logic: IpcHandler {
        target: "popup"
        function toggleQuickSettings() { root.showQuickSettings = !root.showQuickSettings }
        function toggleCommandPalette() { root.showCommandPalette = !root.showCommandPalette }
    }
}
