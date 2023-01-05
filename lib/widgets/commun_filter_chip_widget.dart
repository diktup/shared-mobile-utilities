import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommunFilterChipWidget extends StatelessWidget {
  CommunFilterChipWidget({
    Key? key,
    required this.backgroundColor,
    required this.checkmarkColor,
    required this.selectedColor,
    required this.onSelected,
    required this.selected,
    required this.shape,
  }) : super(key: key);
  void Function(bool) onSelected;
  Color backgroundColor;
  OutlinedBorder shape;
  Color checkmarkColor;
  Color selectedColor;
  bool selected;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 38.0,
        height: 34.0,
        child: FilterChip(
          selectedShadowColor: Colors.transparent,
          padding: const EdgeInsets.all(8.0),
          shadowColor: Colors.transparent,
          backgroundColor: backgroundColor,
          checkmarkColor: Colors.white,
          selectedColor: selectedColor,
          onSelected: onSelected,
          label: const Text(''),
          selected: selected,
          shape: shape,
        ),
      );
}
