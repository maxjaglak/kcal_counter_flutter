import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormFieldHelper {
  static Widget textField(TextEditingController controller,
      {ValidationCallback? validationCallback = null,
      FormFieldValidator<String>? validator = null,
      Color textColor = Colors.white,
      String hint = "",
      bool autoCorrect = true,
      bool obscureText = false,
      TextInputType textInputType = TextInputType.text,
      TextInputAction textInputAction = TextInputAction.done}) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.always,
        validator: _wrapValidation(controller, validator, validationCallback),
        autocorrect: autoCorrect,
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        style: TextStyle(
          color: textColor,
          fontSize: 15.0,
        ));
  }

  static FormFieldValidator<String> _wrapValidation(
      TextEditingController controller,
      FormFieldValidator<String>? validator,
      ValidationCallback? callback) {
    if (validator == null) {
      return (String? value) => null;
    }
    return (String? value) {
      final result = validator(value);
      if (callback != null) {
        callback(controller, result == null);
      }
      return result;
    };
  }
}

typedef ValidationCallback = void Function(
    TextEditingController controller, bool isValid);
