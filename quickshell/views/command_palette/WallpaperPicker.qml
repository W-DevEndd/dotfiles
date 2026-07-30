import QtQuick

Item {
    id: root

    property string inpText: ""

    function handleEnter() { console.log("Aaaaaaaaaaaaa") }
    property var handleClose: () => {}

    height: 500
}
