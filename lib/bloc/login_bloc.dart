import 'dart:async';

import 'dart:math';

import 'package:flutter/material.dart';
import 'file:///D:/Flutter/Flutter_Login_Bloc/flutter_login_bloc/lib/validation/email_validator.dart';
import 'file:///D:/Flutter/Flutter_Login_Bloc/flutter_login_bloc/lib/validation/password_validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Object with EmailValidator, PasswordValidator {
  final BehaviorSubject<String> _emailStreamController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordStreamController =
      BehaviorSubject<String>();

  // INPUT for Email
  Function(String) get emailChanged => _emailStreamController.sink.add;

  //OUTPUT For Email

  Stream<String> get emailStream =>
      _emailStreamController.stream.transform(validateEmail);

  //INPUT for Password

  Function(String) get passwordChanged => _passwordStreamController.sink.add;

  //OUTPUT For password

  Stream<String> get passwordStream =>
      _passwordStreamController.stream.transform(validatePassword);

  Stream<bool> get submitStream =>
      Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);

  void dispose() {
    _emailStreamController.close();
    _passwordStreamController.close();
  }
}
