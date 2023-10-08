import 'package:attendance_by_biometrics/Features/home/presentation/view/home.dart';
import 'package:attendance_by_biometrics/Features/splash/presentation/views/widgets/sliding_text.dart';
import 'package:flutter/material.dart';


class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const Home();
        },
      ));
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset("assets/optimal_attendance.png"),
        SlidingText(
            slidingAnimation: slidingAnimation, screenWidth: screenWidth),
      ],
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 10), end: const Offset(0, 0))
            .animate(animationController);
    animationController.forward();
  }
}
