abstract class BiometricsStates {}

class BiometricsInitStates extends BiometricsStates {}
class AppChangeBottomNavBarState extends BiometricsStates{}

class EnterStates extends BiometricsStates {
  final bool inRange;
  final String status;
  EnterStates(this.inRange,this.status);
}

class ExitStates extends BiometricsStates {
  final bool inRange;
  final String status;
  ExitStates(this.inRange,this.status);
}

class Authenticated extends BiometricsStates {}
class ImagePicked extends BiometricsStates {}
class GetData extends BiometricsStates {}
class ChangeScreen extends BiometricsStates {}

