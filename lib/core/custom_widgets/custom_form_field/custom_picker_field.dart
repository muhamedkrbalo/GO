import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/extensions/theme_extensions.dart';
import 'custom_form_field.dart';

class CustomPickerField extends StatefulWidget {
  const CustomPickerField({
    super.key,
    required this.title,
    required this.hintText,
    required this.icon,
    required this.onTap,
    this.value,
    this.isRequired = false,
    this.validator,
  });

  final String title;
  final String hintText;
  final String icon;
  final VoidCallback onTap;
  final String? value;
  final bool isRequired;
  final String? Function(String?)? validator;

  static const _iconSize = 17.6;
  static const _radius = 12.0;

  @override
  State<CustomPickerField> createState() => _CustomPickerFieldState();
}

class _CustomPickerFieldState extends State<CustomPickerField> {
  late final _controller = TextEditingController(text: widget.value);

  @override
  void didUpdateWidget(CustomPickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) _controller.text = widget.value ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      controller: _controller,
      title: widget.title,
      isRequired: widget.isRequired,
      hintText: widget.hintText,
      readOnly: true,
      onTap: widget.onTap,
      validator: widget.validator,
      radius: CustomPickerField._radius,
      textStyle: AppTextStyles.sRegular.copyWith(color: context.customColors.textSecondary),
      contentPadding: AppPadding.v16h16,
      suffixIcon: Center(
        widthFactor: 1,
        child: SvgPicture.asset(
          widget.icon,
          width: CustomPickerField._iconSize,
          height: CustomPickerField._iconSize,
          colorFilter: ColorFilter.mode(context.customColors.textMuted, BlendMode.srcIn),
        ),
      ),
    );
  }
}
