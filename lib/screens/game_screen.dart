import 'package:flutter/material.dart';
import '../game_logic.dart';
import '../widgets/tile_widget.dart';

class PantallaJuego extends StatefulWidget {
  @override
  _EstadoPantallaJuego createState() => _EstadoPantallaJuego();
}

class _EstadoPantallaJuego extends State<PantallaJuego> {
  // Instancia de la lógica en español
  LogicaJuego juego = LogicaJuego();

  @override
  void initState() {
    super.initState();
    juego.iniciarJuego();
  }

  // Maneja lo que pasa cuando mueves el dedo
  void manejarMovimiento(String direccion) {
    setState(() {
      if (juego.mover(direccion)) {
        juego.agregarNuevaFicha();
        if (juego.esFinDeJuego()) {
          _mostrarDialogoFinJuego();
        }
      }
    });
  }

  void _mostrarDialogoFinJuego() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Fin del Juego"),
        content: Text("Tu puntaje final fue: ${juego.puntaje}"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => juego.iniciarJuego());
              Navigator.pop(context);
            },
            child: const Text("Reiniciar"),
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
        title: const Text("2048"),
        backgroundColor: Colors.orange[800],
      ),
      body: OrientationBuilder(
        builder: (context, orientacion) {
          // Si el teléfono está vertical (portrait) o horizontal (landscape)
          return orientacion == Orientation.portrait
              ? Column(children: [
                  Expanded(flex: 1, child: _construirEncabezado()),
                  Expanded(flex: 3, child: _construirCuadricula()),
                ])
              : Row(children: [
                  Expanded(child: _construirEncabezado()),
                  Expanded(child: _construirCuadricula()),
                ]);
        },
      ),
    );
  }

  Widget _construirEncabezado() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("PUNTAJE", style: TextStyle(fontSize: 18, color: Colors.grey)),
          Text("${juego.puntaje}", style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: () => setState(() => juego.iniciarJuego()),
            child: const Text("Nueva Partida"),
          )
        ],
      ),
    );
  }

  Widget _construirCuadricula() {
    return GestureDetector(
      onVerticalDragEnd: (detalles) {
        if (detalles.primaryVelocity! < 0) manejarMovimiento('arriba');
        if (detalles.primaryVelocity! > 0) manejarMovimiento('abajo');
      },
      onHorizontalDragEnd: (detalles) {
        if (detalles.primaryVelocity! < 0) manejarMovimiento('izquierda');
        if (detalles.primaryVelocity! > 0) manejarMovimiento('derecha');
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.brown[400],
              borderRadius: BorderRadius.circular(12),
            ),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 16,
              itemBuilder: (context, indice) {
                int x = indice ~/ 4;
                int y = indice % 4;
                // Usamos el widget de la ficha con el nombre nuevo
                return WidgetFicha(valor: juego.cuadricula[x][y]);
              },
            ),
          ),
        ),
      ),
    );
  }
}