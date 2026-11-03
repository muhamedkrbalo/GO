import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/custom_form_field/custom_otp_field.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../controller/verify_code_cubit.dart';

class VerificationCodeInput extends StatefulWidget {
  const VerificationCodeInput({super.key});

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  static const _boxWidth = 48.0;
  static const _radius = BorderRadius.all(Radius.circular(11));
  static const _borderWidth = 1.0;

  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyCodeCubit, VerifyCodeState>(
      listenWhen: (previous, current) => current.code.isEmpty && previous.code.isNotEmpty,
      listener: (_, _) => _controller.clear(),
      child: CustomOtpField(
        controller: _controller,
        maxBoxWidth: _boxWidth,
        borderRadius: _radius,
        borderWidth: _borderWidth,
        boxShadow: AppShadows.otpBox,
        mainAxisAlignment: MainAxisAlignment.center,
        onChanged: context.read<VerifyCodeCubit>().codeChanged,
      ),
    );
  }
}
