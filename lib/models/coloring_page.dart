import 'package:flutter/material.dart';
import '../models/coloring_region.dart';

class ColoringPage {
  final String title;
  final List<ColoringRegion> regions;
  final double outlineWidth;

  ColoringPage({
    required this.title,
    required this.regions,
    this.outlineWidth = 3.0,
  });

  ColoringPage clone() => ColoringPage(
        title: title,
        outlineWidth: outlineWidth,
        regions: regions
            .map((r) => ColoringRegion(
                  id: r.id,
                  buildPath: r.buildPath,
                  fill: r.fill,
                ))
            .toList(),
      );

  // ---- Sample pages (vector shapes) ----
  static List<ColoringPage> samples() => [
        _housePage(),
        _fishPage(),
        _butterflyPage(),
      ];

  // Helper for percentage positions
  static Offset _p(Size s, double xPct, double yPct) =>
      Offset(s.width * xPct, s.height * yPct);

  static ColoringPage _housePage() {
    List<ColoringRegion> regs = [];

    // Walls
    regs.add(ColoringRegion(
      id: 'house_walls',
      buildPath: (s) {
        final r = Rect.fromLTWH(
            s.width * .2, s.height * .35, s.width * .6, s.height * .45);
        return Path()
          ..addRRect(RRect.fromRectAndRadius(r, const Radius.circular(12)));
      },
    ));

    // Roof (triangle)
    regs.add(ColoringRegion(
      id: 'house_roof',
      buildPath: (s) {
        final p = Path();
        p.moveTo(s.width * .2, s.height * .35);
        p.lineTo(s.width * .5, s.height * .15);
        p.lineTo(s.width * .8, s.height * .35);
        p.close();
        return p;
      },
    ));

    // Door
    regs.add(ColoringRegion(
      id: 'house_door',
      buildPath: (s) {
        final r = Rect.fromLTWH(
            s.width * .44, s.height * .55, s.width * .12, s.height * .25);
        return Path()
          ..addRRect(RRect.fromRectAndRadius(r, const Radius.circular(8)));
      },
    ));

    // Left window
    regs.add(ColoringRegion(
      id: 'house_window_left',
      buildPath: (s) {
        final r = Rect.fromLTWH(
            s.width * .28, s.height * .45, s.width * .14, s.height * .12);
        return Path()
          ..addRRect(RRect.fromRectAndRadius(r, const Radius.circular(6)));
      },
    ));

    // Right window
    regs.add(ColoringRegion(
      id: 'house_window_right',
      buildPath: (s) {
        final r = Rect.fromLTWH(
            s.width * .58, s.height * .45, s.width * .14, s.height * .12);
        return Path()
          ..addRRect(RRect.fromRectAndRadius(r, const Radius.circular(6)));
      },
    ));

    // Chimney
    regs.add(ColoringRegion(
      id: 'house_chimney',
      buildPath: (s) {
        final r = Rect.fromLTWH(
            s.width * .65, s.height * .18, s.width * .07, s.height * .12);
        return Path()
          ..addRRect(RRect.fromRectAndRadius(r, const Radius.circular(4)));
      },
    ));

    return ColoringPage(title: 'Happy House', regions: regs);
  }

  static ColoringPage _fishPage() {
    List<ColoringRegion> regs = [];

    // Body (big oval)
    regs.add(ColoringRegion(
      id: 'fish_body',
      buildPath: (s) {
        final r = Rect.fromCenter(
            center: Offset(s.width * .45, s.height * .55),
            width: s.width * .55,
            height: s.height * .35);
        return Path()..addOval(r);
      },
    ));

    // Tail (triangle)
    regs.add(ColoringRegion(
      id: 'fish_tail',
      buildPath: (s) {
        final p = Path();
        p.moveTo(s.width * .75, s.height * .55);
        p.lineTo(s.width * .92, s.height * .45);
        p.lineTo(s.width * .92, s.height * .65);
        p.close();
        return p;
      },
    ));

    // Top fin
    regs.add(ColoringRegion(
      id: 'fish_top_fin',
      buildPath: (s) {
        final p = Path();
        p.moveTo(s.width * .35, s.height * .4);
        p.quadraticBezierTo(
            s.width * .45, s.height * .25, s.width * .55, s.height * .4);
        p.lineTo(s.width * .5, s.height * .42);
        p.quadraticBezierTo(
            s.width * .45, s.height * .34, s.width * .4, s.height * .42);
        p.close();
        return p;
      },
    ));

    // Bottom fin
    regs.add(ColoringRegion(
      id: 'fish_bottom_fin',
      buildPath: (s) {
        final p = Path();
        p.moveTo(s.width * .35, s.height * .7);
        p.quadraticBezierTo(
            s.width * .48, s.height * .85, s.width * .58, s.height * .7);
        p.lineTo(s.width * .52, s.height * .68);
        p.quadraticBezierTo(
            s.width * .46, s.height * .78, s.width * .4, s.height * .68);
        p.close();
        return p;
      },
    ));

    // Stripes (3 rectangles)
    for (int i = 0; i < 3; i++) {
      final ix = i;
      regs.add(ColoringRegion(
        id: 'fish_stripe_$ix',
        buildPath: (s) {
          final left = s.width * (.3 + ix * .1);
          final r = Rect.fromLTWH(
              left, s.height * .46, s.width * .06, s.height * .18);
          return Path()
            ..addRRect(RRect.fromRectAndRadius(r, const Radius.circular(6)));
        },
      ));
    }

    // Mouth (small triangle)
    regs.add(ColoringRegion(
      id: 'fish_mouth',
      buildPath: (s) {
        final p = Path();
        p.moveTo(s.width * .2, s.height * .55);
        p.lineTo(s.width * .16, s.height * .53);
        p.lineTo(s.width * .16, s.height * .57);
        p.close();
        return p;
      },
    ));

    // Eye (circle)
    regs.add(ColoringRegion(
      id: 'fish_eye',
      buildPath: (s) {
        final r = Rect.fromCircle(
            center: Offset(s.width * .25, s.height * .5),
            radius: s.width * .03);
        return Path()..addOval(r);
      },
    ));

    return ColoringPage(title: 'Friendly Fish', regions: regs);
  }

  static ColoringPage _butterflyPage() {
    List<ColoringRegion> regs = [];

    // Left big wing
    regs.add(ColoringRegion(
      id: 'wing_left_big',
      buildPath: (s) {
        final p = Path();
        p.addOval(Rect.fromCenter(
            center: Offset(s.width * .35, s.height * .5),
            width: s.width * .38,
            height: s.height * .5));
        return p;
      },
    ));

    // Right big wing
    regs.add(ColoringRegion(
      id: 'wing_right_big',
      buildPath: (s) {
        final p = Path();
        p.addOval(Rect.fromCenter(
            center: Offset(s.width * .65, s.height * .5),
            width: s.width * .38,
            height: s.height * .5));
        return p;
      },
    ));

    // Left inner wing
    regs.add(ColoringRegion(
      id: 'wing_left_inner',
      buildPath: (s) {
        return Path()
          ..addOval(Rect.fromCenter(
              center: Offset(s.width * .42, s.height * .52),
              width: s.width * .22,
              height: s.height * .28));
      },
    ));

    // Right inner wing
    regs.add(ColoringRegion(
      id: 'wing_right_inner',
      buildPath: (s) {
        return Path()
          ..addOval(Rect.fromCenter(
              center: Offset(s.width * .58, s.height * .52),
              width: s.width * .22,
              height: s.height * .28));
      },
    ));

    // Body
    regs.add(ColoringRegion(
      id: 'body',
      buildPath: (s) {
        final r = RRect.fromRectAndRadius(
          Rect.fromCenter(
              center: Offset(s.width * .5, s.height * .5),
              width: s.width * .08,
              height: s.height * .55),
          const Radius.circular(40),
        );
        return Path()..addRRect(r);
      },
    ));

    // Spots
    for (int i = 0; i < 3; i++) {
      final ix = i;
      regs.add(ColoringRegion(
        id: 'spot_left_$ix',
        buildPath: (s) {
          final c =
              Offset(s.width * (.34 + ix * .05), s.height * (.45 + ix * .08));
          return Path()
            ..addOval(Rect.fromCircle(center: c, radius: s.width * .03));
        },
      ));
      regs.add(ColoringRegion(
        id: 'spot_right_$ix',
        buildPath: (s) {
          final c =
              Offset(s.width * (.66 - ix * .05), s.height * (.45 + ix * .08));
          return Path()
            ..addOval(Rect.fromCircle(center: c, radius: s.width * .03));
        },
      ));
    }

    return ColoringPage(title: 'Bright Butterfly', regions: regs);
  }
}
