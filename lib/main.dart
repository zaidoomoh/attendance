//flutter build apk --split-per-abi --no-sound-null-safety
import 'dart:ui';
import 'package:attendance_by_biometrics/home.dart';
import 'package:attendance_by_biometrics/login.dart';
import 'package:attendance_by_biometrics/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromRGBO(61, 124, 152, 1),
  ));

  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => BiometricsCubit()
              ..createDb()
              // ..isTableEmpty().then((value) {
              //   debugPrint("is empty ${value.toString()}");
              // })
              ..mac()
              ..fetchData()
              ..canCheck(context)
              ..handleLocationPermission(context).then((value) {
                debugPrint("enabled");
                //BiometricsCubit().startListening();
              })),
      ],
      child: BlocConsumer<BiometricsCubit, BiometricsStates>(
        listener: (context, state) {},
        builder: (BuildContext context, state) {
          var cubit = BlocProvider.of<BiometricsCubit>(context);
          // return MaterialApp(
          //     debugShowCheckedModeBanner: false,
          //     home: cubit.isEmpty ? const LoginPage() : const Home());
          return FutureBuilder<bool>(
            future: cubit.isTableEmpty(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for the future to complete, you can show a loading indicator or a splash screen
                return const Scaffold(
                  body: Column(children: [Center(child: CircularProgressIndicator())]),
                ); // Replace SplashScreen with your loading indicator or splash screen widget
              } else if (snapshot.data == true) {
                // Data exists in the table, navigate to the Home screen
                return const Home();
              } else {
                // Data does not exist in the table, show the Login screen
                return const LoginPage();
              }
            },
          );
        },
      ),
    );
  }
}
