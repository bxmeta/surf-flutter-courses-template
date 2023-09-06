import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: IconMagic());
  }
}

class IconMagic extends StatefulWidget {
  const IconMagic({super.key});

  @override
  State<IconMagic> createState() => _IconMagicState();
}

class _IconMagicState extends State<IconMagic> with TickerProviderStateMixin {
  bool _isAnimation = false;
  Color _iconColor = Colors.black;
  double? left = null;
  double? top = null;
  late double startHori;
  late double startVert;
  double containerWidth = 50;
  double containerHeight = 50;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          left: left,
          top: top,
          child: _isAnimation
              ? RotationTransition(
            turns: _animation,
            child: Icon(
              Icons.account_circle,
              color: _iconColor,
              size: 50.0,
            ),
          )
              : Icon(
            Icons.account_circle,
            color: _iconColor,
            size: 50.0,
          ),
        ),
        Positioned.fill(
          child: GestureDetector(
              onTap: () => {
                setState(() {
                  _iconColor =
                      Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0);
                })
              },
              onLongPressStart: (LongPressStartDetails details) => {
                setState(() {
                  _isAnimation = true;
                })
              },
              onLongPressEnd: (LongPressEndDetails details) => {
                setState(() {
                  _isAnimation = false;
                })
              },
              onPanStart: (details) {
                setState(() {
                  startHori = details.localPosition.dx;
                  startVert = details.localPosition.dy;
                });
              },
              onPanUpdate: (DragUpdateDetails details) {
                var screenWidth = MediaQuery.of(context).size.width;
                var screenHeight = MediaQuery.of(context).size.height;

                var topVal = details.globalPosition.dy;
                var leftVal = details.globalPosition.dx;

                var leftBounds = screenWidth - containerWidth;
                var topBounds = screenHeight - containerHeight;

                setState(() {
                  if (leftVal.floor() >= 0 && leftVal <= leftBounds) {
                    left = leftVal.floorToDouble();
                  }

                  if (leftVal < 0) {
                    left = null;
                  }

                  if (leftVal > leftBounds) {
                    left = leftBounds.floorToDouble();
                  }

                  if (topVal.floor() >= 0 && topVal <= topBounds) {
                    top = topVal.floorToDouble();
                  }

                  if (topVal < 0) {
                    top = null;
                  }

                  if (topVal > topBounds) {
                    top = topBounds;
                  }
                });
              }),
        ),
      ],
    );
  }
}