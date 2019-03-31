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
        onGameStatusChanged: {
            console.log("gameStatus: ", newStatus, ", mark: ", mark, ", index: ", fieldIndex)
            if (newStatus === "MULTIPLAYER_GAME_CREATED") {
                if (backend.playerMark === "X") {
                    setCurrentTurnText(qsTr("Your turn"))
                    board.enabled = true
                } else {
                    setCurrentTurnText(qsTr("Opponent turn"))
                    board.enabled = false
                }
            } else if (newStatus == "GAME_RESETED") {
                setCurrentTurnText(qsTr("Your turn"))
                board.enabled = true
            }else if (newStatus == "MULTIPLAYER_OPPONENT_MOVE") {
                board.setMark(mark, fieldIndex)
                setCurrentTurnText(qsTr("Your turn"))
                board.checkEndGame()
                board.enabled = true
            }
        }
        onPlayerMarkChanged: {
            console.log("onPlayerMarkChanged: ", newPlayerMark)
            yourMarkText.text = newPlayerMark
        }

        onStatusChanged: {
            if (newStatus === "CONNECTED") {
                backend.startNewMultiplayerGame()
            }
        }
    }

    Row {
        id: markRow
        anchors.topMargin: 32
        spacing: 10
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            text: qsTr("Your mark: ")
            font.pointSize: 30
            color: "white"
        }

        Text {
            id: yourMarkText
            font.pointSize: 30
            color: text === "X" ? "#ee6363" : "#54b8fd"
        }
    }

    Row {
        id: statusRow
        anchors.topMargin: 32
        spacing: 10
        anchors.top: markRow.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            text: qsTr("Status: ")
            font.pointSize: 30
            color: "white"
        }

        Text {
            id: gameStatusText
            text: qsTr("Wait for opponent")
            font.pointSize: 30
            color: "#54b8fd"
        }
    }

    PartialScoreboard {
        id: partialScoreboard
        anchors.topMargin: 32
        width: parent.width
        anchors.top: statusRow.bottom
    }


    BoardView {
        id: board
        height: width
        anchors.top: partialScoreboard.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 32
        onFieldClicked: {
            setCurrentTurnText(qsTr("Opponent turn"))
        }
        onGameEnded: {
            console.log("backend.playerMark: ", backend.playerMark, " status: ", status)
            if (status === "draw") partialScoreboard.drawsCount = partialScoreboard.drawsCount*1 + 1
            else if (status === backend.playerMark) partialScoreboard.wonCount = partialScoreboard.wonCount*1 + 1
            else partialScoreboard.lostCount = partialScoreboard.lostCount*1 + 1
        }
    }


    function setCurrentTurnText(text) {

        if (yourMarkText.text === "X") {
            if (text === "Opponent turn") {
                gameStatusText.color = "#54b8fd"
            } else {
                gameStatusText.color = "#ee6363"
            }
        } else {
            if (text === "Opponent turn") {
                gameStatusText.color = "#ee6363"
            } else {
                gameStatusText.color = "#54b8fd"
            }
        }

        gameStatusText.text = text
    }

    function gameLevelButtonClicked(clickedButton, gameLevel) {
        if (clickedButton.textColor === "white") return

        backend.gameLevelClicked(gameLevel)
        board.resetFields()

        gameLevelEasy.textColor = "white"
        gameLevelMedium.textColor = "white"
        gameLevelHard.textColor = "white"

        clickedButton.textColor = "#353535"
    }
}
