import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'package_details_section_card.dart';

class PackageTermsCard extends StatelessWidget {
  const PackageTermsCard({super.key, required this.title, required this.summary});

  final String title;
  final String summary;

  static const _titleGap = 6.0;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    return PackageDetailsSectionCard(
      title: title,
      isTitleBold: true,
      titleGap: _titleGap,
      child: Text(
        summary,
        style: AppTextStyles.xxxxxsMedium.copyWith(
          color: context.customColors.textMuted,
          fontWeight: FontWeight.w400,
          height: _textHeight,
        ),
      ),
    );
  }
}
