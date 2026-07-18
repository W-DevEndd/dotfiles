pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: root

    // States
    property var showMenuPopup: false

    // Logic
    property var _logic: IpcHandler {
        target: "popup"
        function toggleMenu() { root.showMenuPopup = !root.showMenuPopup }
    }
}
