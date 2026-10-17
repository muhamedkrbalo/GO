import 'package:flutter/material.dart';

// TODO: build the login UI. On success call `sl<AuthSession>().signIn(...)`;
// the router redirects to home on its own.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Login Screen')),
    );
  }
}
