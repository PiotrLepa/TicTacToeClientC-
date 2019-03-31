import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

ApplicationWindow {
    id: window
    visible: true
    width: 600
    height: 1280
    title: qsTr("Tic Tac Toe")

    StackView {
        id: stackView
        initialItem: "start.qml"
        anchors.fill: parent
    }
}
