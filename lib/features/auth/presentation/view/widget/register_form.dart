import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../../core/custom_widgets/validation/validation_mixin.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/verify_account_args.dart';
import '../../controller/register_cubit.dart';
import 'country_code_picker.dart';
import 'password_visibility_icon.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  static const _fieldGap = SizedBox(height: 17);
  static const _buttonHeight = 52.0;
  static const _buttonRadius = 12.0;

  late final _fields = [
    _nameController,
    _phoneController,
    _emailController,
    _passwordController,
    _confirmPasswordController,
  ];

  bool get _isFilled => _fields.every((controller) => controller.text.trim().isNotEmpty);

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    // if (!(_formKey.currentState?.validate() ?? false)) return;
    context.pushNamed(
      RouteNames.verifyAccount,
      extra: VerifyAccountArgs(
        phoneCode: context.read<RegisterCubit>().state.country.phoneCode,
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    Widget passwordToggle(bool isObscured) => PasswordVisibilityIcon(isObscured: isObscured);

    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: Column(
          children: [
            CustomFormField(
              controller: _nameController,
              title: AppLocaleKey.fullName.tr(),
              hintText: AppLocaleKey.enterYourFullName.tr(),
             
              keyboardType: TextInputType.name,
              validator: validateName,
            ),
            _fieldGap,
            CustomFormField(
              controller: _phoneController,
              title: AppLocaleKey.mobileNumber.tr(),
              hintText: AppLocaleKey.enterMobileNumber.tr(),
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              prefixIcon: const CountryCodePicker(),
              validator: validatePhone,
            ),
            _fieldGap,
            CustomFormField(
              controller: _emailController,
              title: AppLocaleKey.emailAddress.tr(),
              hintText: AppLocaleKey.enterEmailAddress.tr(),
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
            ),
            _fieldGap,
            CustomFormField(
              controller: _passwordController,
              title: AppLocaleKey.password.tr(),
              hintText: AppLocaleKey.createAPassword.tr(),
              isPassword: true,
              passwordToggleBuilder: passwordToggle,
              validator: validateNewPassword,
            ),
            _fieldGap,
            CustomFormField(
              controller: _confirmPasswordController,
              title: AppLocaleKey.confirmPassword.tr(),
              hintText: AppLocaleKey.reEnterYourPassword.tr(),
              isPassword: true,
              passwordToggleBuilder: passwordToggle,
              validator: validateConfirmPassword,
            ),
            AppSpacing.gapV24,
            ListenableBuilder(
              listenable: Listenable.merge(_fields),
              builder: (context, _) => CustomButton(
                text: AppLocaleKey.createAnAccount.tr(),
                height: _buttonHeight,
                radius: _buttonRadius,
                hasShadow: true,
                // isEnabled: _isFilled,
                disabledColor: colors.subtleBorder,
                disabledBorderColor: colors.subtleBorder,
                disabledTextColor: colors.grey,
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
