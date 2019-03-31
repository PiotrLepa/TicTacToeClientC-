import QtQuick 2.0
import QtQuick.Window 2.2

Grid {
    id: board
    spacing: 5
    rows: 3
    columns: 3

    signal fieldClicked()
    signal gameEnded(var status)

    Field {
        id: field0
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                doOnClick(field0, "0")
            }
        }
    }

    Field {
        id: field1
        MouseArea {
            anchors.fill: parent
            onClicked: {
                doOnClick(field1, "1")
            }
        }
    }

    Field {
        id: field2
        MouseArea {
            anchors.fill: parent
            onClicked: {
                doOnClick(field2, "2")
            }
        }
    }

    Field {
        id: field3
        MouseArea {
            anchors.fill: parent
            onClicked: {
                doOnClick(field3, "3")
            }
        }
    }

    Field {
        id: field4
        MouseArea {
            anchors.fill: parent
            onClicked: {
                doOnClick(field4, "4")
            }
        }
    }

    Field {
        id: field5
        MouseArea {
            anchors.fill: parent
            onClicked: {
                doOnClick(field5, "5")
            }
        }
    }

    Field {
        id: field6
        MouseArea {
            anchors.fill: parent
            onClicked: {
                doOnClick(field6, "6")
            }
        }
    }

    Field {
        id: field7
        MouseArea {
            anchors.fill: parent
            onClicked: {
                doOnClick(field7, "7")
            }
        }
    }

    Field {
        id: field8
        MouseArea {
            anchors.fill: parent
            onClicked: {
                doOnClick(field8, "8")
            }
        }
    }

    function getBoardSize() {
        var x = Screen.desktopAvailableHeight
        return x / 2 + 6 - 30
    }

    function doOnClick(fieldId, fieldIndex) {
        console.log("clicked field index: ", fieldIndex)
        if (fieldId.text === "") {
            board.enabled = false
            backend.fieldClicked(fieldIndex)
            setMark(backend.playerMark, fieldIndex)
            checkEndGame()
            fieldClicked()
        }
    }

    function setMark(mark, index) {
        if (board.children[index].text === "") {
            if (mark === "X") {
                board.children[index].textColor = "#ee6363"
            } else {
                board.children[index].textColor = "#54b8fd"
            }

            board.children[index].text = mark
        }
    }

    function checkEndGame() {
        console.log("checkEndGame")
        if (checkFields(field0, field1, field2)) {
            doWin(field0, field1, field2)
        } else if (checkFields(field3, field4, field5)) {
            doWin(field3, field4, field5)
        } else if (checkFields(field6, field7, field8)) {
            doWin(field6, field7, field8)
        } else if (checkFields(field0, field3, field6)) {
            doWin(field0, field3, field6)
        } else if (checkFields(field1, field4, field7)) {
            doWin(field1, field4, field7)
        } else if (checkFields(field2, field5, field8)) {
            doWin(field2, field5, field8)
        } else if (checkFields(field0, field4, field8)) {
            doWin(field0, field4, field8)
        } else if (checkFields(field2, field4, field6)) {
            doWin(field2, field4, field6)
        } else if (checkDraw()) {
            resetGame()
            gameEnded("draw")
        }
    }

    function checkDraw() {
        var isDraw = true;
        for (var i=0; i<9; i++) {
            if (board.children[i].text === "") isDraw = false;
        }
        return isDraw
    }

    function checkFields(fieldId1, fieldId2, fieldId3) {
       if (fieldId1.text !== ""
               && fieldId1.text === fieldId2.text
               && fieldId1.text === fieldId3.text) {

           console.log("won: ",fieldId1.text)
           return true
       }
       return false
    }

    function doWin(fieldId1, fieldId2, fieldId3)  {
        console.log("won: ", fieldId1.text)
        fieldId1.textColor = "white"
        fieldId2.textColor = "white"
        fieldId3.textColor = "white"
        gameEnded(fieldId1.text)
        resetGame()
    }

    function resetGame() {
        console.log("resetGame started")
        delay(function() {
            console.log("resetBoard after delay")
            resetFields()
            backend.resetGame()
        }, 2000)
    }

    function resetFields() {
        field0.text = "";
        field1.text = "";
        field2.text = "";
        field3.text = "";
        field4.text = "";
        field5.text = "";
        field6.text = "";
        field7.text = "";
        field8.text = "";
    }

    Timer {
        id: timer
        running: false
        repeat: false

        property var callback

        onTriggered: callback()
    }

    function delay(callback, delay)
    {
        if (timer.running) {
            console.error("nested calls to setTimeout are not supported!");
            return;
        }
        timer.callback = callback;
        timer.interval = delay + 1;
        timer.running = true;
    }

}
