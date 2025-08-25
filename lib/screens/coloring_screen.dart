import 'package:flutter/material.dart';
import '../models/coloring_page.dart';
import '../models/coloring_region.dart';
import '../widgets/color_palette.dart';

class ColoringScreen extends StatefulWidget {
  final ColoringPage page;
  const ColoringScreen({super.key, required this.page});

  @override
  State<ColoringScreen> createState() => _ColoringScreenState();
}

class _ColoringScreenState extends State<ColoringScreen> {
  Color? _selected; // null = eraser (remove fill)

  void _handleTap(TapDownDetails d, Size size) {
    final p = d.localPosition;
    // Topmost first: iterate from end
    for (int i = widget.page.regions.length - 1; i >= 0; i--) {
      final region = widget.page.regions[i];
      if (region.contains(p, size)) {
        setState(() {
          region.fill = _selected; // can be null (eraser)
        });
        break;
      }
    }
  }

  void _clearAll() {
    setState(() {
      for (final r in widget.page.regions) {
        r.fill = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.page.title),
        actions: [
          IconButton(
            tooltip: 'Clear all',
            onPressed: _clearAll,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text('Pick a color:',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const Spacer(),
                FilterChip(
                  selected: _selected == null,
                  label: const Text('Eraser'),
                  avatar: const Icon(Icons.auto_fix_off),
                  onSelected: (_) => setState(() => _selected = null),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ColorPalette(
            onColorSelected: (c) => setState(() => _selected = c),
            selected: _selected,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final size =
                        Size(constraints.maxWidth, constraints.maxHeight);
                    return GestureDetector(
                      onTapDown: (d) => _handleTap(d, size),
                      child: CustomPaint(
                        painter: _PagePainter(widget.page),
                        isComplex: true,
                        willChange: true,
                        child: const SizedBox.expand(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _PagePainter extends CustomPainter {
  final ColoringPage page;
  _PagePainter(this.page);

  @override
  void paint(Canvas canvas, Size size) {
    // Background “paper”
    final paper = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final paperRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(24),
    );
    canvas.drawRRect(paperRect, paper);

    // Draw each region: fill (if any) then outline
    final outline = Paint()
      ..color = const Color(0xff2f2557)
      ..style = PaintingStyle.stroke
      ..strokeWidth = page.outlineWidth
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    for (final region in page.regions) {
      final path = region.buildPath(size);

      if (region.fill != null) {
        final fillPaint = Paint()
          ..color = region.fill!
          ..style = PaintingStyle.fill
          ..isAntiAlias = true;
        canvas.drawPath(path, fillPaint);
      }

      canvas.drawPath(path, outline);
    }
  }

  @override
  bool shouldRepaint(covariant _PagePainter oldDelegate) {
    return oldDelegate.page != page;
  }
}
