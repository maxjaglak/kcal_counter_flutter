import 'package:flutter/cupertino.dart';

class Validators {

  static FormFieldValidator<String> notEmptyValidator(String error) {
    return (String? value) {
      if(value?.isNotEmpty == true) {
        return null;
      }
      return error;
    };
  }

  static FormFieldValidator<String> urlValidator(String error) {
    return (String? value) {
      if(value?.isNotEmpty != true) {
        return error;
      }
      if(Uri.parse(value!).isAbsolute == true) {
        return null;
      }
      return error;
    };
  }



}