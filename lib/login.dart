// import 'package:attendance_by_biometrics/cubit.dart';
// import 'package:attendance_by_biometrics/home.dart';
// import 'package:attendance_by_biometrics/signup.dart';
// import 'package:attendance_by_biometrics/states.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
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
//                   height: 220,
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       color: Color.fromRGBO(115, 176, 205, 1),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 10),
//                             child: SizedBox(
//                               height: 130.0,
//                               child: Image.asset('assets/login.png',
//                                   fit: BoxFit.contain),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 10),
//                             child: SizedBox(
//                               height: 50,
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   labelText: 'Email',
//                                   labelStyle: TextStyle(color: Colors.white),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Colors.white),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(30))),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Colors.white),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(30))),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20.0),
//                           const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 10),
//                             child: SizedBox(
//                               height: 50,
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   labelText: 'Password',
//                                   labelStyle: TextStyle(color: Colors.white),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Colors.white),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(30))),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Colors.white),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(30))),
//                                 ),
//                                 obscureText: true,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 10.0),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor:
//                                       Color.fromRGBO(168, 223, 241, 1),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   elevation:
//                                       10, // adjust the elevation as desired
//                                 ),
//                                 child: const Text('Login',
//                                     style: TextStyle(color: Colors.black)),
//                                 onPressed: () {
                                  
//                                   // Perform login functionality
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => const Home()),
//                                   );
//                                 },
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(bottom: 10),
//                                 child: Row(
//                                   children: [
//                                     const Padding(
//                                       padding: EdgeInsets.only(left: 5),
//                                       child: Text("don't have\naccount?"),
//                                     ),
//                                     const SizedBox(
//                                       width: 20,
//                                     ),
//                                     ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor:
//                                             Color.fromRGBO(168, 223, 241, 1),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(20),
//                                         ),
//                                         elevation:
//                                             10, // adjust the elevation as desired
//                                       ),
//                                       child: const Text('Signup',
//                                           style: TextStyle(color: Colors.black)),
//                                       onPressed: () {
//                                         // Perform login functionality
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const SignupPage()),
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
