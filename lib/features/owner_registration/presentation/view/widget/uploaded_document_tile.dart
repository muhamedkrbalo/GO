import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_document.dart';

class UploadedDocumentTile extends StatelessWidget {
  const UploadedDocumentTile({super.key, required this.document, required this.onRemove});

  final UploadedDocument document;
  final VoidCallback onRemove;

  static const _padding = EdgeInsetsDirectional.only(start: 10.4, end: 4, top: 6, bottom: 6);
  static const _radius = BorderRadius.all(Radius.circular(10.4));
  static const _borderWidth = 1.6;
  static const _checkCircleSize = 20.0;
  static const _checkIconSize = 13.6;
  static const _removeIconSize = 18.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.selectedSurface,
        borderRadius: _radius,
        border: Border.all(color: colors.primaryBorder, width: _borderWidth),
      ),
      child: Padding(
        padding: _padding,
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
              child: SizedBox.square(
                dimension: _checkCircleSize,
                child: Center(
                  child: SvgPicture.asset(
                    AppImages.assetsSvgCheck,
                    width: _checkIconSize,
                    height: _checkIconSize,
                    colorFilter: ColorFilter.mode(colors.onPrimary, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            AppSpacing.gapH8,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    document.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.xxsBold.copyWith(color: colors.textSecondary),
                  ),
                  Text(
                    '${document.sizeLabel} · ${AppLocaleKey.readyForReview.tr()}',
                    style: AppTextStyles.xxxsRegular.copyWith(color: colors.textMuted),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onRemove,
              tooltip: AppLocaleKey.removeDocument.tr(),
              icon: Icon(Icons.close_rounded, size: _removeIconSize, color: colors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
