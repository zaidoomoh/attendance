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
        return null;
      },
      inputFormatters: <TextInputFormatter>[textInputFormatter!],
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.white,fontSize: 20),
        labelText: label,
        prefixIcon: Icon(prefix),
        border:  OutlineInputBorder(borderSide: BorderSide(color: color)),
        prefixIconColor: Colors.white,
      ),
    ));
