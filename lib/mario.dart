import 'package:flutter/material.dart';

// Create A game of mario

class Mario extends StatefulWidget {
  const Mario({Key? key}) : super(key: key);

  @override
  _MarioState createState() => _MarioState();
}

class _MarioState extends State<Mario> {
  // State For Mario Game
  int _mario = 0;
  int _luigi = 0;
  int _turns = 0;
  String _winner = '';

  void _reset() {
    setState(() {
      _mario = 0;
      _luigi = 0;
      _turns = 0;
      _winner = '';
    });
  }

  void _play(int index) {
    if (_winner != '' || _mario == index || _luigi == index) {
      return;
    }

    setState(() {
      _turns++;
      if (_turns % 2 == 0) {
        _luigi = index;
      } else {
        _mario = index;
      }
      _winner = _checkWinner();
    });
  }

  String _checkWinner() {
    // Check Rows
    for (int i = 0; i < 3; i++) {
      if (_mario == i * 3 && _mario == i * 3 + 1 && _mario == i * 3 + 2) {
        return 'Mario';
      }
      if (_luigi == i * 3 && _luigi == i * 3 + 1 && _luigi == i * 3 + 2) {
        return 'Luigi';
      }
    }

    // Check Columns
    for (int i = 0; i < 3; i++) {
      if (_mario == i && _mario == i + 3 && _mario == i + 6) {
        return 'Mario';
      }
      if (_luigi == i && _luigi == i + 3 && _luigi == i + 6) {
        return 'Luigi';
      }
    }

    // Check Diagonals
    if (_mario == 0 && _mario == 4 && _mario == 8) {
      return 'Mario';
    }
    if (_mario == 2 && _mario == 4 && _mario == 6) {
      return 'Mario';
    }
    if (_luigi == 0 && _luigi == 4 && _luigi == 8) {
      return 'Luigi';
    }
    if (_luigi == 2 && _luigi == 4 && _luigi == 6) {
      return 'Luigi';
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mario'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _reset,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _play(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _mario == index
                            ? 'M'
                            : _luigi == index
                                ? 'L'
                                : '',
                        style: const TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Text(
            _winner == ''
                ? _turns % 2 == 0
                    ? 'Luigi\'s Turn'
                    : 'Mario\'s Turn'
                : _winner == 'Draw'
                    ? 'Draw'
                    : 'Winner: $_winner',
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          TextButton(
            onPressed: _reset,
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
