import 'package:flutter/material.dart';
import '../game_logic.dart';
import '../widgets/tile_widget.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GameLogic game = GameLogic();

  @override
  void initState() {
    super.initState();
    game.initGame();
  }

  void handleMove(String direction) {
    setState(() {
      if (game.move(direction)) {
        game.addNewTile();
        if (game.isGameOver()) {
          _showGameOverDialog();
        }
      }
    });
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Game Over"),
        content: Text("Tu puntaje: ${game.score}"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => game.initGame());
              Navigator.pop(context);
            },
            child: Text("Reiniciar"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("2048 - Valeria Rodríguez"),
        backgroundColor: Colors.orange[800],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? Column(children: [
                  Expanded(flex: 1, child: _buildHeader()),
                  Expanded(flex: 3, child: _buildGrid()),
                ])
              : Row(children: [
                  Expanded(child: _buildHeader()),
                  Expanded(child: _buildGrid()),
                ]);
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("SCORE", style: TextStyle(fontSize: 18, color: Colors.grey)),
          Text("${game.score}", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: () => setState(() => game.initGame()),
            child: Text("Nueva Partida"),
          )
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! < 0) handleMove('up');
        if (details.primaryVelocity! > 0) handleMove('down');
      },
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) handleMove('left');
        if (details.primaryVelocity! > 0) handleMove('right');
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.brown[400],
              borderRadius: BorderRadius.circular(12),
            ),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                int x = index ~/ 4;
                int y = index % 4;
                return TileWidget(value: game.grid[x][y]);
              },
            ),
          ),
        ),
      ),
    );
  }
}