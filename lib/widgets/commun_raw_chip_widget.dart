import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommunRawChipWidget extends StatelessWidget {
  CommunRawChipWidget({
    Key? key,
    required this.backgroundColor,
    required this.checkmarkColor,
    required this.selectedColor,
    required this.showCheckmark,
    required this.onSelected,
    required this.selected,
    required this.avatar,
    required this.shape,
    required this.label,
  }) : super(key: key);
  void Function(bool) onSelected;
  Color backgroundColor;
  OutlinedBorder? shape;
  Color? checkmarkColor;
  Color selectedColor;
  bool? showCheckmark;
  bool selected;
  Widget avatar;
  Widget label;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 34.0,
        child: RawChip(
          selectedShadowColor: Colors.transparent,
          padding: const EdgeInsets.all(8.0),
          backgroundColor: backgroundColor,
          shadowColor: Colors.transparent,
          checkmarkColor: checkmarkColor,
          showCheckmark: showCheckmark,
          selectedColor: selectedColor,
          onSelected: onSelected,
          selected: selected,
          avatar: avatar,
          label: label,
          shape: shape,
        
        ),
      );
}
