import 'package:flutter/material.dart';

class PalywithAI extends StatelessWidget {
  static const String id = 'platwithAI';

  const PalywithAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic-Tac-Toe',
      theme: ThemeData.light(),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late bool _gameOver;
  late bool _isAgainstAI;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    setState(() {
      _board = List.generate(3, (_) => List.filled(3, ''));
      _currentPlayer = 'X';
      _gameOver = false;
      _isAgainstAI = true; // Set to false if playing against another player
    });

    if (_isAgainstAI && _currentPlayer == 'O') {
      _makeAIMove();
    }
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] == '' && !_gameOver) {
      setState(() {
        _board[row][col] = _currentPlayer;
        _checkWinner(row, col);
        _togglePlayer();
        if (_isAgainstAI && _currentPlayer == 'O') {
          _makeAIMove();
        }
      });
    }
  }

  void _makeAIMove() {
    // Simple AI move - selects the first available empty cell
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (_board[row][col] == '') {
          _makeMove(row, col);
          return;
        }
      }
    }
  }

  void _checkWinner(int row, int col) {
    String player = _board[row][col];

    // Check rows
    for (int i = 0; i < 3; i++) {
      if (_board[i][col] != player) break;
      if (i == 2) {
        _gameOver = true;
        _showWinnerDialog(player);
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (_board[row][i] != player) break;
      if (i == 2) {
        _gameOver = true;
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
      _showWinnerDialog('Draw');
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
        title: Text('Game Over'),
        content:
            Text(winner == 'Draw' ? 'It\'s a draw!' : '$winner wins the game!'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _startNewGame();
            },
            child: Text('New Game'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildBoardCell(int row, int col, double cellSize) {
    return GestureDetector(
      onTap: () => _makeMove(row, col),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            _board[row][col],
            style: TextStyle(fontSize: cellSize * 0.4),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Tic-Tac-Toe'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ 3;
                int col = index % 3;
                return _buildBoardCell(row, col, 80);
              },
              itemCount: 9,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startNewGame,
              child: Text('New Game'),
            ),
          ],
        ),
      ),
    );
  }
}
