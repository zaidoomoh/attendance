//flutter build apk --split-per-abi --no-sound-null-safety
import 'dart:ui';
import 'package:attendance_by_biometrics/index.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xff0d1b2a),
  ));
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => BiometricsCubit()
            ..loadImagePath()
            ..loadCheckingTime()
            ..loadLanguage()
            ..createDb()
            ..isTableEmpty()
            ..getDeviceId(context)
            ..fetchData()
            ..canCheck(context)
            ..handleLocationPermission(context).then((value) {
              debugPrint("enabled");
            }),
        )
      ],
      child: BlocConsumer<BiometricsCubit, BiometricsStates>(
          listener: (context, state) {},
          builder: (BuildContext context, state) {
            var cubit = BlocProvider.of<BiometricsCubit>(context);
            return MaterialApp(
                darkTheme: ThemeData.dark(),
                debugShowCheckedModeBanner: false,
                theme: ThemeData(),
                home: const SplashView());
          }),
    );
  }
}
// FutureBuilder<bool>(
            //   future: cubit.isTableEmpty(),
            //   builder: (context, snapshot) {
            //     // if (snapshot.connectionState == ConnectionState.waiting) {
            //     //   // While waiting for the future to complete, you can show a loading indicator or a splash screen
            //     //   return  const SplashScreen();
            //     //    // Replace SplashScreen with your loading indicator or splash screen widget
            //     // }
            //     if (snapshot.data == true) {
            //       // Data exists in the table, navigate to the Home screen
            //       return const LoginPage();
            //     } else {
            //       // Data does not exist in the table, show the Login screen
            //       return const Home();
            //     }
            //   },
            // ));