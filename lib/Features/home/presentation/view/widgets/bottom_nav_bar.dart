import 'package:flutter/material.dart';
import 'package:attendance_by_biometrics/index.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BiometricsCubit, BiometricsStates>(
        listener: (context, state) {},
        builder: (BuildContext context, state) {
          double screenWidth = MediaQuery.of(context).size.width;
          List<IconData> listOfIcons = [
            Icons.check_box,
            Icons.location_on,
          ];
          var cubit = BlocProvider.of<BiometricsCubit>(context);
          return Container(
            margin: const EdgeInsets.all(20),
            height: screenWidth * .155,
            decoration: BoxDecoration(
              color: const Color(0xffe0e1dd),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.15),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
              borderRadius: BorderRadius.circular(50),
            ),
            child: ListView.builder(
              itemCount: 2,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.024),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  cubit.changeScren(index);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Stack(
                  children: [
                    SizedBox(
                      width: screenWidth * .43,
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height: index == cubit.bottomBarIndx
                              ? screenWidth * .12
                              : 0,
                          width: index == cubit.bottomBarIndx
                              ? screenWidth * .3
                              : 0,
                          decoration: BoxDecoration(
                            color: index == cubit.bottomBarIndx
                                ? const Color(0xff778da9).withOpacity(0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * .43,
                      alignment: Alignment.center,
                      child: Icon(
                        listOfIcons[index],
                        size: screenWidth * .086,
                        color: index == cubit.bottomBarIndx
                            ? const Color(0xff415a77)
                            : Colors.black26,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
