import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  final double offset;
  final double offsetX;

  FadeAnimation(this.delay, this.offset, this.offsetX, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0),
          Duration(milliseconds: 500))
      ..add(
          AniProps.height,
          Tween(begin: Offset(this.offsetX, this.offset), end: (Offset.zero)),
          Duration(milliseconds: 500),
          Curves.easeOut);

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      tween: tween,
      duration: tween.duration,
      child: child,
      builder: (context, child, value) {
        return Opacity(
          opacity: value.get(AniProps.opacity),
          child: Transform.translate(
            offset: value.get(AniProps.height),
            child: child,
          ),
        );
      },
    );
  }
}

enum AniProps { width, height, color, opacity }
