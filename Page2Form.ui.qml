import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    width: 600
    height: 400

    title: qsTr("Page 2")

    RoundButton {
        id: roundButton
        x: 0
        y: 0
        width: 600
        height: 400
        text: "+"
    }
}
