import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/custom_form_field/custom_otp_field.dart';
import '../../controller/verify_code_cubit.dart';

class VerificationCodeInput extends StatefulWidget {
  const VerificationCodeInput({super.key});

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VerifyCodeCubit>();

    return BlocListener<VerifyCodeCubit, VerifyCodeState>(
      listenWhen: (previous, current) => current.code.isEmpty && previous.code.isNotEmpty,
      listener: (_, _) => _controller.clear(),
      child: BlocSelector<VerifyCodeCubit, VerifyCodeState, (bool, bool)>(
        selector: (state) =>
            (state.hasError, !state.isLocked && state.status != VerifyCodeStatus.verifying),
        builder: (context, field) => CustomOtpField(
          controller: _controller,
          hasError: field.$1,
          enabled: field.$2,
          onChanged: cubit.codeChanged,
        ),
      ),
    );
  }
}
