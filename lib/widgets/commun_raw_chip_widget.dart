import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommunRawChipWidget extends StatelessWidget {
  CommunRawChipWidget({
    Key? key,
    required this.backgroundColor,
    required this.selectedColor,
    required this.onSelected,
    required this.selected,
    required this.avatar,
    required this.label,
  }) : super(key: key);
  Color backgroundColor;
  OutlinedBorder? shape;
  Color? checkmarkColor;
  TextStyle? labelStyle;
  Color selectedColor;
  bool? showCheckmark;
  bool selected;
  Widget avatar;
  String label;

  void Function(bool) onSelected;
  @override
  Widget build(BuildContext context) => SizedBox(
        height: 34.0,
        child: RawChip(
          selectedShadowColor: Colors.transparent,
          label: Text(label, style: labelStyle),
          padding: const EdgeInsets.all(8.0),
          shadowColor: Colors.transparent,
          backgroundColor: backgroundColor,
          checkmarkColor: checkmarkColor,
          selectedColor: selectedColor,
          showCheckmark: showCheckmark,
          labelStyle: labelStyle,
          onSelected: onSelected,
          selected: selected,
          avatar: avatar,
          shape: shape,
        ),
      );
}
