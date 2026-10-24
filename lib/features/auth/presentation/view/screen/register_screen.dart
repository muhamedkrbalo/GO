import 'package:flutter/material.dart';

import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../widget/auth_step_header.dart';
import '../widget/have_account_prompt.dart';
import '../widget/register_form.dart';
import '../widget/register_title.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(24, 22, 24, 40);
  static const _titleToFormGap = 30.0;
  static const _formToPromptGap = 28.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColors.canvas,
      body: const SafeArea(
        child: Column(
          children: [
            AuthStepHeader(step: 1, stepCount: 3),
            Expanded(
              child: SingleChildScrollView(
                padding: _contentPadding,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RegisterTitle(),
                    SizedBox(height: _titleToFormGap),
                    RegisterForm(),
                    SizedBox(height: _formToPromptGap),
                    HaveAccountPrompt(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
