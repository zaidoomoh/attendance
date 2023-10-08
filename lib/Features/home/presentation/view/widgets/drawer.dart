import 'package:flutter/material.dart';
import 'package:attendance_by_biometrics/index.dart';


class DrawerBody extends StatefulWidget {
  const DrawerBody({super.key});

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BiometricsCubit, BiometricsStates>(
        listener: (context, state) {},
        builder: (BuildContext context, state) {
          var cubit = BlocProvider.of<BiometricsCubit>(context);
          return Drawer(
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
                  },
                  title: Text(
                    cubit.language == "En" ? "Add points" : "اضف نقطه",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                              },
                              child: const Text("English"),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                cubit.language = "Ar";
                                cubit.setLanguage("Ar");
                                Restart.restartApp();
                              },
                              child: const Text("Arabic"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  title: Text(
                    cubit.language == "En" ? "language" : "اللغه",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              })),
            ]),
          );
        });
  }
}

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
