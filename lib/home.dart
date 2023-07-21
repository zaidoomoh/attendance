import 'package:attendance_by_biometrics/cubit.dart';
import 'package:attendance_by_biometrics/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

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
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: const Color.fromARGB(255, 202, 190, 189),
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.bottomBarIndx,
                onTap: (index) async {
                  cubit.changeScreenIndex(index);
                  await cubit.fetchData();
                },
                elevation: 30,
                selectedFontSize: 15,
                unselectedFontSize: 13,
                iconSize: 32,
                selectedItemColor: const Color.fromRGBO(32, 67, 89, 1),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check,
                      color: Color.fromRGBO(32, 67, 89, 1),
                    ),
                    label: 'Checking',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.pin_drop,
                          color: Color.fromRGBO(32, 67, 89, 1)),
                      label: 'Added Points'),
                ]),
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(61, 124, 152, 1),
              elevation: 0,
            ),
            backgroundColor: const Color.fromRGBO(61, 124, 152, 1),
            body: cubit.screens[cubit.bottomBarIndx],
            floatingActionButton: Visibility(
              visible: cubit.inRange &&
                  (cubit.permission == LocationPermission.always ||
                      cubit.permission == LocationPermission.whileInUse),
              child: FloatingActionButton(
                backgroundColor: const Color.fromRGBO(115, 176, 205, 1),
                onPressed: () {
                  setState(() {
                    cubit.timeAndDate = "";
                  });
                  //cubit.authenticate();
                  cubit.getMyLocation().then((value) {
                    if (cubit.distanceInMeters <= 100) {
                      cubit.authenticate();
                    } else {
                      Fluttertoast.showToast(
                        backgroundColor: Colors.black,
                        fontSize: 25,
                        msg: "YOU ARE NOT IN THE LEAGLE RANGE",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                      );
                    }
                  });
                },
                child: const Icon(Icons.fingerprint),
              ),
            ),
            drawer: Drawer(
              child: ListView(padding: EdgeInsets.zero, children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(230, 92, 79, 1),
                  ),
                  child: InkWell(
                    child: null,
                  ),
                ),
                Builder(builder: (context) {
                  return ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      showBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 300,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(220, 92, 79, 1),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      "Create a point",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: TextFormField(
                                      controller: cubit.latAndLongController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        hintText: "Point",
                                        hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(32, 67, 89, 1),
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: TextFormField(
                                      controller: cubit.distanceController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        hintText: "Distance",
                                        hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(32, 67, 89, 1),
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9 .]')),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30))),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        const Color.fromRGBO(32, 67, 89, 1),
                                      ),
                                    ),
                                    onPressed: () {
                                      cubit.insertData();
                                      // cubit.addPoint(
                                      //     latAndLong:
                                      //         cubit.latAndLongController.text,
                                      //     distance:
                                      //         cubit.distanceController.text);
                                      debugPrint(cubit.point.toString());
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    title: const Text(
                      'Add points',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                }),
                Builder(builder: ((context) {
                  return ListTile(
                    onTap: () {},
                    title: const Text(
                      '',
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
