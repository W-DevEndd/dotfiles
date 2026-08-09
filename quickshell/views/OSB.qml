import QtQuick
import "root:/"
import "root:/commons/"

Rectangle {
    id: root

    function loadVolumeControl() {
        contentLoader.setSource(slider, {

        })
    }

    width: 100
    height: 100

    color: Catppuccin.base
    border {
        width: 1
        color: Catppuccin.crust
    }

    MouseArea { anchors.fill: root}

    Loader {
        id: contentLoader
    }

    Component {
        id: slider

        Row {
            BaseText {
                text: "AAAaaaaaaaa"
            }
        }
    }
}
