pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    // States
    property var needTopBar: showQuickSettings                       || showSystemMonitor
    property var showPopup:  showQuickSettings || showCommandPalette || showSystemMonitor || showOSB
    property var focusPopup: showQuickSettings || showCommandPalette || showSystemMonitor

    property var showQuickSettings:  false
    property var showCommandPalette: false
    property var showOSB:            false
    property var showSystemMonitor:  false

    function handleCloseAll() {
        PpStates.showQuickSettings  = false
        PpStates.showCommandPalette = false
        PpStates.showSystemMonitor  = false
        PpStates.showOSB            = false
    }

    property var cmpHandleAutoComplete: (text) => {}

    property var cmpCustomCommands: [
        {
            name: "/wallpaper",
            execute: () => { root.cmpHandleAutoComplete("/wallpaper ") },
            dontCloseOnExec: true,
        },
    ]

    // Logic
    property var _logic: IpcHandler {
        target: "popup"
        function toggleQuickSettings() { root.showQuickSettings = !root.showQuickSettings }
        function toggleCommandPalette() { root.showCommandPalette = !root.showCommandPalette }
    }
}
