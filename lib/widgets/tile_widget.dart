import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final int value;
  const TileWidget({super.key, required this.value});

  Color getTileColor(int value) {
    switch (value) {
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
        color: getTileColor(value),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          value == 0 ? "" : "$value",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
      ),
    );
  }
}