import 'dart:async';

import 'package:flutter_time_tracker/app/sign_in/email_sign_in_model.dart';
import 'package:flutter_time_tracker/services/auth.dart';
import 'package:rxdart/rxdart.dart';

class EmailSignInBloc {
  EmailSignInBloc({required this.auth});

  final AuthBase auth;

  final _modelSubject =
      BehaviorSubject<EmailSignInModel>.seeded(EmailSignInModel());

  Stream<EmailSignInModel> get modelStream => _modelSubject.stream;

  EmailSignInModel get model => _modelSubject.value;

  void dispose() {
    _modelSubject.close();
  }

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);

    try {
      if (model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(
          model.email,
          model.password,
        );
      } else {
        await auth.createUserWithEmailAndPassword(
          model.email,
          model.password,
        );
      }
    } catch (_) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void toggleFormType() {
    final formType = model.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void toggleVisibilityPassword() => updateWith(
        isShowPassword: !model.isShowPassword,
      );

  void updateWith(
      {String? email,
      String? password,
      EmailSignInFormType? formType,
      bool? isLoading,
      bool? submitted,
      bool? isShowPassword}) {
    _modelSubject.add(model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
      isShowPassword: isShowPassword,
    ));
  }
}
