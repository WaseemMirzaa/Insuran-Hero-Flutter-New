import 'package:flutter/material.dart';

TextFormField customTextField(
    {required String hintText,
    required String? Function(String? vak) validator,
    TextInputType keyBoardType = TextInputType.text,
    required ValueChanged<String>? onChanged,
    VoidCallback? onTap}) {
  return TextFormField(
     validator: validator,
    onChanged: onChanged,
    enableSuggestions: false,
    autocorrect: false,
    keyboardType: keyBoardType,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.only(left: 8),
      hintText: hintText,
      hintStyle: const TextStyle(
        fontFamily: 'Calibri',
        fontSize: 14,
        color: Color(0xff808080),
      ),
      border: InputBorder.none,
    ),
  );
}
