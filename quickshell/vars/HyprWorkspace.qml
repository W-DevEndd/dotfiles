pragma Singleton
import QtQuick
import Quickshell.Hyprland

QtObject {
    id: root
    property var update: false
    property int length: 10
    property var values: [...Array(root.length)]

    function toggleUpdate() { root.update = !root.update }
    function getById(id) {
        return root.values[id - 1];
    }

    property var logical: Instantiator {
        model: Hyprland.workspaces
        delegate: QtObject {
            property var ref: modelData
        }
        onObjectAdded: (_, obj) => {
            const id = obj.ref.id;
            root.values[id - 1] = obj.ref;
            root.toggleUpdate();
        }
        onObjectRemoved: (_, obj) => {
            const id = obj.ref.id;
            root.values[id - 1] = undefined;
            root.toggleUpdate();
        }
    }
    // onUpdateChanged: { console.log(root.values) }
}
