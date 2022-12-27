import 'package:sharedmobileutilities/widgets/custom_inkwell.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommunChipWidget extends StatelessWidget {
  CommunChipWidget({
    Key? key,
    required this.borderRadiusGeometry,
    required this.edgeInsetsGeometry,
    this.marginEdgeInsetsGeometry,
    required this.color,
    this.onLongPress,
    this.textStyle,
    this.boxShadow,
    this.boxBorder,
    this.gradient,
    this.string,
    this.height,
    this.onTap,
    this.child,
    this.width,
  }) : super(key: key);
  EdgeInsetsGeometry? marginEdgeInsetsGeometry;
  BorderRadiusGeometry borderRadiusGeometry;
  EdgeInsetsGeometry edgeInsetsGeometry;
  void Function()? onLongPress;
  List<BoxShadow>? boxShadow;
  void Function()? onTap;
  TextStyle? textStyle;
  BoxBorder? boxBorder;
  Gradient? gradient;
  double? height;
  String? string;
  Widget? child;
  double? width;
  Color color;

  @override
  Widget build(BuildContext context) => onTap is void Function()
      ? CustomInkWell(onTap: onTap, child: communChipWidget())
      : onLongPress is void Function()
          ? CustomInkWell(onTap: () {}, onLongPress: onLongPress, child: communChipWidget())
          : onLongPress is void Function() && onTap is void Function()
              ? CustomInkWell(onTap: onTap, onLongPress: onLongPress, child: communChipWidget())
              : communChipWidget();

  Widget communChipWidget() => Container(
        margin: marginEdgeInsetsGeometry ?? EdgeInsets.zero,
        padding: edgeInsetsGeometry,
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadiusGeometry,
          boxShadow: boxShadow ?? [],
          gradient: gradient,
          border: boxBorder,
          color: color,
        ),
        child: child ?? Text(string!, textAlign: TextAlign.center, style: textStyle),
      );
}
