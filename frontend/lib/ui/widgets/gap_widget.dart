import 'package:flutter/material.dart';

class GapWidget extends StatelessWidget {
  final double size;
  static const int _base = 16;
  const GapWidget({super.key, this.size = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _base + size,
      width: _base + size,
    );
  }
}
