import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomInkWell extends StatelessWidget {
  CustomInkWell({
    Key? key,
    required this.child,
    required this.onTap,
    this.onLongPress,
  }) : super(key: key);
  void Function()? onLongPress;
  void Function()? onTap;
  Widget child;
  @override
  Widget build(BuildContext context) => InkWell(
        onLongPress: onLongPress ?? () {},
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: onTap,
        child: child,
      );
}
