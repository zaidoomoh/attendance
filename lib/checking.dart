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
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cubit.data,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    color: const Color.fromRGBO(245, 245, 245, 1),
                    //(168,223,241,1)
                    elevation: 20,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          cubit.permission == LocationPermission.whileInUse ||
                                  cubit.permission == LocationPermission.always
                              ? "Last check at: \n${cubit.timeAndDate}"
                              : "location services are denied",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    color: const Color.fromRGBO(245, 245, 245, 1),
                    elevation: 20,
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Status: ',
                                  style: TextStyle(
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
                                  text: '\n${cubit.distanceInMeters}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
