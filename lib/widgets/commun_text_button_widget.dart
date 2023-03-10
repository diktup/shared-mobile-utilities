import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommunTextButtonWidget extends StatelessWidget {
  CommunTextButtonWidget({
    Key? key,
    required this.onPressed,
    required this.padding,
    required this.color,
    required this.shape,
    required this.child,
    this.minWidth,
  }) : super(key: key);
  EdgeInsetsGeometry? padding;
  void Function()? onPressed;
  ShapeBorder? shape;
  double? minWidth;
  Widget? child;
  Color? color;
  @override
  // ignore: deprecated_member_use
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            // ignore: unnecessary_null_comparison
            backgroundColor: onPressed == null ? color?.withOpacity(0.5) : color,
            shape: shape as OutlinedBorder?,
            padding: padding,
          ),
          child: child!,
        ),
      );
}
