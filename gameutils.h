#ifndef GAMEUTILS_H
#define GAMEUTILS_H

#include <QString>

class GameUtils
{
private:
    static QString& gameId()
    {
        static QString gameId = "";
        return gameId;
    }

    static QString& playerMark()
    {
        static QString playerMark = "";
        return playerMark;
    }

    static QString& gameLevel()
    {
        static QString gameLevel = "MEDIUM";
        return gameLevel;
    }

    static bool& isMultiplayerGame()
    {
        static bool isMultiplayerGame = false;
        return isMultiplayerGame;
    }

    static QString& opponentIndex()
    {
        static QString opponentIndex = "";
        return opponentIndex;
    }
public:
    static void setGameId(const QString _gameId)
    {
        gameId() = _gameId;
    }
    static const QString& getGameId()
    {
        return gameId();
    }

    static void setPlayerMark(const QString _playerMark)
    {
        playerMark() = _playerMark;
    }
    static const QString& getPlayerMark()
    {
        return playerMark();
    }

    static void setGameLevel(const QString _gameLevel)
    {
        gameLevel() = _gameLevel;
    }
    static const QString& getGameLevel()
    {
        return gameLevel();
    }

    static void setIsMultiplayerGame(const bool _isMultiplayerGame)
    {
        isMultiplayerGame() = _isMultiplayerGame;
    }
    static const bool& getIsMultiplayerGame()
    {
        return isMultiplayerGame();
    }

    static void setOpponentIndex(const QString _opponentIndex)
    {
        opponentIndex() = _opponentIndex;
    }
    static const QString& getOpponentIndex()
    {
        return opponentIndex();
    }
};

#endif // GAMEUTILS_H


