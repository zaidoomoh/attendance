import 'package:flutter/material.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required this.slidingAnimation,
    required this.screenWidth,
  });

  final Animation<Offset> slidingAnimation;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: Text(
            "Be there on time",
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.06,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
