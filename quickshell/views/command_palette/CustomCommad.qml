import QtQuick
import QtQuick.Controls

ListView {
    property string inpText: ""

    property var exitOnEntered: true
    function handleEnter() { root.currentItem.execute() }

    height: 100
}
