import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_todo/theme.dart';

import 'package:flutter_todo/components/widgets.dart';
import 'package:posprovider/appProvider.dart';
import 'package:posprovider/posDbProvider.dart';

class LogIn extends ConsumerStatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends ConsumerState<LogIn> {
  bool _isLogin = true;
  String? _errorMessage;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController()..addListener(clearError);
    _passwordController = TextEditingController()..addListener(clearError);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.only(top: 30),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(_isLogin ? 'Log In' : 'Sign Up',
                    style: const TextStyle(fontSize: 25)),
                loginField(_emailController,
                    labelText: "Email",
                    hintText: "Enter valid email like abc@gmail.com"),
                loginField(_passwordController,
                    labelText: "Password",
                    hintText: "Enter secure password",
                    obscure: true),
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Text(
                      "Please login or register with a Device Sync user account. This is separate from your Atlas Cloud login.",
                      textAlign: TextAlign.center),
                ),
                loginButton(context,
                    child: Text(_isLogin ? "Log in" : "Sign up"),
                    onPressed: () => _logInOrSignUpUser(context,
                        _emailController.text, _passwordController.text)),
                TextButton(
                    onPressed: () => setState(() => _isLogin = !_isLogin),
                    child: Text(
                      _isLogin
                          ? "New to Flutter Realm Todo? Sign up"
                          : 'Already have an account? Log in.',
                    )),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text(_errorMessage ?? "",
                      style: errorTextStyle(context),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearError() {
    if (_errorMessage != null) {
      setState(() {
        // Reset error message when user starts typing
        _errorMessage = null;
      });
    }
  }

  void _logInOrSignUpUser(
      BuildContext context, String email, String password) async {
    final app = ref.read(appProvider.notifier);

    clearError();
    try {
      if (_isLogin) {
        await app.logInUserEmailPassword(email, password);
      } else {
        await app.registerUserEmailPassword(email, password);
      }
      final realm = ref.read(posDbProvider);
      realm.initRealm();
      Navigator.pushNamed(context, '/home');
    } catch (err) {
      setState(() {
        _errorMessage = err.toString();
      });
    }
  }
}
