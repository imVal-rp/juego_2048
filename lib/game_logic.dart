import 'dart:math';

class LogicaJuego {
  // La cuadrícula de 4x4 y el puntaje
  List<List<int>> cuadricula = List.generate(4, (_) => List.filled(4, 0));
  int puntaje = 0;

  // Reinicia todo para una nueva partida
  void iniciarJuego() {
    cuadricula = List.generate(4, (_) => List.filled(4, 0));
    puntaje = 0;
    agregarNuevaFicha();
    agregarNuevaFicha();
  }

  // Busca un lugar vacío y pone un 2 o un 4
  void agregarNuevaFicha() {
    List<List<int>> celdasVacias = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (cuadricula[i][j] == 0) celdasVacias.add([i, j]);
      }
    }
    if (celdasVacias.isNotEmpty) {
      var r = Random().nextInt(celdasVacias.length);
      cuadricula[celdasVacias[r][0]][celdasVacias[r][1]] = Random().nextInt(10) == 0 ? 4 : 2;
    }
  }

  // Lógica principal para mover a la izquierda y sumar números
  bool moverIzquierda() {
    bool movido = false;
    for (int i = 0; i < 4; i++) {
      List<int> fila = cuadricula[i].where((e) => e != 0).toList();
      for (int j = 0; j < fila.length - 1; j++) {
        if (fila[j] == fila[j + 1]) {
          fila[j] *= 2;
          puntaje += fila[j];
          fila.removeAt(j + 1);
          movido = true;
        }
      }
      while (fila.length < 4) fila.add(0);
      if (cuadricula[i].toString() != fila.toString()) movido = true;
      cuadricula[i] = fila;
    }
    return movido;
  }

  // Gira la matriz para poder usar 'moverIzquierda' en todas direcciones
  void rotar() {
    List<List<int>> nuevaCuadricula = List.generate(4, (_) => List.filled(4, 0));
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        nuevaCuadricula[j][3 - i] = cuadricula[i][j];
      }
    }
    cuadricula = nuevaCuadricula;
  }

  // Controla hacia dónde se mueve el usuario
  bool mover(String direccion) {
    bool movido = false;
    if (direccion == 'izquierda') {
      movido = moverIzquierda();
    } else if (direccion == 'derecha') {
      rotar(); rotar();
      movido = moverIzquierda();
      rotar(); rotar();
    } else if (direccion == 'arriba') {
      rotar(); rotar(); rotar();
      movido = moverIzquierda();
      rotar();
    } else if (direccion == 'abajo') {
      rotar();
      movido = moverIzquierda();
      rotar(); rotar(); rotar();
    }
    return movido;
  }

  // Revisa si ya no puedes hacer más movimientos
  bool esFinDeJuego() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (cuadricula[i][j] == 0) return false;
        if (i < 3 && cuadricula[i][j] == cuadricula[i + 1][j]) return false;
        if (j < 3 && cuadricula[i][j] == cuadricula[i][j + 1]) return false;
      }
    }
    return true;
  }
}