pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: root

    // States
    property var showQuickSettings: false

    // Logic
    property var _logic: IpcHandler {
        target: "popup"
        function toggleQuickSettings() { root.showQuickSettings = !root.showQuickSettings }
    }
}
