import 'package:flutter/material.dart';

typedef PathBuilder = Path Function(Size size);

class ColoringRegion {
  final String id;
  final PathBuilder buildPath;
  Color? fill;

  ColoringRegion({
    required this.id,
    required this.buildPath,
    this.fill,
  });

  bool contains(Offset p, Size size) {
    final path = buildPath(size);
    return path.contains(p);
  }
}
