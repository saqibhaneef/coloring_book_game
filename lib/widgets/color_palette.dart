import 'package:flutter/material.dart';

class ColorPalette extends StatelessWidget {
  final ValueChanged<Color> onColorSelected;
  final Color? selected;

  const ColorPalette({
    super.key,
    required this.onColorSelected,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = <Color>[
      const Color(0xff000000),
      const Color(0xffe53935),
      const Color(0xff8e24aa),
      const Color(0xff3949ab),
      const Color(0xff1e88e5),
      const Color(0xff00acc1),
      const Color(0xff43a047),
      const Color(0xfffdd835),
      const Color(0xffffa726),
      const Color(0xffff7043),
      const Color(0xffffc0cb),
      const Color(0xff795548),
    ];

    return SizedBox(
      height: 72,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final c = colors[i];
          final isSel = selected == c;
          return InkWell(
            onTap: () => onColorSelected(c),
            borderRadius: BorderRadius.circular(40),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: isSel ? 56 : 48,
              height: isSel ? 56 : 48,
              decoration: BoxDecoration(
                color: c,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black.withOpacity(.2),
                  width: isSel ? 3 : 2,
                ),
                boxShadow: [
                  if (isSel)
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                      color: c.withOpacity(.4),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
