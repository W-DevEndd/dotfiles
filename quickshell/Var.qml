pragma Singleton
import QtQuick

QtObject {
    id: root

    readonly property url rootPath: Qt.resolvedUrl("./") + "/"
}
