import 'package:attendance_by_biometrics/index.dart';



class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight*2);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
    Widget build(BuildContext context) {
    return BlocConsumer<BiometricsCubit, BiometricsStates>(
        listener: (context, state) {},
        builder: (BuildContext context, state) {
          var cubit = BlocProvider.of<BiometricsCubit>(context);
          return AppBar(
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
                              cubit.imageFile!) 
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
                    style:
                        const TextStyle(fontSize: 20, color: Color(0xffe0e1dd)),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xff0d1b2a),
            elevation: 0,
          );
        });
  }

}



// class _CostumeAppBarState extends State<CostumeAppBar>  {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<BiometricsCubit, BiometricsStates>(
//         listener: (context, state) {},
//         builder: (BuildContext context, state) {
//           var cubit = BlocProvider.of<BiometricsCubit>(context);
//           return PreferredSize(
//             preferredSize:Size.fromHeight(MediaQuery.of(context).size.height * 0.13),
//             child: AppBar(
//               toolbarHeight: MediaQuery.of(context).size.height * 0.13,
//               leadingWidth: MediaQuery.of(context).size.height * 0.3,
//               leading: Row(
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                     child: InkWell(
//                       onLongPress: () {
//                         cubit.selectImage();
//                       },
//                       onTap: () {
//                         scaffoldKey.currentState!.openDrawer();
//                       },
//                       child: CircleAvatar(
//                         backgroundImage: cubit.imageFile != null
//                             ? FileImage(
//                                 cubit.imageFile!) 
//                             : null,
//                         backgroundColor: Colors.white,
//                         maxRadius: 35,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Text(
//                       cubit.isEmpty ? "" : "Hi ${cubit.user[0]["desc"]},",
//                       style:
//                           const TextStyle(fontSize: 20, color: Color(0xffe0e1dd)),
//                     ),
//                   ),
//                 ],
//               ),
//               backgroundColor: const Color(0xff0d1b2a),
//               elevation: 0,
//             ),
//           );
//         });
//   }
// }


// class CostumeAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CostumeAppBar({super.key});
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<BiometricsCubit, BiometricsStates>(
//       listener: (context, state) {},
//       builder: (BuildContext context, state) {
//         var cubit = BlocProvider.of<BiometricsCubit>(context);
//         return AppBar(
//           leadingWidth: MediaQuery.of(context).size.height * 0.3,
//           leading: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                 child: InkWell(
//                   onLongPress: () {
//                     cubit.selectImage();
//                   },
//                   onTap: () {
//                     scaffoldKey.currentState!.openDrawer();
//                   },
//                   child: CircleAvatar(
//                     backgroundImage: cubit.imageFile != null
//                         ? FileImage(cubit.imageFile!)
//                         : null,
//                     backgroundColor: Colors.white,
//                     maxRadius: 35,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Text(
//                   cubit.isEmpty ? "" : "Hi ${cubit.user[0]["desc"]},",
//                   style: const TextStyle(fontSize: 20, color: Color(0xffe0e1dd)),
//                 ),
//               ),
//             ],
//           ),
//           backgroundColor: const Color(0xff0d1b2a),
//           elevation: 0,
//         );
//       },
//     );
//   }
// }

