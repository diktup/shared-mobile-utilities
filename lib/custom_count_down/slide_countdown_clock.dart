import 'package:sharedmobileutilities/classes/enums.dart';
import 'package:sharedmobileutilities/custom_count_down/digit.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';

class CustomCountDownWidget extends StatefulWidget {
  final SlideDirection slideDirection;
  final TextStyle separatorTextStyle;
  final BoxDecoration decoration;
  final TextStyle textStyle;
  final VoidCallback onDone;
  final bool shouldShowDays;
  final EdgeInsets padding;
  final Duration duration;
  final String separator;
  final bool tightLabel;

  const CustomCountDownWidget({
    Key? key,
    @required required this.duration,
    required this.separatorTextStyle,
    required this.slideDirection,
    required this.shouldShowDays,
    required this.tightLabel,
    required this.decoration,
    required this.textStyle,
    required this.separator,
    required this.padding,
    required this.onDone,
  }) : super(key: key);

  @override
  SlideCountdownClockState createState() => SlideCountdownClockState(duration, shouldShowDays);
}

class SlideCountdownClockState extends State<CustomCountDownWidget> {
  SlideCountdownClockState(Duration duration, bool shouldShowDays) {
    timeLeft = duration;
    this.shouldShowDays = shouldShowDays;

    if (timeLeft.inHours > 99) {
      this.shouldShowDays = true;
    }
  }

  late bool shouldShowDays;
  late Duration timeLeft;
  Stream<DateTime>? timeStream;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    var time = DateTime.now();
    final initStream = Stream<DateTime>.periodic(const Duration(milliseconds: 1000), (_) {
      timeLeft -= const Duration(seconds: 1);
      if (timeLeft.inSeconds == 0) {
        Future.delayed(const Duration(milliseconds: 1000), () => widget.onDone());
      }
      return time;
    });
    timeStream = initStream.take(timeLeft.inSeconds).asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    Widget dayDigits;
    if (timeLeft.inDays > 99) {
      List<Function> digits = [];
      for (int i = timeLeft.inDays.toString().length - 1; i >= 0; i--) {
        digits.add((DateTime time) => ((timeLeft.inDays) ~/ math.pow(10, i) % math.pow(10, 1)).toInt());
      }
      dayDigits = _buildDigitForLargeNumber(timeStream, digits, DateTime.now(), 'daysHundreds');
    } else {
      dayDigits = _buildDigit(
        timeStream!,
        (DateTime time) => (timeLeft.inDays) ~/ 10,
        (DateTime time) => (timeLeft.inDays) % 10,
        DateTime.now(),
        "Days",
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        (shouldShowDays) ? dayDigits : const SizedBox(),
        (widget.separator.isNotEmpty && shouldShowDays) ? _buildSeparator() : const SizedBox(),
        _buildDigit(
          timeStream!,
          (DateTime time) => (timeLeft.inHours % 24) ~/ 10,
          (DateTime time) => (timeLeft.inHours % 24) % 10,
          DateTime.now(),
          "Hours",
        ),
        (widget.separator.isNotEmpty) ? _buildSeparator() : const SizedBox(),
        _buildDigit(
          timeStream!,
          (DateTime time) => (timeLeft.inMinutes % 60) ~/ 10,
          (DateTime time) => (timeLeft.inMinutes % 60) % 10,
          DateTime.now(),
          "Minutes",
        ),
        (widget.separator.isNotEmpty) ? _buildSeparator() : const SizedBox(),
        _buildDigit(
          timeStream!,
          (DateTime time) => (timeLeft.inSeconds % 60) ~/ 10,
          (DateTime time) => (timeLeft.inSeconds % 60) % 10,
          DateTime.now(),
          "Seconds",
        )
      ],
    );
  }

  Widget _buildSeparator() => Text(widget.separator, style: widget.separatorTextStyle);

  Widget _buildDigitForLargeNumber(Stream<DateTime>? timeStream, List<Function> digits, DateTime startTime, String id) {
    String timeLeftString = timeLeft.inDays.toString();
    List<Widget> rows = [];
    for (int i = 0; i < timeLeftString.toString().length; i++) {
      rows.add(Container(
          decoration: widget.decoration,
          padding: widget.tightLabel ? const EdgeInsets.only(left: 3) : EdgeInsets.zero,
          child: Digit<int?>(padding: widget.padding, itemStream: timeStream!.map<int>(digits[i] as int Function(DateTime)), initValue: digits[i](startTime), id: id, decoration: widget.decoration, slideDirection: widget.slideDirection, textStyle: widget.textStyle)));
    }
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: rows)]);
  }

  Widget _buildDigit(Stream<DateTime> timeStream, Function tensDigit, Function onesDigit, DateTime startTime, String id) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: widget.decoration,
              padding: widget.tightLabel ? const EdgeInsets.only(left: 3) : EdgeInsets.zero,
              child: Digit<int?>(
                padding: widget.padding,
                itemStream: timeStream.map<int>(tensDigit as int Function(DateTime)),
                initValue: tensDigit(startTime),
                id: id,
                decoration: widget.decoration,
                slideDirection: widget.slideDirection,
                textStyle: widget.textStyle,
              ),
            ),
            Container(
              decoration: widget.decoration,
              padding: widget.tightLabel ? const EdgeInsets.only(right: 3) : EdgeInsets.zero,
              child: Digit<int?>(
                padding: widget.padding,
                itemStream: timeStream.map<int>(onesDigit as int Function(DateTime)),
                initValue: onesDigit(startTime),
                decoration: widget.decoration,
                slideDirection: widget.slideDirection,
                textStyle: widget.textStyle,
                id: id,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
