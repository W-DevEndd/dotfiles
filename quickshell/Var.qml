pragma Singleton
import QtQuick
import Quickshell

QtObject {
    id: root

    readonly property url rootPath: Qt.resolvedUrl("./") + "/"
    readonly property url wallpaper_config_path: Quickshell.configPath("wallconf")
}
