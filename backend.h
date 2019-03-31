#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include "clientstuff.h"

class Backend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool currentStatus READ getStatus NOTIFY statusChanged)
    Q_PROPERTY(QString playerMark READ getPlayerMark NOTIFY playerMarkChanged)

public:
    explicit Backend(QObject *parent = nullptr);
    bool getStatus();
    QString getPlayerMark();

signals:
    void statusChanged(QString newStatus);
    void playerMarkChanged(QString newPlayerMark);
    void gameStatusChanged(QString newStatus, QString mark, int fieldIndex);
    void someError(QString err);
    void someMessage(QString msg);

public slots:
    void setStatus(bool newStatus);
    void receivedSomething(QString msg);
    void gotError(QAbstractSocket::SocketError err);
    void startNewGame();
    void startNewMultiplayerGame();
    void disconnectClicked();
    void fieldClicked(QString fieldIndex);
    void resetGame();
    void gameLevelClicked(QString gameLevel);
    void searchOpponentClicked();

private:
    ClientStuff *client;
    const QRegExp gameCreatedRegex;
    const QRegExp gameCreatedAiMoveRegex;
    const QRegExp multiplayerGameCreatedRegex;
    const QRegExp multiplayerOpponentMoveRegex;
    const QRegExp aiMoveRegex;

    void sendToServer(QString msg);
};

#endif // BACKEND_H
