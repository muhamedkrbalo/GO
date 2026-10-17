import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/custom_widgets/buttons/custom_button.dart';

// TODO: build the login UI. On success call `sl<AuthSession>().signIn(...)`;
// the router redirects to home on its own.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SizedBox(height: 300),
          CustomButton(
            text: 'Sign in with Google',
          ),
          Center(child: Text('Login Screen')),
        ],
      ),
    );
  }
}
