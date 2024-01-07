// import 'package:flutter/material.dart';

// void main() => runApp(GameApp());

// class GameApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Tic-Tac-Toe',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: GameScreen(),
//     );
//   }
// }

// class GameScreen extends StatefulWidget {
//   @override
//   _GameScreenState createState() => _GameScreenState();
// }

// class _GameScreenState extends State<GameScreen> {
//   late List<List<String>> _board;
//   late String _currentPlayer;
//   late String _winner;
//   late bool _gameOver;

//   @override
//   void initState() {
//     super.initState();
//     _startNewGame();
//   }

//   void _startNewGame() {
//     setState(() {
//       _board = List.generate(3, (_) => List.filled(3, ''));
//       _currentPlayer = 'X';
//       _winner = '';
//       _gameOver = false;
//     });
//   }

//   void _makeMove(int row, int col) {
//     if (_board[row][col] == '' && !_gameOver) {
//       setState(() {
//         _board[row][col] = _currentPlayer;
//         _checkWinner(row, col);
//         _togglePlayer();
//       });
//     }
//   }

//   void _checkWinner(int row, int col) {
//     String player = _board[row][col];

//     // Check rows
//     for (int i = 0; i < 3; i++) {
//       if (_board[i][col] != player) break;
//       if (i == 2) {
//         _gameOver = true;
//         _winner = player;
//         _showWinnerDialog(player);
//         return;
//       }
//     }

//     // Check columns
//     for (int i = 0; i < 3; i++) {
//       if (_board[row][i] != player) break;
//       if (i == 2) {
//         _gameOver = true;
//         _winner = player;
//         _showWinnerDialog(player);
//         return;
//       }
//     }

//     // Check diagonal (top-left to bottom-right)
//     if (row == col) {
//       for (int i = 0; i < 3; i++) {
//         if (_board[i][i] != player) break;
//         if (i == 2) {
//           _gameOver = true;
//           _winner = player;
//           _showWinnerDialog(player);
//           return;
//         }
//       }
//     }

//     // Check diagonal (top-right to bottom-left)
//     if (row + col == 2) {
//       for (int i = 0; i < 3; i++) {
//         if (_board[i][2 - i] != player) break;
//         if (i == 2) {
//           _gameOver = true;
//           _winner = player;
//           _showWinnerDialog(player);
//           return;
//         }
//       }
//     }

//     // Check for a draw
//     bool isBoardFull = true;
//     for (int i = 0; i < 3; i++) {
//       for (int j = 0; j < 3; j++) {
//         if (_board[i][j] == '') {
//           isBoardFull = false;
//           break;
//         }
//       }
//     }
//     if (isBoardFull) {
//       _gameOver = true;
//       _winner = 'Draw';
//       _showWinnerDialog(_winner);
//     }
//   }

//   void _togglePlayer() {
//     _currentPlayer = (_currentPlayer == 'X') ? 'O' : 'X';
//   }

//   void _showWinnerDialog(String winner) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: Text('Game Over'),
//         content: Text('$winner wins the game!'),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _startNewGame();
//             },
//             child: Text('New Game'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tic-Tac-Toe'),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           double gameSize = constraints.maxWidth * 0.8;
//           double cellSize = gameSize / 3;

//           return SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     (_gameOver)
//                         ? 'Winner: $_winner'
//                         : 'Current Player: $_currentPlayer',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: 20),
//                   FractionallySizedBox(
//                     widthFactor: 0.8,
//                     child: AspectRatio(
//                       aspectRatio: 1.0,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black),
//                         ),
//                         child: GridView.builder(
//                           shrinkWrap: true,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             childAspectRatio: 1.0,
//                           ),
//                           itemCount: 9,
//                           itemBuilder: (context, index) {
//                             int row = index ~/ 3;
//                             int col = index % 3;
//                             return GestureDetector(
//                               onTap: () => _makeMove(row, col),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.black),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     _board[row][col],
//                                     style: TextStyle(fontSize: cellSize * 0.4),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     child: Text('New Game'),
//                     onPressed: _startNewGame,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() => runApp(GameApp());

// class GameApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Tic-Tac-Toe',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: GameScreen(),
//     );
//   }
// }

// class GameScreen extends StatefulWidget {
//   @override
//   _GameScreenState createState() => _GameScreenState();
// }

// class _GameScreenState extends State<GameScreen>
//     with SingleTickerProviderStateMixin {
//   late List<List<String>> _board;
//   late String _currentPlayer;
//   late String _winner;
//   late bool _gameOver;
//   late AnimationController _controller;
//   late Animation<double> _fadeInAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _startNewGame();
//     _controller = AnimationController(
//       duration: Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _startNewGame() {
//     setState(() {
//       _board = List.generate(3, (_) => List.filled(3, ''));
//       _currentPlayer = 'X';
//       _winner = '';
//       _gameOver = false;
//     });
//   }

//   void _makeMove(int row, int col) {
//     if (_board[row][col] == '' && !_gameOver) {
//       setState(() {
//         _board[row][col] = _currentPlayer;
//         _checkWinner(row, col);
//         _togglePlayer();
//       });
//     }
//   }

//   void _checkWinner(int row, int col) {
//     String player = _board[row][col];

//     // Check rows
//     for (int i = 0; i < 3; i++) {
//       if (_board[i][col] != player) break;
//       if (i == 2) {
//         _gameOver = true;
//         _winner = player;
//         _showWinnerDialog(player);
//         return;
//       }
//     }

//     // Check columns
//     for (int i = 0; i < 3; i++) {
//       if (_board[row][i] != player) break;
//       if (i == 2) {
//         _gameOver = true;
//         _winner = player;
//         _showWinnerDialog(player);
//         return;
//       }
//     }

//     // Check diagonal (top-left to bottom-right)
//     if (row == col) {
//       for (int i = 0; i < 3; i++) {
//         if (_board[i][i] != player) break;
//         if (i == 2) {
//           _gameOver = true;
//           _winner = player;
//           _showWinnerDialog(player);
//           return;
//         }
//       }
//     }

//     // Check diagonal (top-right to bottom-left)
//     if (row + col == 2) {
//       for (int i = 0; i < 3; i++) {
//         if (_board[i][2 - i] != player) break;
//         if (i == 2) {
//           _gameOver = true;
//           _winner = player;
//           _showWinnerDialog(player);
//           return;
//         }
//       }
//     }

//     // Check for a draw
//     bool isBoardFull = true;
//     for (int i = 0; i < 3; i++) {
//       for (int j = 0; j < 3; j++) {
//         if (_board[i][j] == '') {
//           isBoardFull = false;
//           break;
//         }
//       }
//     }
//     if (isBoardFull) {
//       _gameOver = true;
//       _winner = 'Draw';
//       _showWinnerDialog(_winner);
//     }
//   }

//   void _togglePlayer() {
//     _currentPlayer = (_currentPlayer == 'X') ? 'O' : 'X';
//   }

//   void _showWinnerDialog(String winner) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: Text('Game Over'),
//         content: Text('$winner wins the game!'),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _startNewGame();
//             },
//             child: Text('New Game'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBoardCell(int row, int col, double cellSize) {
//     return GestureDetector(
//       onTap: () => _makeMove(row, col),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.black),
//         ),
//         child: Center(
//           child: AnimatedOpacity(
//             opacity: (_board[row][col] == '') ? 0.0 : 1.0,
//             duration: Duration(milliseconds: 500),
//             curve: Curves.easeIn,
//             child: Text(
//               _board[row][col],
//               style: TextStyle(fontSize: cellSize * 0.4),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tic-Tac-Toe'),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           double gameSize = constraints.maxWidth * 0.8;
//           double cellSize = gameSize / 3;

//           return SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     (_gameOver)
//                         ? 'Winner: $_winner'
//                         : 'Current Player: $_currentPlayer',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: 20),
//                   FractionallySizedBox(
//                     widthFactor: 0.8,
//                     child: AspectRatio(
//                       aspectRatio: 1.0,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black),
//                         ),
//                         child: GridView.builder(
//                           shrinkWrap: true,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             childAspectRatio: 1.0,
//                           ),
//                           itemCount: 9,
//                           itemBuilder: (context, index) {
//                             int row = index ~/ 3;
//                             int col = index % 3;
//                             return SizeTransition(
//                               sizeFactor: _fadeInAnimation,
//                               child: _buildBoardCell(row, col, cellSize),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     child: Text('New Game'),
//                     onPressed: _startNewGame,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }