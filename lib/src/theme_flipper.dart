import 'dart:math' as math;

import 'package:flutter/material.dart';

enum SelectedTheme {
  dark,
  light,
}

class ThemeFlipper extends StatefulWidget {
  ThemeFlipper({
    Key key,
    this.child,
    this.darkTheme,
    this.lightTheme,
    this.selectedTheme = SelectedTheme.light,
    this.flipDuration = const Duration(milliseconds: 2000),
  }) : super(key: key);

  final Widget child;
  final Duration flipDuration;
  final SelectedTheme selectedTheme;
  final ThemeData darkTheme;
  final ThemeData lightTheme;

  @override
  _ThemeFlipperState createState() => _ThemeFlipperState();
}

class _ThemeFlipperState extends State<ThemeFlipper>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _rotationAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.flipDuration,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: math.pi)
        .animate(_animationController)
          ..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void didUpdateWidget(ThemeFlipper oldWidget) {
    if (oldWidget.selectedTheme != widget.selectedTheme) {
      _animationController.reset();
      _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  ThemeMode _getThemeMode() {
    return widget.selectedTheme == SelectedTheme.light
        ? _animationController.value > .5 || _animationController.value == 0.0
            ? ThemeMode.light
            : ThemeMode.dark
        : _animationController.value > .5 || _animationController.value == 0.0
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: widget.darkTheme,
      theme: widget.lightTheme,
      themeMode: _getThemeMode(),
      title: 'AppWrapper',
      home: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.00025)
          ..rotateY(_rotationAnimation.value),
        child: _animationController.value < .5
            ? widget.child
            : Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: widget.child,
              ),
      ),
    );
  }
}
