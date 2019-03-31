import QtQuick 2.0
import QtQuick.Window 2.2

Item {
    id: container
    width: parent.width / 3
    height: parent.width / 3

    property alias text: text.text
    property alias textColor: text.color
    signal onClickedSignal

    Rectangle {
        id: rectangle
        color: "#353535"
        anchors.fill: parent
    }

    Text {
        id: text
        text: ""
        color: "white"
        font.pointSize: getCellSize() - 50
        anchors.centerIn: parent
    }


    function getCellSize() {
        var x = Screen.desktopAvailableHeight
        return x / 6 - 10
    }
}
