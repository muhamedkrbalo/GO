import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/owner_packages_cubit.dart';

class NoPackageOptionsMessage extends StatelessWidget {
  const NoPackageOptionsMessage({super.key, required this.message});

  final String message;

  static const _padding = EdgeInsetsDirectional.symmetric(vertical: 24);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final isEmpty = context.select<OwnerPackagesCubit, bool>(
      (cubit) => cubit.state.packages.isEmpty,
    );
    if (!isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: _padding,
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.xsRegular.copyWith(
          color: context.customColors.textMuted,
          height: _textHeight,
        ),
      ),
    );
  }
}
