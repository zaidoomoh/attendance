// import 'package:attendance_by_biometrics/home.dart';
// import 'package:attendance_by_biometrics/login.dart';
// import 'package:attendance_by_biometrics/states.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'cubit.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<BiometricsCubit, BiometricsStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: Color.fromRGBO(61, 124, 152, 1),
//           body: Container(
//             //decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/login.png'))),
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 200,
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       color: const Color.fromRGBO(115, 176, 205, 1),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 10),
//                             child: SizedBox(
//                               height: 110.0,
//                               child: Image.asset('assets/signup.png',
//                                   fit: BoxFit.contain),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Expanded(
//                             child: CustomScrollView(
//                               physics: const BouncingScrollPhysics(),
//                               slivers: [
//                                 SliverList(
//                                   delegate: SliverChildListDelegate(
//                                     [
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 15),
//                                         child: Column(
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: const [
//                                                 SizedBox(
//                                                   height: 50,
//                                                   width: 130,
//                                                   child: TextField(
//                                                     decoration: InputDecoration(
//                                                       labelText: 'F-name',
//                                                       labelStyle: TextStyle(
//                                                           color: Colors.white),
//                                                       focusedBorder: OutlineInputBorder(
//                                                           borderSide:
//                                                               BorderSide(
//                                                                   color: Colors
//                                                                       .white),
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           30))),
//                                                       enabledBorder: OutlineInputBorder(
//                                                           borderSide:
//                                                               BorderSide(
//                                                                   color: Colors
//                                                                       .white),
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           30))),
//                                                     ),
//                                                     obscureText: true,
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   width: 10,
//                                                 ),
//                                                 SizedBox(
//                                                   height: 50,
//                                                   width: 130,
//                                                   child: TextField(
//                                                     decoration: InputDecoration(
//                                                       labelStyle: TextStyle(
//                                                           color: Colors.white),
//                                                       labelText: 'L-name',
//                                                       focusedBorder: OutlineInputBorder(
//                                                           borderSide:
//                                                               BorderSide(
//                                                                   color: Colors
//                                                                       .white),
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           30))),
//                                                       enabledBorder: OutlineInputBorder(
//                                                           borderSide:
//                                                               BorderSide(
//                                                                   color: Colors
//                                                                       .white),
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           30))),
//                                                     ),
//                                                     obscureText: true,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 10,
//                                             ),
//                                             const Padding(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 10),
//                                               child: SizedBox(
//                                                 height: 50,
//                                                 child: TextField(
//                                                   decoration: InputDecoration(
//                                                     labelText: 'Phone',
//                                                     labelStyle: TextStyle(
//                                                         color: Colors.white),
//                                                     focusedBorder:
//                                                         OutlineInputBorder(
//                                                             borderSide:
//                                                                 BorderSide(
//                                                                     color: Colors
//                                                                         .white),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             30))),
//                                                     enabledBorder:
//                                                         OutlineInputBorder(
//                                                             borderSide:
//                                                                 BorderSide(
//                                                                     color: Colors
//                                                                         .white),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             30))),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(height: 10.0),
//                                             const Padding(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 10),
//                                               child: SizedBox(
//                                                 height: 50,
//                                                 child: TextField(
//                                                   decoration: InputDecoration(
//                                                     labelText: 'Email',
//                                                     labelStyle: TextStyle(
//                                                         color: Colors.white),
//                                                     focusedBorder:
//                                                         OutlineInputBorder(
//                                                             borderSide:
//                                                                 BorderSide(
//                                                                     color: Colors
//                                                                         .white),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             30))),
//                                                     enabledBorder:
//                                                         OutlineInputBorder(
//                                                             borderSide:
//                                                                 BorderSide(
//                                                                     color: Colors
//                                                                         .white),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             30))),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(height: 10.0),
//                                             const Padding(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 10),
//                                               child: SizedBox(
//                                                 height: 50,
//                                                 child: TextField(
//                                                   decoration: InputDecoration(
//                                                     labelText: 'Password',
//                                                     labelStyle: TextStyle(
//                                                         color: Colors.white),
//                                                     focusedBorder:
//                                                         OutlineInputBorder(
//                                                             borderSide:
//                                                                 BorderSide(
//                                                                     color: Colors
//                                                                         .white),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             30))),
//                                                     enabledBorder:
//                                                         OutlineInputBorder(
//                                                             borderSide:
//                                                                 BorderSide(
//                                                                     color: Colors
//                                                                         .white),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             30))),
//                                                   ),
//                                                   obscureText: true,
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(height: 10.0),
//                                             const Padding(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 10),
//                                               child: SizedBox(
//                                                 height: 50,
//                                                 child: TextField(
//                                                   decoration: InputDecoration(
//                                                     labelText:
//                                                         'Confirm Password',
//                                                     labelStyle: TextStyle(
//                                                         color: Colors.white),
//                                                     focusedBorder:
//                                                         OutlineInputBorder(
//                                                             borderSide:
//                                                                 BorderSide(
//                                                                     color: Colors
//                                                                         .white),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             30))),
//                                                     enabledBorder:
//                                                         OutlineInputBorder(
//                                                             borderSide:
//                                                                 BorderSide(
//                                                                     color: Colors
//                                                                         .white),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             30))),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(height: 10.0),
//                                             Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 const SizedBox(
//                                                   width: 10,
//                                                 ),
//                                                 ElevatedButton(
//                                                   onPressed: () {
//                                                     Navigator.pop(context);
//                                                   },
//                                                   style:
//                                                       ElevatedButton.styleFrom(
//                                                     backgroundColor:
//                                                         Color.fromRGBO(
//                                                             168, 223, 241, 1),
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               20),
//                                                     ),
//                                                     elevation:
//                                                         10, // adjust the elevation as desired
//                                                   ),
//                                                   child: const Text('Signup',
//                                                       style: TextStyle(
//                                                           color: Colors.black)),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
