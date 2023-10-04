import 'dart:async';
import 'package:attendance_by_biometrics/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'cubit.dart';

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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        color: const Color(0xffe0e1dd),
                        elevation: 20,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.04,
                                horizontal:
                                    MediaQuery.of(context).size.height * 0.015),
                            child: Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: cubit.language == "En"
                                            ? "Status :"
                                            : ": الحالة",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: cubit.status,
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: cubit.status == 'IN RANGE'
                                              ? Colors.green
                                              : Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: cubit.language == "En"
                                            ? "   Dis: ${cubit.distanceInMeters.toStringAsFixed(0)}"
                                            : "   ${cubit.distanceInMeters.toStringAsFixed(0)}:المسافة",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\n${cubit.closePoint}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blueGrey[400],
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        color: const Color(0xffe0e1dd),
                        //(168,223,241,1)
                        elevation: 20,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              cubit.permission ==
                                          LocationPermission.whileInUse ||
                                      cubit.permission ==
                                          LocationPermission.always
                                  ? cubit.language == "En"
                                      ? "Last check at: \n${cubit.timeAndDate}"
                                      : ": قمت بتسجيل الدخول عند \n${cubit.timeAndDate}"
                                  : "location services are denied",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    cubit.launchGoogleMaps(37.7749, -122.4194);
                  }, child: Text("Location"))
                ],
              ),
            ]),
          );
        });
  }
}
