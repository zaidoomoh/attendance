import 'package:attendance_by_biometrics/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animator/animator.dart';
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
          double width = MediaQuery.of(context).size.width;

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    return Future(() => null);
                  },
                  child: cubit.point.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: ((context, index) {
                            return Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 10, right: 10),
                                child: InkWell(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(cubit.language == "En"
                                              ? "Point:${cubit.point[index]["latandlong"]}"
                                              : "النقطة:${cubit.point[index]["latandlong"]}"),
                                          Text(cubit.language == "En"
                                              ? "Distance:${cubit.point[index]["distance"]}"
                                              : "المسافة:${cubit.point[index]["distance"]}")
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          }),
                          itemCount: cubit.point.length)
                      : Center(
                          child: SizedBox(
                            height: width / 2.7,
                            width: width / 2.7,
                            child: Animator<double>(
                              duration: Duration(milliseconds: 1000),
                              cycles: 0,
                              curve: Curves.easeInOut,
                              tween: Tween<double>(begin: 15.0, end: 25.0),
                              builder: (context, animatorState, child) => Icon(
                                Icons.not_listed_location_outlined,
                                size: animatorState.value * 5,
                                color: Color(0xff778da9),
                              ),
                            ),
                          ),
                        ),
                ),
              )
            ],
          );
        });
  }
}
