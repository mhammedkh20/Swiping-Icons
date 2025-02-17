import 'package:flutter/material.dart';

class IconSelection extends StatefulWidget {
  final AnimationController controller;
  final bool isSelected;
  final IconData icon;
  final Color iconColor;
  final AlignmentDirectional alignment;
  final Function(DragStartDetails)? onVerticalDragStart;
  final Function(DragEndDetails)? onVerticalDragEnd;
  final Function(DragUpdateDetails)? onVerticalDragUpdate;

  const IconSelection({
    super.key,
    required this.controller,
    required this.icon,
    required this.alignment,
    required this.isSelected,
    required this.iconColor,
    this.onVerticalDragStart,
    this.onVerticalDragEnd,
    this.onVerticalDragUpdate,
  });

  @override
  State<IconSelection> createState() => _IconSelectionState();
}

class _IconSelectionState extends State<IconSelection> {
  late Animation<Color?> colorAnimation;

  late Animation<double> fontSize;
  late Animation<double> translateX;

  @override
  void initState() {
    fontSize = TweenSequence(
      [
        TweenSequenceItem(
          tween: Tween<double>(begin: 26, end: 60)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 30,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 60, end: 55)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 70,
        ),
      ],
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: const Interval(.3, 1, curve: Curves.easeIn),
    ));
    translateX = TweenSequence(
      [
        TweenSequenceItem(
          tween: Tween<double>(begin: 0, end: -60)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 30,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: -60, end: -50)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 70,
        ),
      ],
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: const Interval(.3, 1, curve: Curves.easeIn),
    ));

    colorAnimation = ColorTween(
      begin: widget.iconColor,
      end: Colors.white,
    ).animate(widget.controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(translateX.value, 0),
          child: Align(
            alignment: widget.alignment,
            child: GestureDetector(
              onVerticalDragStart: widget.onVerticalDragStart,
              onVerticalDragEnd: widget.onVerticalDragEnd,
              onVerticalDragUpdate: widget.onVerticalDragUpdate,
              child: Icon(
                widget.icon,
                size: fontSize.value,
                color: colorAnimation.value,
              ),
            ),
          ),
        );
      },
    );
  }
}
