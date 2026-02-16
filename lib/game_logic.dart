import 'dart:math';

class GameLogic {
  List<List<int>> grid = List.generate(4, (_) => List.filled(4, 0));
  int score = 0;

  void initGame() {
    grid = List.generate(4, (_) => List.filled(4, 0));
    score = 0;
    addNewTile();
    addNewTile();
  }

  void addNewTile() {
    List<List<int>> emptyCells = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (grid[i][j] == 0) emptyCells.add([i, j]);
      }
    }
    if (emptyCells.isNotEmpty) {
      var r = Random().nextInt(emptyCells.length);
      grid[emptyCells[r][0]][emptyCells[r][1]] = Random().nextInt(10) == 0 ? 4 : 2;
    }
  }

  // Función base: Mover a la izquierda
  bool moveLeft() {
    bool moved = false;
    for (int i = 0; i < 4; i++) {
      List<int> row = grid[i].where((e) => e != 0).toList();
      for (int j = 0; j < row.length - 1; j++) {
        if (row[j] == row[j + 1]) {
          row[j] *= 2;
          score += row[j];
          row.removeAt(j + 1);
          moved = true;
        }
      }
      while (row.length < 4) row.add(0);
      if (grid[i].toString() != row.toString()) moved = true;
      grid[i] = row;
    }
    return moved;
  }

  // Rotar matriz 90 grados a la derecha
  void rotate() {
    List<List<int>> newGrid = List.generate(4, (_) => List.filled(4, 0));
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        newGrid[j][3 - i] = grid[i][j];
      }
    }
    grid = newGrid;
  }

  // Movimientos en las 4 direcciones usando rotación
  bool move(String direction) {
    bool moved = false;
    if (direction == 'left') {
      moved = moveLeft();
    } else if (direction == 'right') {
      rotate(); rotate();
      moved = moveLeft();
      rotate(); rotate();
    } else if (direction == 'up') {
      rotate(); rotate(); rotate();
      moved = moveLeft();
      rotate();
    } else if (direction == 'down') {
      rotate();
      moved = moveLeft();
      rotate(); rotate(); rotate();
    }
    return moved;
  }

  bool isGameOver() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (grid[i][j] == 0) return false;
        if (i < 3 && grid[i][j] == grid[i + 1][j]) return false;
        if (j < 3 && grid[i][j] == grid[i][j + 1]) return false;
      }
    }
    return true;
  }
}