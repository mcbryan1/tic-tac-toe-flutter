import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:test1/text_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Tic Tac Toe State
  List<String> _board = ['', '', '', '', '', '', '', '', ''];
  String _player = 'X';
  String _winner = '';
  int _turns = 0;

  void _showWinnerDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          // backgroundColor: Colors.green,
          title: const MyText(
            text: 'Winner',
            fontWeight: FontWeight.bold,
          ),
          content: MyText(text: 'Player $_winner won the game'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _reset();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void _reset() {
    setState(() {
      _board = ['', '', '', '', '', '', '', '', ''];
      _player = 'X';
      _winner = '';
      _turns = 0;
    });
  }

  void _play(int index) {
    if (_winner != '' || _board[index] != '') {
      return;
    }

    setState(() {
      _board[index] = _player;
      _turns++;
      _player = _player == 'X' ? 'O' : 'X';
      _winner = _checkWinner();
    });
  }

  String _checkWinner() {
    // Check Rows
    for (int i = 0; i < 3; i++) {
      if (_board[i * 3] != '' &&
          _board[i * 3] == _board[i * 3 + 1] &&
          _board[i * 3] == _board[i * 3 + 2]) {
        _showWinnerDialog();
        return _board[i * 3];
      }
    }

    // Check Columns
    for (int i = 0; i < 3; i++) {
      if (_board[i] != '' &&
          _board[i] == _board[i + 3] &&
          _board[i] == _board[i + 6]) {
        _showWinnerDialog();
        return _board[i];
      }
    }

    // Check Diagonals
    if (_board[0] != '' && _board[0] == _board[4] && _board[0] == _board[8]) {
      _showWinnerDialog();
      return _board[0];
    }
    if (_board[2] != '' && _board[2] == _board[4] && _board[2] == _board[6]) {
      _showWinnerDialog();
      return _board[2];
    }

    // Check Draw
    if (_turns == 9) {
      return 'Draw';
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reset,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _winner == 'Draw' && _winner != " "
                ? Container()
                : MyText(
                    text: 'Player $_player\'s turn',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MyText(
                  text: 'Draw',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _reset,
                ),
              ],
            ),

            MyText(
              text: _winner == 'Draw' ? 'Game Draw' : 'Winner: $_winner',
              fontSize: 24,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(9, (index) {
                  return GestureDetector(
                    onTap: () => _play(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _board[index] == 'X'
                            ? Colors.red
                            : _board[index] == 'O'
                                ? Colors.blue
                                : Colors.grey,
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(
                          _board[index],
                          style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              // If the player is X, make the text red
                              color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Play Button
          ],
        ),
      ),
    );
  }
}