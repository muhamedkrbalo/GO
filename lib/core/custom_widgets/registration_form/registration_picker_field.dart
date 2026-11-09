import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../images/app_images.dart';
import '../../theme/extensions/theme_extensions.dart';
import 'registration_text_field.dart';

class RegistrationPickerField extends StatefulWidget {
  const RegistrationPickerField({
    super.key,
    required this.title,
    required this.hintText,
    required this.onTap,
    this.value,
    this.isRequired = false,
    this.showChevron = true,
    this.validator,
  });

  final String title;
  final String hintText;
  final VoidCallback onTap;
  final String? value;
  final bool isRequired;
  final bool showChevron;
  final String? Function(String?)? validator;

  @override
  State<RegistrationPickerField> createState() => _RegistrationPickerFieldState();
}

class _RegistrationPickerFieldState extends State<RegistrationPickerField> {
  late final _controller = TextEditingController(text: widget.value);

  @override
  void didUpdateWidget(RegistrationPickerField oldWidget) {
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
    final colors = context.customColors;

    return RegistrationTextField(
      controller: _controller,
      title: widget.title,
      hintText: widget.hintText,
      isRequired: widget.isRequired,
      readOnly: true,
      onTap: widget.onTap,
      validator: widget.validator,
      suffixIcon: widget.showChevron
          ? Center(
              widthFactor: 1,
              child: SvgPicture.asset(
                AppImages.assetsSvgChevronDown,
                colorFilter: ColorFilter.mode(colors.hint, BlendMode.srcIn),
              ),
            )
          : null,
    );
  }
}
