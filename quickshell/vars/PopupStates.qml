pragma Singleton
import QtQuick

QtObject {

    // PowerPopup
    property var showPowerPopup: false
    function toggleShowPowerPopup() { showPowerPopup = !showPowerPopup }
}
