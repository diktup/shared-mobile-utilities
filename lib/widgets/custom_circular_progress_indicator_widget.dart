import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// ignore: must_be_immutable
class CustomCircularProgressIndicatorWidget extends StatelessWidget {
  CustomCircularProgressIndicatorWidget({
    Key? key,
    required this.backgroundColor,
    required this.alignment,
    required this.padding,
    required this.color,
  }) : super(key: key);
  AlignmentGeometry alignment;
  EdgeInsetsGeometry padding;
  Color backgroundColor;
  Color color;

  @override
  Widget build(BuildContext context) => Align(
        alignment: alignment,
        child: Padding(
          padding: padding,
          child: SizedBox(
            width: 20.0,
            height: 20.0,
            child: Platform.isIOS
                ? const CupertinoActivityIndicator(animating: true)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    backgroundColor: backgroundColor,
                    strokeWidth: 1.0,
                    color: color,
                  ),
          ),
        ),
      );
}
