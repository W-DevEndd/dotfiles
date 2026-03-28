import QtQuick
import QtQuick.Layouts

Item {
    property real size: 0
    Layout.fillWidth: size == 0 ? true : false
    Layout.preferredWidth: size != 0 ? size : 0
    Layout.fillHeight: true
}
