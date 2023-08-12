import 'package:attendance_by_biometrics/cubit.dart';
import 'package:attendance_by_biometrics/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:restart_app/restart_app.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BiometricsCubit, BiometricsStates>(
        listener: (context, state) {},
        builder: (BuildContext context, state) {
          var cubit = BlocProvider.of<BiometricsCubit>(context);
          GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
          double screenWidth = MediaQuery.of(context).size.width;
          List<IconData> listOfIcons = [
            Icons.check_box,
            Icons.location_on,
          ];
          return Scaffold(
            key: scaffoldKey,
            bottomNavigationBar: Container(
              margin: EdgeInsets.all(20),
              height: screenWidth * .155,
              decoration: BoxDecoration(
                color: Color(0xffe0e1dd),
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
                padding: EdgeInsets.symmetric(horizontal: screenWidth * .024),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    setState(() {
                      cubit.bottomBarIndx = index;
                      HapticFeedback.lightImpact();
                    });
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
                                  ? Color(0xff778da9).withOpacity(0.2)
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
                              ? Color(0xff415a77)
                              : Colors.black26,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              toolbarHeight: MediaQuery.of(context).size.height * 0.13,
              leadingWidth: MediaQuery.of(context).size.height * 0.3,
              leading: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: InkWell(
                      onLongPress: () {
                        cubit.selectImage();
                      },
                      onTap: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                      child: CircleAvatar(
                        backgroundImage: cubit.imageFile != null
                            ? FileImage(
                                cubit.imageFile!) // Use the selected image
                            : null,
                        backgroundColor: Colors.white,
                        maxRadius: 35,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      cubit.isEmpty ? "" : "Hi ${cubit.user[0]["desc"]},",
                      style: const TextStyle(
                          fontSize: 20, color: Color(0xffe0e1dd)),
                    ),
                  ),
                ],
              ),
              backgroundColor: const Color(0xff0d1b2a),
              elevation: 0,
            ),
            backgroundColor: const Color(0xff0d1b2a),
            body: cubit.screens[cubit.bottomBarIndx],
            floatingActionButton: Visibility(
              visible: cubit.inRange &&
                  (cubit.permission == LocationPermission.always ||
                      cubit.permission == LocationPermission.whileInUse),
              child: FloatingActionButton(
                backgroundColor: const Color(0xff778da9),
                onPressed: () {
                  setState(() {
                    cubit.timeAndDate = "";
                  });
                  //cubit.getMyLocation().then((value) {
                  cubit.authenticate();
                  //});
                },
                child: const Icon(Icons.fingerprint),
              ),
            ),
            drawer: Drawer(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListView(padding: EdgeInsets.zero, children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color(0xff415a77),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.06),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              cubit.isEmpty ? "" : cubit.user[0]["desc"],
                              style: const TextStyle(
                                  fontSize: 20, color: Color(0xffe0e1dd)),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                                "Employee ID: ${cubit.isEmpty ? "" : cubit.user[0]["employee_id"].toString()}",
                                style: const TextStyle(
                                    fontSize: 20, color: Color(0xffe0e1dd)))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Builder(builder: (context) {
                  return ListTile(
                    onTap: () {
                      cubit.yellow();
                      Navigator.pop(context);
                      // showBottomSheet(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return Container(
                      //         height: 300,
                      //         decoration: const BoxDecoration(
                      //           color: Color.fromRGBO(220, 92, 79, 1),
                      //           borderRadius: BorderRadius.only(
                      //               topLeft: Radius.circular(10),
                      //               topRight: Radius.circular(10)),
                      //         ),
                      //         child: Column(
                      //           children: [
                      //             const Padding(
                      //               padding: EdgeInsets.all(5.0),
                      //               child: Text(
                      //                 "Create a point",
                      //                 style: TextStyle(
                      //                     fontSize: 30,
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 30,
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                   horizontal: 15),
                      //               child: TextFormField(
                      //                 controller: cubit.latAndLongController,
                      //                 style:
                      //                     const TextStyle(color: Colors.white),
                      //                 decoration: const InputDecoration(
                      //                   hintText: "Point",
                      //                   hintStyle: TextStyle(
                      //                       color: Colors.white,
                      //                       fontWeight: FontWeight.bold),
                      //                   enabledBorder: UnderlineInputBorder(
                      //                     borderSide:
                      //                         BorderSide(color: Colors.white),
                      //                   ),
                      //                   focusedBorder: UnderlineInputBorder(
                      //                     borderSide: BorderSide(
                      //                       color:
                      //                           Color.fromRGBO(32, 67, 89, 1),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 keyboardType: TextInputType.number,
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                   horizontal: 15),
                      //               child: TextFormField(
                      //                 controller: cubit.distanceController,
                      //                 style:
                      //                     const TextStyle(color: Colors.white),
                      //                 decoration: const InputDecoration(
                      //                   hintText: "Distance",
                      //                   hintStyle: TextStyle(
                      //                       color: Colors.white,
                      //                       fontWeight: FontWeight.bold),
                      //                   enabledBorder: UnderlineInputBorder(
                      //                     borderSide:
                      //                         BorderSide(color: Colors.white),
                      //                   ),
                      //                   focusedBorder: UnderlineInputBorder(
                      //                     borderSide: BorderSide(
                      //                       color:
                      //                           Color.fromRGBO(32, 67, 89, 1),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 keyboardType: TextInputType.number,
                      //                 inputFormatters: <TextInputFormatter>[
                      //                   FilteringTextInputFormatter.allow(
                      //                       RegExp(r'[0-9 .]')),
                      //                 ],
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             ElevatedButton(
                      //               style: ButtonStyle(
                      //                 shape: MaterialStateProperty.all<
                      //                         RoundedRectangleBorder>(
                      //                     RoundedRectangleBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(30))),
                      //                 backgroundColor:
                      //                     MaterialStateProperty.all<Color>(
                      //                   const Color.fromRGBO(32, 67, 89, 1),
                      //                 ),
                      //               ),
                      //               onPressed: () {
                      //                 cubit.insertData(data: {
                      //                   "table_name": "",
                      //                   "columns": {"": ""}
                      //                 });
                      //                 // cubit.addPoint(
                      //                 //     latAndLong:
                      //                 //         cubit.latAndLongController.text,
                      //                 //     distance:
                      //                 //         cubit.distanceController.text);
                      //                 debugPrint(cubit.point.toString());
                      //                 Navigator.pop(context);
                      //               },
                      //               child: const Icon(Icons.add),
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     });
                    },
                    title: Text(
                      cubit.language == "En" ? "Add points" : "اضف نقطه",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                }),
                Builder(builder: ((context) {
                  return ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            title: Text(cubit.language == "En"
                                ? "Select Language"
                                : "اختر اللغة"),
                            children: [
                              SimpleDialogOption(
                                onPressed: () {
                                  cubit.language == "En";
                                  cubit.setLanguage("En");
                                  Restart.restartApp();
                                  // Navigator.pushNamedAndRemoveUntil(
                                  //     context, '/', (_) => false);
                                },
                                child: Text("English"),
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                  cubit.language = "Ar";
                                  cubit.setLanguage("Ar");
                                  Restart.restartApp();
                                  // Navigator.pushNamedAndRemoveUntil(
                                  //     context, '/', (_) => false);
                                },
                                child: Text("Arabic"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    title: Text(
                      cubit.language == "En" ? "language" : "اللغه",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                })),
                Builder(builder: ((context) {
                  return ListTile(
                    onTap: () {},
                    title: const Text(
                      '',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                }))
              ]),
            ),
          );
        });
  }
}
//  BottomNavigationBar(
            //     backgroundColor: const Color(0xffe0e1dd),
            //     type: BottomNavigationBarType.fixed,
            //     currentIndex: cubit.bottomBarIndx,
            //     onTap: (index) async {
            //       cubit.changeScreenIndex(index);
            //     },
            //     elevation: 30,
            //     selectedFontSize: 15,
            //     unselectedFontSize: 13,
            //     iconSize: 32,
            //     selectedItemColor: const Color(0xff415a77),
            //     items: const [
            //       BottomNavigationBarItem(
            //         icon: Icon(
            //           Icons.check,
            //           color: Color(0xff1b263b),
            //         ),
            //         label: 'Checking',
            //       ),
            //       BottomNavigationBarItem(
            //           icon: Icon(
            //             Icons.pin_drop,
            //             color: Color(0xff1b263b),
            //           ),
            //           label: 'Added Points'),
            //     ]),