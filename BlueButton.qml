import QtQuick 2.0
import QtQuick.Controls 2.2

RoundButton {
    id: roundButton
    background: Rectangle {
        color: "#54b8fd"
        radius: 30
    }
    font.pointSize: 30

    property alias textColor: content.color

    contentItem: Text {
            id: content
            text: roundButton.text
            font.pointSize: roundButton.font.pointSize
            font.bold: true
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

    height: 60
    width: 600
}
