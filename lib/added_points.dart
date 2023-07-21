import 'package:attendance_by_biometrics/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';

class AddedPoints extends StatefulWidget {
  const AddedPoints({super.key});

  @override
  State<AddedPoints> createState() => _AddedPointsState();
}

class _AddedPointsState extends State<AddedPoints> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BiometricsCubit, BiometricsStates>(
        listener: (context, state) {},
        builder: (BuildContext context, state) {
          var cubit = BlocProvider.of<BiometricsCubit>(context);
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: InkWell(
                          onLongPress: () {
                             
                              cubit.openMap(
                                  double.parse(cubit.splitLatAndLong[0]),
                                  double.parse(cubit.splitLatAndLong[1]));
                            
                          },
                          onTap: () {
                            cubit.startListening(
                                latLong: (cubit.point![index]["latandlong"]),
                                distance: (cubit.point![index]["distance"]));
                          },
                          
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                      "Point:${cubit.point![index]["latandlong"]}"),
                                  Text(
                                      "Distance:${cubit.point![index]["distance"]}")
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    itemCount: cubit.point!.length),
              )
            ],
          );
        });
  }
}
