import 'package:sharedmobileutilities/classes/enums.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

class DottedBorder extends Decoration {
  final LinePosition linePosition;
  final BorderRadius? borderRadius;
  final double strokeWidth;
  final List<int> dash;
  final Shape shape;
  final Color color;
  const DottedBorder({
    this.linePosition = LinePosition.bottom,
    this.color = const Color(0xFF9E9E9E),
    this.dash = const <int>[5, 5],
    this.shape = Shape.line,
    this.strokeWidth = 1,
    this.borderRadius,
  });

  @override
  BoxPainter createBoxPainter([void Function()? onChanged]) => _DottedBorder(shape, linePosition, color, borderRadius, dash, strokeWidth);
}

class _DottedBorder extends BoxPainter {
  LinePosition linePosition;
  Shape shape;
  Color color;
  BorderRadius? borderRadius;
  List<int> dash;
  double strokeWidth;
  _DottedBorder(this.shape, this.linePosition, this.color, this.borderRadius, this.dash, this.strokeWidth) {
    shape = shape;
    linePosition = linePosition;
    color = color;
    dash = dash;
    borderRadius = borderRadius;
    strokeWidth = strokeWidth;
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Path path = Path();
    if (shape == Shape.line) {
      if (linePosition == LinePosition.left) {
        path.moveTo(offset.dx, offset.dy);
        path.lineTo(offset.dx, offset.dy + configuration.size!.height);
      } else if (linePosition == LinePosition.top) {
        path.moveTo(offset.dx, offset.dy);
        path.lineTo(offset.dx + configuration.size!.width, offset.dy);
      } else if (linePosition == LinePosition.right) {
        path.moveTo(offset.dx + configuration.size!.width, offset.dy);
        path.lineTo(offset.dx + configuration.size!.width, offset.dy + configuration.size!.height);
      } else {
        path.moveTo(offset.dx, offset.dy + configuration.size!.height);
        path.lineTo(offset.dx + configuration.size!.width, offset.dy + configuration.size!.height);
      }
    } else if (shape == Shape.box) {
      RRect rect = RRect.fromLTRBAndCorners(
        offset.dx,
        offset.dy,
        offset.dx + configuration.size!.width,
        offset.dy + configuration.size!.height,
        bottomLeft: borderRadius?.bottomLeft as Radius,
        bottomRight: borderRadius?.bottomRight as Radius,
        topLeft: borderRadius?.topLeft as Radius,
        topRight: borderRadius?.topRight as Radius,
      );
      path.addRRect(rect);
    } else if (shape == Shape.circle) {
      path.addOval(Rect.fromLTWH(offset.dx, offset.dy, configuration.size!.width, configuration.size!.height));
    }

    PathMetrics metrics = path.computeMetrics(forceClosed: false);
    Path drawPath = Path();

    for (PathMetric me in metrics) {
      double totalLength = me.length;
      int index = -1;
      for (double start = 0; start < totalLength;) {
        double to = start + dash[(++index) % dash.length];
        to = to > totalLength ? totalLength : to;
        bool isEven = index % 2 == 0;
        if (isEven) drawPath.addPath(me.extractPath(start, to, startWithMoveTo: true), Offset.zero);
        start = to;
      }
    }

    canvas.drawPath(
        drawPath,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth);
  }
}
