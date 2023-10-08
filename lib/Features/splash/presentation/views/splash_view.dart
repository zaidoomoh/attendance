
import 'package:flutter/material.dart';
import 'package:attendance_by_biometrics/index.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xff0d1b2a), body: SplashViewBody());
  }
}
