import 'package:attendance_by_biometrics/Features/check_in_screen/presentation/view/widgets/check_in_body.dart';
import 'package:attendance_by_biometrics/index.dart';

class CheckingScreen extends StatefulWidget {
  const CheckingScreen({super.key});

  @override
  State<CheckingScreen> createState() => _CheckingScreenStateState();
}

class _CheckingScreenStateState extends State<CheckingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BiometricsCubit, BiometricsStates>(
        listener: (context, state) {},
        builder: (BuildContext context, state) {
          var cubit = BlocProvider.of<BiometricsCubit>(context);
          return RefreshIndicator(
            onRefresh: () async {
              await cubit.startListening();
            },
            child: ListView(children: [
              const CheckInBody(),
              ElevatedButton(
                  onPressed: () {
                    cubit.launchGoogleMaps(37.7749, -122.4194);
                  },
                  child: const Text("Location"))
            ]),
          );
        });
  }
}
