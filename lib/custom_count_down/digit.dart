import 'package:sharedmobileutilities/classes/enums.dart';
import 'package:sharedmobileutilities/custom_count_down/clip_digit.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Digit<T> extends StatefulWidget {
  final Stream<T> itemStream;
  final T initValue;
  final String id;
  final TextStyle textStyle;
  final BoxDecoration decoration;
  final SlideDirection slideDirection;
  final EdgeInsets padding;

  const Digit({
    Key? key,
    required this.itemStream,
    required this.initValue,
    required this.id,
    required this.textStyle,
    required this.decoration,
    required this.slideDirection,
    required this.padding,
  }) : super(key: key);

  @override
  _DigitState createState() => _DigitState();
}

class _DigitState extends State<Digit> with SingleTickerProviderStateMixin {
  late StreamSubscription<int> _streamSubscription;
  int _currentValue = 0;
  int _nextValue = 0;
  late AnimationController _controller;

  bool haveData = false;

  final Animatable<Offset> _slideDownDetails = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  );
  late Animation<Offset> _slideDownAnimation;

  final Animatable<Offset> _slideDownDetails2 = Tween<Offset>(
    begin: const Offset(0.0, 0.0),
    end: const Offset(0.0, 1.0),
  );
  late Animation<Offset> _slideDownAnimation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _slideDownAnimation = _controller.drive(_slideDownDetails);
    _slideDownAnimation2 = _controller.drive(_slideDownDetails2);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }

      if (status == AnimationStatus.dismissed) {
        _currentValue = _nextValue;
      }
    });

    _currentValue = widget.initValue;
    _streamSubscription = widget.itemStream.distinct().listen((value) {
      haveData = true;
      if (value != _currentValue) {
        _nextValue = value;
        _controller.forward();
      }
    }) as StreamSubscription<int>;
  }

  @override
  void dispose() {
    _controller.dispose();
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fakeWidget = Opacity(
      opacity: 0.0,
      child: Text(
        '9',
        style: widget.textStyle,
        textScaleFactor: 1.0,
        textAlign: TextAlign.center,
      ),
    );

    return Container(
      padding: widget.padding,
      alignment: Alignment.center,
      decoration: widget.decoration,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, w) {
          return Stack(
            clipBehavior: Clip.hardEdge,
            fit: StackFit.passthrough,
            children: [
              haveData
                  ? FractionalTranslation(
                      translation: (widget.slideDirection == SlideDirection.Down) ? _slideDownAnimation.value : -_slideDownAnimation.value,
                      child: ClipRect(
                        clipper: ClipHalfRect(
                          percentage: _slideDownAnimation.value.dy,
                          isUp: true,
                          slideDirection: widget.slideDirection,
                        ),
                        child: Text(
                          '$_nextValue',
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.0,
                          style: widget.textStyle,
                        ),
                      ),
                    )
                  : const SizedBox(),
              FractionalTranslation(
                translation: (widget.slideDirection == SlideDirection.Down) ? _slideDownAnimation2.value : -_slideDownAnimation2.value,
                child: ClipRect(
                  clipper: ClipHalfRect(
                    percentage: _slideDownAnimation2.value.dy,
                    isUp: false,
                    slideDirection: widget.slideDirection,
                  ),
                  child: Text(
                    '$_currentValue',
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.0,
                    style: widget.textStyle,
                  ),
                ),
              ),
              fakeWidget,
            ],
          );
        },
      ),
    );
  }
}
