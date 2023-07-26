import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget defaultTextFormFeild(
        {required TextEditingController controller,
        required TextInputType type,
        required Function onSubmit,
        required Function onChange,
        required String label,
        required IconData prefix,
        required Color color,
        String? warning,
        TextInputFormatter? textInputFormatter}) =>
    SizedBox(
        child: TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: ((value) {
        onSubmit;
      }),
      onChanged: ((value) {
        onChange();
      }),
      validator: (value) {
        if (value!.isEmpty) {
          return warning;
        }
        // if (controller.isNull) {
        //   return 'Password must be at least 6 characters long.';
        // }
        return null;
      },
      inputFormatters: <TextInputFormatter>[textInputFormatter!],
      decoration: InputDecoration(
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        labelStyle: const TextStyle(color: Colors.white, fontSize: 20),
        labelText: label,
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(borderSide: BorderSide(color: color)),
        prefixIconColor: Colors.white,
      ),
    ));
