import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/services/auth.dart';

class AuthProvider extends InheritedWidget {
  final AuthBase auth;

  const AuthProvider({
    Key? key,
    required this.auth,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static AuthBase of(BuildContext context) {
    AuthProvider? provider =
        context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    assert(provider != null, 'No AuthBase found in context');
    return provider!.auth;
  }
}
