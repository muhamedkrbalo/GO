import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../../core/custom_widgets/validation/validation_mixin.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

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


  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {

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
              contentPadding: AppPadding.v16h16,
              keyboardType: TextInputType.name,
              validator: validateName,
            ),
            AppSpacing.gapV20,
            CustomFormField(
              controller: _phoneController,
              title: AppLocaleKey.mobileNumber.tr(),
              hintText: AppLocaleKey.enterMobileNumber.tr(),
          
              contentPadding: AppPadding.v16h16,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              prefixIcon: const CountryCodePicker(),
              validator: validatePhone,
            ),
            AppSpacing.gapV20,
            CustomFormField(
              controller: _emailController,
              title: AppLocaleKey.emailAddress.tr(),
              hintText: AppLocaleKey.enterEmailAddress.tr(),
          
              contentPadding: AppPadding.v16h16,
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
            ),
            AppSpacing.gapV20,
            CustomFormField(
              controller: _passwordController,
              title: AppLocaleKey.password.tr(),
              hintText: AppLocaleKey.createAPassword.tr(),
             
              contentPadding: AppPadding.v16h16,
              isPassword: true,
              passwordToggleBuilder: passwordToggle,
              validator: validateNewPassword,
            ),
            AppSpacing.gapV20,
            CustomFormField(
              controller: _confirmPasswordController,
              title: AppLocaleKey.confirmPassword.tr(),
              hintText: AppLocaleKey.reEnterYourPassword.tr(),
            
              contentPadding: AppPadding.v16h16,
              isPassword: true,
              passwordToggleBuilder: passwordToggle,
              validator: validateConfirmPassword,
            ),
            AppSpacing.gapV24,
            CustomButton(
              text: AppLocaleKey.continue_.tr(),
              hasShadow: true,
              boxShadow: AppShadows.primaryButton,
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}
