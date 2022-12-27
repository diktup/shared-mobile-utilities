import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// ignore: must_be_immutable
class CustomCircularProgressIndicatorWidget extends StatelessWidget {
  CustomCircularProgressIndicatorWidget({
    Key key,
    @required this.edgeInsetsGeometry,
    @required this.alignmentGeometry,
    @required this.color,
  }) : super(key: key);
  EdgeInsetsGeometry edgeInsetsGeometry;
  AlignmentGeometry alignmentGeometry;
  Color color;

  @override
  Widget build(BuildContext context) => Align(
        alignment: alignmentGeometry,
        child: Padding(
          padding: edgeInsetsGeometry,
          child: SizedBox(
            width: 20.0,
            height: 20.0,
            child: Platform.isIOS
                ? const CupertinoActivityIndicator(animating: true)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).focusColor),
                    backgroundColor: Theme.of(context).focusColor,
                    color: color,
                    strokeWidth: 0.6,
                  ),
          ),
        ),
      );
}
