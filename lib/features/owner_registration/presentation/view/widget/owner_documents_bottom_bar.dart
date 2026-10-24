import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/owner_documents_cubit.dart';
import 'registration_bottom_bar.dart';

class OwnerDocumentsBottomBar extends StatelessWidget {
  const OwnerDocumentsBottomBar({super.key});

  static const _buttonHeight = 51.2;
  static const _backMinSize = Size(64, 32);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return RegistrationBottomBar(
      children: [
        BlocSelector<OwnerDocumentsCubit, OwnerDocumentsState, bool>(
          selector: (state) => state.isComplete,
          builder: (context, isComplete) => CustomButton(
            text: AppLocaleKey.continueToReview.tr(),
            height: _buttonHeight,
            isEnabled: isComplete,
            hasShadow: true,
          ),
        ),
        TextButton(
          onPressed: context.pop,
          style: TextButton.styleFrom(
            minimumSize: _backMinSize,
            foregroundColor: colors.accentText,
            textStyle: AppTextStyles.xsBold,
          ),
          child: Text(AppLocaleKey.back.tr()),
        ),
      ],
    );
  }
}
