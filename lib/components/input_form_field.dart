import 'package:flutter/material.dart';
import 'package:form_map/form_map.dart';

class InputFormField<T extends Enum> extends StatelessWidget {
  InputFormField({
    super.key,
    required this.inputName,
    required this.formMap,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.handeler,
    this.keyboardType,
    this.textInputAction,
  }) {
    if (handeler != null) {
      formMap.handelers[inputName] = handeler!;
    }
  }
  final T inputName;
  final FormMap<T> formMap;
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final dynamic Function(String value)? handeler;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: formMap[inputName],
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      onSaved: (newValue) => formMap[inputName] = newValue,
    );
  }
}
