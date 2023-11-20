import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key,
      this.onChanged,
      required this.hintText,
      this.obscurePW = false})
      : super(key: key);

  Function(String)? onChanged;
  String? hintText;
  bool? obscurePW;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscurePW!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'value is wrong';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white, fontSize: 18),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
