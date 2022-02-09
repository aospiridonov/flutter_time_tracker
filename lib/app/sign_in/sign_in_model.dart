import 'package:flutter_time_tracker/app/sign_in/validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidator {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
    this.isShowPassword = false,
  });

  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;
  final bool isShowPassword;

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an account';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String? get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String? get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  EmailSignInModel copyWith({
    String? email,
    String? password,
    EmailSignInFormType? formType,
    bool? isLoading,
    bool? submitted,
    bool? isShowPassword,
  }) {
    return EmailSignInModel(
        email: email ?? this.email,
        password: password ?? this.password,
        formType: formType ?? this.formType,
        isLoading: isLoading ?? this.isLoading,
        submitted: submitted ?? this.submitted,
        isShowPassword: isShowPassword ?? this.isShowPassword);
  }
}
