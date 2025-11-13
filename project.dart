import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';

// --- 1. Sudoku Solver and Generator Class ---
class Sudoku {
  List<List<int>> board;
  final int size = 9;
  final int boxSize = 3;
  final Random random = Random();

  Sudoku() : board = List.generate(9, (_) => List.filled(9, 0));

  bool isValid(List<List<int>> currentBoard, int row, int col, int num) {
    if (num == 0) return true;
    for (int i = 0; i < size; i++) {
      if ((currentBoard[row][i] == num && i != col) || (currentBoard[i][col] == num && i != row)) return false;
    }
    final int startRow = (row ~/ boxSize) * boxSize;
    final int startCol = (col ~/ boxSize) * boxSize;
    for (int r = 0; r < boxSize; r++) {
      for (int c = 0; c < boxSize; c++) {
        if (currentBoard[startRow + r][startCol + c] == num && (startRow + r != row || startCol + c != col)) return false;
      }
    }
    return true;
  }

  bool _findEmptyCell(List<List<int>> grid, List<int> pos) {
    for (int r = 0; r < size; r++) {
      for (int c = 0; c < size; c++) {
        if (grid[r][c] == 0) {
          pos[0] = r;
          pos[1] = c;
          return true;
        }
      }
    }
    return false;
  }

  bool solve(List<List<int>> grid) {
    final List<int> pos = [0, 0];
    if (!_findEmptyCell(grid, pos)) return true;

    final int row = pos[0];
    final int col = pos[1];
    final List<int> numbers = List<int>.generate(size, (int i) => i + 1)..shuffle(random);

    for (int num in numbers) {
      if (isValid(grid, row, col, num)) {
        grid[row][col] = num;
        if (solve(grid)) return true;
        grid[row][col] = 0;
      }
    }
    return false;
  }

  void generate(int cellsToRemove) {
    board = List<List<int>>.generate(9, (_) => List<int>.filled(9, 0));
    solve(board);
    int removedCount = 0;
    while (removedCount < cellsToRemove) {
      final int r = random.nextInt(size);
      final int c = random.nextInt(size);
      if (board[r][c] != 0) {
        board[r][c] = 0;
        removedCount++;
      }
    }
  }
}

// --- 2. Flutter Game State Management ---
class SudokuGame extends ChangeNotifier {
  final Sudoku _solver = Sudoku();
  List<List<int>> _currentBoard = List<List<int>>.generate(9, (_) => List<int>.filled(9, 0));
  List<List<bool>> _isInitial = List<List<bool>>.generate(9, (_) => List<bool>.filled(9, false));
  bool _isSolved = false;
  String _message = 'Generate a puzzle to start!';

  List<List<int>> get board => _currentBoard;
  List<List<bool>> get isInitial => _isInitial;
  bool get isSolved => _isSolved;
  String get message => _message;

  void generateNewPuzzle(int difficulty) {
    _solver.generate(difficulty);
    _currentBoard = List<List<int>>.from(_solver.board.map<List<int>>((List<int> row) => List<int>.from(row)));
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        _isInitial[r][c] = _currentBoard[r][c] != 0;
      }
    }
    _isSolved = false;
    _message = 'Puzzle generated. Start playing!';
    notifyListeners();
  }

  void updateCell(int row, int col, int value) {
    if (_isInitial[row][col]) {
      _message = 'Cannot change initial number.';
      notifyListeners();
      return;
    }
    final List<List<int>> tempBoard = List<List<int>>.from(_currentBoard.map<List<int>>((List<int> r) => List<int>.from(r)));
    tempBoard[row][col] = value;

    if (_solver.isValid(tempBoard, row, col, value)) {
      _currentBoard[row][col] = value;
      _message = value == 0 ? 'Cell cleared.' : 'Move placed successfully.';
    } else {
      _message = 'Invalid move! Check row, column, and box rules.';
    }

    _checkWinCondition();
    notifyListeners();
  }

  void _checkWinCondition() {
    bool boardIsFull = true;
    for (int r = 0; r < 9 && boardIsFull; r++) {
      for (int c = 0; c < 9; c++) {
        if (_currentBoard[r][c] == 0) {
          boardIsFull = false;
          break;
        }
      }
    }

    if (boardIsFull) {
      bool fullyValid = true;
      for (int r = 0; r < 9 && fullyValid; r++) {
        for (int c = 0; c < 9; c++) {
          if (!_solver.isValid(_currentBoard, r, c, _currentBoard[r][c])) {
            fullyValid = false;
            break;
          }
        }
      }
      _isSolved = fullyValid;
      _message = _isSolved ? '🎉 Puzzle Solved!' : 'Board full, but invalid!';
    } else {
      _isSolved = false;
    }
  }
}

// --- 3. Flutter Widget Presentation ---
void main() => runApp(const SudokuApp());

class SudokuApp extends StatelessWidget {
  const SudokuApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Sudoku Puzzle',
    theme: ThemeData(primarySwatch: Colors.indigo, visualDensity: VisualDensity.adaptivePlatformDensity),
    home: ChangeNotifierProvider<SudokuGame>(
      create: (BuildContext context) => SudokuGame(),
      builder: (BuildContext context, Widget? child) => const SudokuScreen(),
    ),
  );
}

class SudokuScreen extends StatelessWidget {
  const SudokuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SudokuGame game = context.watch<SudokuGame>();
    return Scaffold(
      appBar: AppBar(title: const Text('Sudoku Puzzle'), backgroundColor: Colors.indigo, centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(game.message, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: game.isSolved ? Colors.green.shade700 : Colors.black87, fontWeight: FontWeight.bold)),
              ),
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
                  child: Column(
                    children: List<Widget>.generate(9, (int r) => Expanded(
                      child: Row(
                        children: List<Widget>.generate(9, (int c) => Expanded(
                          child: SudokuCell(
                            row: r, col: c, value: game.board[r][c], isInitial: game.isInitial[r][c],
                            onTap: game.isInitial[r][c] ? null : () => _showInput(context, game, r, c),
                          ),
                        )),
                      ),
                    )),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () => game.generateNewPuzzle(40),
                    icon: const Icon(Icons.refresh), label: const Text('New Puzzle'),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), textStyle: const TextStyle(fontSize: 16)),
                  ),
                  ElevatedButton.icon(
                    onPressed: game.isSolved ? null : () => _showInput(context, game),
                    icon: const Icon(Icons.edit), label: const Text('Enter Move'),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), textStyle: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void _showInput(BuildContext context, SudokuGame game, [int? initialRow, int? initialCol]) {
    final TextEditingController rowController = TextEditingController(text: initialRow != null ? (initialRow + 1).toString() : '');
    final TextEditingController colController = TextEditingController(text: initialCol != null ? (initialCol + 1).toString() : '');
    final TextEditingController numController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Enter Move'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(controller: rowController, decoration: const InputDecoration(labelText: 'Row (1-9)'), keyboardType: TextInputType.number, maxLength: 1, readOnly: initialRow != null),
            TextField(controller: colController, decoration: const InputDecoration(labelText: 'Column (1-9)'), keyboardType: TextInputType.number, maxLength: 1, readOnly: initialCol != null),
            TextField(controller: numController, decoration: const InputDecoration(labelText: 'Value (1-9 or 0 to clear)'), keyboardType: TextInputType.number, maxLength: 1),
          ],
        ),
        actions: <Widget>[
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.of(dialogContext).pop()),
          ElevatedButton(
            child: const Text('Place'),
            onPressed: () {
              final int? r = int.tryParse(rowController.text);
              final int? c = int.tryParse(colController.text);
              final int? v = int.tryParse(numController.text);
              if (r != null && c != null && v != null && r >= 1 && r <= 9 && c >= 1 && c <= 9 && v >= 0 && v <= 9) {
                game.updateCell(r - 1, c - 1, v);
                Navigator.of(dialogContext).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid input! Check ranges.'), backgroundColor: Colors.red));
              }
            },
          ),
        ],
      ),
    );
  }
}

class SudokuCell extends StatelessWidget {
  final int row;
  final int col;
  final int value;
  final bool isInitial;
  final VoidCallback? onTap;

  const SudokuCell({super.key, required this.row, required this.col, required this.value, required this.isInitial, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isBlockBorderRow = row % 3 == 0;
    final bool isBlockBorderCol = col % 3 == 0;

    return Container(
      decoration: BoxDecoration(
        color: isInitial ? Colors.blueGrey.shade100 : Colors.white,
        border: Border(
          top: BorderSide(width: isBlockBorderRow && row != 0 ? 2.0 : 0.5, color: Colors.black),
          left: BorderSide(width: isBlockBorderCol && col != 0 ? 2.0 : 0.5, color: Colors.black),
          right: const BorderSide(width: 0.5, color: Colors.black),
          bottom: const BorderSide(width: 0.5, color: Colors.black),
        ),
      ),
      alignment: Alignment.center,
      child: InkWell(
        onTap: onTap,
        child: Text(
          value == 0 ? '' : value.toString(),
          style: TextStyle(
            fontSize: 22,
            fontWeight: isInitial ? FontWeight.bold : FontWeight.w500,
            color: isInitial ? Colors.black87 : Colors.indigo.shade700,
          ),
        ),
      ),
    );
  }
}