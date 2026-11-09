import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/dotted_decoration/dotted_decoration.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_review_status.dart';
import '../../controller/broker_registration_status_cubit.dart';

class BrokerStatusPreviewControls extends StatelessWidget {
  const BrokerStatusPreviewControls({super.key});

  static const _radius = BorderRadius.all(Radius.circular(9));
  static const _padding = EdgeInsetsDirectional.all(10);
  static const _dash = [3, 2];
  static const _titleGap = SizedBox(height: 7);
  static const _buttonGap = 6.0;
  static const _letterSpacing = 0.7;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.goldSurface, borderRadius: _radius),
      child: DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: DottedDecoration(
          shape: Shape.box,
          borderRadius: _radius,
          color: colors.accentBar,
          dash: _dash,
        ),
        child: Padding(
          padding: _padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocaleKey.prototypeStatusControls.tr().toUpperCase(),
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.stepLabel,
                  fontWeight: FontWeight.w700,
                  letterSpacing: _letterSpacing,
                  height: _textHeight,
                ),
              ),
              _titleGap,
              BlocSelector<
                BrokerRegistrationStatusCubit,
                BrokerRegistrationStatusState,
                List<BrokerReviewStatus>
              >(
                selector: (state) => state.previewOptions,
                builder: (context, options) => Wrap(
                  spacing: _buttonGap,
                  runSpacing: _buttonGap,
                  children: [for (final option in options) _PreviewButton(status: option)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviewButton extends StatelessWidget {
  const _PreviewButton({required this.status});

  final BrokerReviewStatus status;

  static const _minSize = Size(0, 34);
  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 10);
  static const _shape = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)));
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return OutlinedButton(
      onPressed: () => context.read<BrokerRegistrationStatusCubit>().previewStatus(status),
      style: OutlinedButton.styleFrom(
        minimumSize: _minSize,
        padding: _padding,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: colors.surface,
        foregroundColor: colors.goldLink,
        side: BorderSide(color: colors.accentBar),
        shape: _shape,
        textStyle: AppTextStyles.xxxxxsMedium.copyWith(
          fontWeight: FontWeight.w700,
          height: _textHeight,
        ),
      ),
      child: Text(status.previewKey.tr()),
    );
  }
}
