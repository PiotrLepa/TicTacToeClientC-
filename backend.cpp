#include "backend.h"
#include "gameutils.h"
#include <QDebug>

Backend::Backend(QObject *parent) : QObject(parent),
  gameCreatedRegex("GAME_CREATED:\\d{13}:[XO]"),
  gameCreatedAiMoveRegex("GAME_CREATED_AI_MOVE:\\d{13}:[XO]:AI_MOVE:[XO]:\\d"),
  multiplayerGameCreatedRegex("MULTIPLAYER_GAME_CREATED:\\d{13}:[XO]:OPPONENT_INDEX:\\d"),
  multiplayerOpponentMoveRegex("MULTIPLAYER_OPPONENT_MOVE:[XO]:\\d"),
  aiMoveRegex("AI_MOVE:[XO]:\\d")
{
    client = new ClientStuff("192.168.0.104", 6547);

    //setStatus(client->get_status());

    connect(client, &ClientStuff::hasReadSome, this, &Backend::receivedSomething);
    connect(client, &ClientStuff::statusChanged, this, &Backend::setStatus);
    // FIXME change this connection to the new syntax
    connect(client->tcpSocket, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(gotError(QAbstractSocket::SocketError)));

    client->connectToServer();
}

void Backend::startNewGame()
{
    qDebug() << "startNewGame started";
    sendToServer("CREATE_NEW_GAME");
}

void Backend::startNewMultiplayerGame()
{
    GameUtils::setIsMultiplayerGame(true);
    sendToServer("SEARCH_OPPONENT");
}

bool Backend::getStatus()
{
    return client->getStatus();
}

QString Backend::getPlayerMark()
{
    return GameUtils::getPlayerMark();
}

void Backend::setStatus(bool newStatus)
{
    qDebug() << "Backend::setStatus new status is:" << newStatus;
    if (newStatus)
    {
        emit statusChanged("CONNECTED");
    }
    else
    {
        emit statusChanged("DISCONNECTED");
    }
}

void Backend::receivedSomething(QString msg)
{
    if (gameCreatedRegex.exactMatch(msg))
    {
        qDebug() << "gameCreatedRegex";
        QStringList list = msg.split(":");
        QString gameId = list[1];
        QString playerMark = list[2];
        qDebug() << "playerMark: " << playerMark;
        GameUtils::setGameId(gameId);
        GameUtils::setPlayerMark(playerMark);
//        emit someMessage(list[0]);
        emit playerMarkChanged(playerMark);
        emit gameStatusChanged(list[0], playerMark, 0);
    }
    else if (gameCreatedAiMoveRegex.exactMatch(msg))
    {
        qDebug() << "gameCreatedAiMoveRegex";
        QStringList list = msg.split(":");
        QString gameId = list[1];
        QString playerMark = list[2];
        qDebug() << "playerMark: " << playerMark;
        GameUtils::setGameId(gameId);
        GameUtils::setPlayerMark(playerMark);
        QString aiMark = list[4];
        int fieldIndex = list[5].toInt();

        emit playerMarkChanged(playerMark);
        emit gameStatusChanged(list[0], aiMark, fieldIndex);
    }
    else if (aiMoveRegex.exactMatch(msg))
    {
        qDebug() << "aiMoveRegex";
        QStringList list = msg.split(":");
        QString aiMark = list[1];
        int fieldIndex = list[2].toInt();
        emit gameStatusChanged(list[0], aiMark, fieldIndex);
    }
    else if (msg == "GAME_RESETED")
    {
        qDebug() << "GAME_RESETED";
        emit gameStatusChanged("GAME_RESETED", "", 0);
    }
    else if (multiplayerGameCreatedRegex.exactMatch(msg))
    {
        qDebug() << "multiplayerGameCreatedRegex";
        QStringList list = msg.split(":");
        QString gameId = list[1];
        QString playerMark = list[2];
        QString opponentIndex = list[4];
        qDebug() << "playerMark: " << playerMark;
        GameUtils::setGameId(gameId);
        GameUtils::setPlayerMark(playerMark);
        GameUtils::setOpponentIndex(opponentIndex);

        emit playerMarkChanged(playerMark);
        emit gameStatusChanged(list[0], playerMark, 0);
    }
    else if (multiplayerOpponentMoveRegex.exactMatch(msg))
    {
        qDebug() << "multiplayerOpponentMoveRegex";
        QStringList list = msg.split(":");
        QString opponentMark = list[1];
        int opponentFieldIndex = list[2].toInt();

        emit gameStatusChanged(list[0], opponentMark, opponentFieldIndex);
    }
}

void Backend::gotError(QAbstractSocket::SocketError err)
{
    qDebug() << "Backend::gotError";
    QString strError = "unknown";
    switch (err)
    {
        case 0:
            strError = "Connection was refused";
            break;
        case 1:
            strError = "Remote host closed the connection";
            break;
        case 2:
            strError = "Host address was not found";
            break;
        case 5:
            strError = "Connection timed out";
            break;
        default:
            strError = "Unknown error";
    }

    emit someError(strError);
}

void Backend::sendToServer(QString msg)
{
    QByteArray arrBlock;
    QDataStream out(&arrBlock, QIODevice::WriteOnly);
    //out.setVersion(QDataStream::Qt_5_10);
    out << quint16(0) << msg;

    out.device()->seek(0);
    out << quint16(arrBlock.size() - sizeof(quint16));

    client->tcpSocket->write(arrBlock);
}

void Backend::disconnectClicked()
{
    client->closeConnection();
}

void Backend::fieldClicked(QString fieldIndex)
{
    QString msgToSend;
    qDebug() << "GameUtils::getIsMultiplayerGame(): " << GameUtils::getIsMultiplayerGame();
    if (GameUtils::getIsMultiplayerGame())
    {
        msgToSend = "PLAYER_MOVE_MULTIPLAYER:" + GameUtils::getGameId() + ":" + GameUtils::getPlayerMark() + ":" + fieldIndex + ":OPPONENT_INDEX:" + GameUtils::getOpponentIndex();
    }
    else
    {
        msgToSend = "PLAYER_MOVE:" + GameUtils::getGameId() + ":" + GameUtils::getPlayerMark() + ":" + fieldIndex + ":" + GameUtils::getGameLevel();
    }
    sendToServer(msgToSend);
}

void Backend::resetGame()
{
    QString msgToSend = "RESET_GAME:" + GameUtils::getGameId();
    sendToServer(msgToSend);
}


void Backend::gameLevelClicked(QString gameLevel)
{
    GameUtils::setGameLevel(gameLevel);
    resetGame();
}


void Backend::searchOpponentClicked()
{
    QString msgToSend = "SEARCH_OPPONENT";
    sendToServer(msgToSend);
}
