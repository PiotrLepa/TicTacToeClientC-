import QtQuick 2.0

Grid {
    spacing: 5
    rows: 2
    columns: 3

    property alias wonCount: textWonCount.text
    property alias drawsCount: textDrawsCount.text
    property alias lostCount: textLostCount.text

    Text {
        id: textWon
        width: parent.width / 3
        text: qsTr("Won")
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 30
        color: "white"
    }

    Text {
        id: textDraws
        width: parent.width / 3
        text: qsTr("Draws")
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 30
        color: "white"
    }

    Text {
        id: textLost
        width: parent.width / 3
        text: qsTr("Lost")
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 30
        color: "white"
    }

    Text {
        id: textWonCount
        width: parent.width / 3
        text: "0"
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 30
        color: "white"
    }

    Text {
        id: textDrawsCount
        width: parent.width / 3
        text: "0"
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 30
        color: "white"
    }

    Text {
        id: textLostCount
        width: parent.width / 3
        text: "0"
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 30
        color: "white"
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
