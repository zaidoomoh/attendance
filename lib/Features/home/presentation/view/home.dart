import 'package:attendance_by_biometrics/index.dart';

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
              key: scaffoldKey,
              bottomNavigationBar: const BottomNavBar(),
              appBar:  const MyAppBar(),
              backgroundColor: const Color(0xff0d1b2a),
              body: FutureBuilder<bool>(
                future: cubit.isTableEmpty(),
                builder: (context, snapshot) {
                  if (snapshot.data == true) {
                    return const LoginPage();
                  } else {
                    return cubit.screens[cubit.bottomBarIndx];
                  }
                },
              ),
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
              drawer: const DrawerBody());
        });
  }
}

// appBar: AppBar(
              //   toolbarHeight: MediaQuery.of(context).size.height * 0.13,
              //   leadingWidth: MediaQuery.of(context).size.height * 0.3,
              //   leading: Row(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 5, vertical: 5),
              //         child: InkWell(
              //           onLongPress: () {
              //             cubit.selectImage();
              //           },
              //           onTap: () {
              //             scaffoldKey.currentState!.openDrawer();
              //           },
              //           child: CircleAvatar(
              //             backgroundImage: cubit.imageFile != null
              //                 ? FileImage(
              //                     cubit.imageFile!) // Use the selected image
              //                 : null,
              //             backgroundColor: Colors.white,
              //             maxRadius: 35,
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 10),
              //         child: Text(
              //           cubit.isEmpty ? "" : "Hi ${cubit.user[0]["desc"]},",
              //           style: const TextStyle(
              //               fontSize: 20, color: Color(0xffe0e1dd)),
              //         ),
              //       ),
              //     ],
              //   ),
              //   backgroundColor: const Color(0xff0d1b2a),
              //   elevation: 0,
              // ),

