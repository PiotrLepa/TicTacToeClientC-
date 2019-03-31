import QtQuick 2.0
import QtQuick.Controls 2.2
import io.qt.Backend 1.0

Page {
    id: page

    background: Rectangle {
        color: "#282828"
    }

    Backend {
        id: backend
    }


    Text {
        id: searchOpponentText
        color: "#ffffff"
        text: qsTr("Search for an opponent at random")
        anchors.topMargin: 32
        anchors.right: parent.right
        anchors.rightMargin: 32
        anchors.left: parent.left
        anchors.leftMargin: 32
        anchors.top: parent.top
        font.pointSize: 20
        font.bold: true
        wrapMode: Text.WrapAnywhere
    }

    BlueButton {
        id: searchOpponentButton
        text: "Search"
        anchors.top: searchOpponentText.bottom
        anchors.topMargin: 32
        anchors.right: parent.right
        anchors.rightMargin: 32
        anchors.left: parent.left
        anchors.leftMargin: 32
        onClicked: backend.searchOpponentClicked
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
