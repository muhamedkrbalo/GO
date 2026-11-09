import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/custom_widgets/bottom_sheet/option_picker_sheet.dart';
import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/broker_village_selection_cubit.dart';

typedef _AreaChoice = ({String? area});

class BrokerVillageAreaDropdown extends StatelessWidget {
  const BrokerVillageAreaDropdown({super.key});

  static const _height = 44.0;
  static const _padding = EdgeInsetsDirectional.only(start: 15, end: 5);
  static const _radius = BorderRadius.all(Radius.circular(9));
  static const _borderWidth = 1.5;

  Future<void> _pickArea(BuildContext context, String? selected) async {
    final cubit = context.read<BrokerVillageSelectionCubit>();
    final allAreas = AppLocaleKey.allAreas.tr();
    final picked = await context.showAppBottomSheet<_AreaChoice>(
      OptionPickerSheet<_AreaChoice>(
        title: AppLocaleKey.areaDistrict.tr(),
        options: [(area: null), for (final area in cubit.state.areas) (area: area)],
        labelOf: (choice) => choice.area ?? allAreas,
        selected: (area: selected),
      ),
      isScrollControlled: true,
    );
    if (picked == null || cubit.isClosed) return;
    cubit.setArea(picked.area);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return BlocSelector<BrokerVillageSelectionCubit, BrokerVillageSelectionState, String?>(
      selector: (state) => state.area,
      builder: (context, area) => Material(
        color: colors.surface,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: _radius,
          side: BorderSide(
            color: area == null ? colors.subtleBorder : colors.oceanAccent,
            width: _borderWidth,
          ),
        ),
        child: InkWell(
          onTap: () => _pickArea(context, area),
          child: SizedBox(
            height: _height,
            child: Padding(
              padding: _padding,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      area ?? AppLocaleKey.allAreas.tr(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.xxxsRegular.copyWith(color: colors.textSecondary),
                    ),
                  ),
                  AppSpacing.gapH5,
                  SvgPicture.asset(
                    AppImages.assetsSvgChevronDown,
                    colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn),
                  ),
                  AppSpacing.gapH5,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
