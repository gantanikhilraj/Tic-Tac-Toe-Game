import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class Multiplayer extends StatefulWidget {
  static const String id = 'multiplayer_screen';

  const Multiplayer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<Multiplayer>
    with SingleTickerProviderStateMixin {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;
  final ConfettiController _confettiController = ConfettiController();

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    setState(() {
      _board = List.generate(3, (_) => List.filled(3, ''));
      _currentPlayer = 'X';
      _winner = '';
      _gameOver = false;
    });
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] == '' && !_gameOver) {
      setState(() {
        _board[row][col] = _currentPlayer;
        _checkWinner(row, col);
        _togglePlayer();
        _playTapSound();
      });
    }
  }

  void _checkWinner(int row, int col) {
    String player = _board[row][col];

    // Check rows
    for (int i = 0; i < 3; i++) {
      if (_board[i][col] != player) break;
      if (i == 2) {
        _gameOver = true;
        _winner = player;
        _showWinnerDialog(player);
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (_board[row][i] != player) break;
      if (i == 2) {
        _gameOver = true;
        _winner = player;
        _showWinnerDialog(player);
        return;
      }
    }

    // Check diagonal (top-left to bottom-right)
    if (row == col) {
      for (int i = 0; i < 3; i++) {
        if (_board[i][i] != player) break;
        if (i == 2) {
          _gameOver = true;
          _winner = player;
          _showWinnerDialog(player);
          return;
        }
      }
    }

    // Check diagonal (top-right to bottom-left)
    if (row + col == 2) {
      for (int i = 0; i < 3; i++) {
        if (_board[i][2 - i] != player) break;
        if (i == 2) {
          _gameOver = true;
          _winner = player;
          _showWinnerDialog(player);
          return;
        }
      }
    }

    // Check for a draw
    bool isBoardFull = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == '') {
          isBoardFull = false;
          break;
        }
      }
    }
    if (isBoardFull) {
      _gameOver = true;
      _winner = 'Draw';
      _showWinnerDialog(_winner);
    }
  }

  void _togglePlayer() {
    _currentPlayer = (_currentPlayer == 'X') ? 'O' : 'X';
  }

  void _showWinnerDialog(String winner) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: Text('$winner wins the game!'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _confettiController.stop();
              _startNewGame();
            },
            child: const Text('New Game'),
          ),
          ElevatedButton(
            onPressed: () {
              _confettiController.stop();
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );

    if (winner != 'Draw') {
      _confettiController.play();
    }

    if (winner == 'X') {
    } else if (winner == 'O') {}
  }

  void _playTapSound() {
    // Play tap sound here
  }

  Widget _buildBoardCell(int row, int col, double cellSize) {
    return GestureDetector(
      onTap: () => _makeMove(row, col),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: AnimatedOpacity(
            opacity: (_board[row][col] == '') ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeIn,
            child: Text(
              _board[row][col],
              style: TextStyle(fontSize: cellSize * 0.4),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double gameSize = constraints.maxWidth * 0.8;
          double cellSize = gameSize / 3;

          return SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        (_gameOver)
                            ? 'Winner: $_winner'
                            : 'Current Player: $_currentPlayer',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: FractionallySizedBox(
                          widthFactor: 1.0,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemBuilder: (context, index) {
                                  int row = index ~/ 3;
                                  int col = index % 3;
                                  return _buildBoardCell(row, col, cellSize);
                                },
                                itemCount: 9,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _startNewGame();
                        },
                        child: const Text('New Game'),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  blastDirection: -pi / 2, // Adjust the angle if needed
                  maxBlastForce: 50,
                  minBlastForce: 2,
                  emissionFrequency: 0.05,
                  numberOfParticles: 50,
                  gravity: 0.5,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
