import 'package:flutter/material.dart';

class WidgetFicha extends StatelessWidget {
  final int valor;
  const WidgetFicha({super.key, required this.valor});

  // Elige el color según el número
  Color obtenerColorFicha(int valor) {
    switch (valor) {
      case 2: return Colors.orange[100]!;
      case 4: return Colors.orange[200]!;
      case 8: return Colors.orange[300]!;
      case 16: return Colors.orange[400]!;
      case 32: return Colors.orange[500]!;
      case 64: return Colors.orange[600]!;
      case 128: return Colors.orange[700]!;
      case 256: return Colors.orange[800]!;
      case 512: return Colors.orange[900]!;
      case 1024: return Colors.red[500]!;
      case 2048: return Colors.yellow[700]!;
      default: return Colors.grey[300]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: obtenerColorFicha(valor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          valor == 0 ? "" : "$valor",
          style: const TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold, 
            color: Colors.black54
          ),
        ),
      ),
    );
  }
}