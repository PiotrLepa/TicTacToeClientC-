import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Window 2.2

Page {
    id: page

    background: Rectangle {
        color: "#282828"
    }

    Text {
        id: ticTacToeText
        color: "#ffffff"
        text: qsTr("Tic Tac Toe")
        anchors.top: parent.top
        anchors.topMargin: Screen.desktopAvailableHeight / 4.5
        font.pointSize: 40
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
    }

    BlueButton {
        id: buttonSingleplayer
        text: "Singleplayer"
        anchors.top: ticTacToeText.bottom
        anchors.topMargin: 128
        anchors.right: parent.right
        anchors.rightMargin: 32
        anchors.left: parent.left
        anchors.leftMargin: 32
        onClicked: stackView.push("game.qml")
    }

    BlueButton {
        id: buttonMultiplayer
        text: "Multiplayer"
        anchors.right: parent.right
        anchors.rightMargin: 32
        anchors.left: parent.left
        anchors.leftMargin: 32
        anchors.top: buttonSingleplayer.bottom
        anchors.topMargin: 32
        onClicked: stackView.push("gameMultiplayer.qml")
    }
}



/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
