import 'package:flutter/material.dart';

Widget MyTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  required String? Function(String?) validate,
  required String lable,
  required IconData preFix,
  IconData? suffix,
  bool isItPassword = false,
  bool isClicakable = true,
  void Function()? suffixpressed,
  void Function()? onTap,
  bool showCursor = false,
    bool readOnly = false,

}) =>
    TextFormField(
      
      showCursor: showCursor,
      readOnly: readOnly,
      enabled: isClicakable,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      obscureText: isItPassword,
      decoration: InputDecoration(
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixpressed,
                icon: Icon(suffix),
              )
            : null,
        labelText: lable,
        prefixIcon: Icon(
          preFix,
        ),
        border: OutlineInputBorder(),
      ),
      validator: validate,
      onTap: onTap,
    );
