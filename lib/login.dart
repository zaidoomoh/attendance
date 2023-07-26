import 'package:attendance_by_biometrics/cubit.dart';
import 'package:attendance_by_biometrics/home.dart';
import 'package:attendance_by_biometrics/shared/components/components.dart';
import 'package:attendance_by_biometrics/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BiometricsCubit, BiometricsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<BiometricsCubit>(context);
        var formkey = GlobalKey<FormState>();
        return Scaffold(
          backgroundColor: const Color.fromRGBO(61, 124, 152, 1),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            height: 130.0,
                            child: Image.asset('assets/user.png',
                                fit: BoxFit.contain),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: defaultTextFormFeild(
                            warning: "قم بادخال رقم الموظف",
                            color: Colors.black,
                            controller: cubit.employeeIdController,
                            type: TextInputType.number,
                            onSubmit: () {},
                            onChange: () {},
                            label: "Employee ID",
                            prefix: Icons.numbers,
                            textInputFormatter:
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9 , .]')),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: defaultTextFormFeild(
                            warning: "قم بادخال كلمة المرور",
                            color: Colors.black,
                            controller: cubit.passwordController,
                            type: TextInputType.visiblePassword,
                            onSubmit: () {},
                            onChange: () {},
                            label: "Password",
                            prefix: Icons.password,
                            textInputFormatter:
                                FilteringTextInputFormatter.deny(""),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(168, 223, 241, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 10,
                          ),
                          child: const Text('Login',
                              style: TextStyle(color: Colors.black)),
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              await cubit
                                  .getEmployee(
                                      id: cubit.employeeIdController.text)
                                  .then((value) async {
                                Future.delayed(
                                  const Duration(seconds: 5),
                                  () async {
                                    await cubit.insertToDatabase(
                                        desc: cubit.descc!["desc"]);

                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      // Use the 'context' obtained from the widget's build method
                                      return Home();
                                    }));
                                  },
                                );

                                cubit.employeeIdController.clear();
                                cubit.passwordController.clear();
                              });
                            }
                            //

                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const Home()),
                            // );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
    );
  }
}
