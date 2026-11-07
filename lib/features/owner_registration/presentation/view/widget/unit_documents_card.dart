import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_document.dart';
import '../../../data/model/owner_unit.dart';
import '../../controller/owner_documents_cubit.dart';
import 'document_upload_card.dart';

class UnitDocumentsCard extends StatefulWidget {
  const UnitDocumentsCard({super.key, required this.unit, this.initiallyExpanded = false});

  final OwnerUnit unit;
  final bool initiallyExpanded;

  @override
  State<UnitDocumentsCard> createState() => _UnitDocumentsCardState();
}

class _UnitDocumentsCardState extends State<UnitDocumentsCard> {
  late bool _isExpanded = widget.initiallyExpanded;

  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _duration = Duration(milliseconds: 220);
  static const _bodyPadding = EdgeInsetsDirectional.all(10);

  void _toggle() => setState(() => _isExpanded = !_isExpanded);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final unit = widget.unit;

    return Material(
      color: colors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: _radius,
        side: BorderSide(color: colors.subtleBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _UnitDocumentsHeader(unit: unit, isExpanded: _isExpanded, onTap: _toggle),
          AnimatedSize(
            duration: _duration,
            curve: Curves.fastOutSlowIn,
            alignment: AlignmentDirectional.topCenter,
            child: _isExpanded
                ? DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.canvas,
                      border: Border(top: BorderSide(color: colors.subtleBorder)),
                    ),
                    child: Padding(
                      padding: _bodyPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (final type in DocumentType.unitTypes) ...[
                            if (type != DocumentType.unitTypes.first) AppSpacing.gapV10,
                            DocumentUploadCard(slot: DocumentSlot(type, unitId: unit.id)),
                          ],
                        ],
                      ),
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

class _UnitDocumentsHeader extends StatelessWidget {
  const _UnitDocumentsHeader({required this.unit, required this.isExpanded, required this.onTap});

  final OwnerUnit unit;
  final bool isExpanded;
  final VoidCallback onTap;

  static const _minHeight = 58.0;
  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 11);
  static const _toggleSize = 26.0;
  static const _toggleIconSize = 16.0;
  static const _lineGap = SizedBox(height: 4);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      button: true,
      expanded: isExpanded,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: _minHeight),
          child: Padding(
            padding: _padding,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocaleKey.unitWithVillage.tr(args: [unit.name, unit.village]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.xxxsBold.copyWith(
                          color: colors.textSecondary,
                          height: _textHeight,
                        ),
                      ),
                      _lineGap,
                      BlocSelector<OwnerDocumentsCubit, OwnerDocumentsState, int>(
                        selector: (state) => state.uploadedCountOf(unit.id),
                        builder: (context, uploaded) => Text(
                          AppLocaleKey.uploadedCount.tr(
                            args: ['$uploaded', '${DocumentType.unitTypes.length}'],
                          ),
                          style: AppTextStyles.xxxxxsMedium.copyWith(
                            color: colors.textMuted,
                            fontWeight: FontWeight.w400,
                            height: _textHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.gapH8,
                DecoratedBox(
                  decoration: BoxDecoration(color: colors.iconTileSurface, shape: BoxShape.circle),
                  child: SizedBox.square(
                    dimension: _toggleSize,
                    child: Icon(
                      isExpanded ? Icons.remove_rounded : Icons.add_rounded,
                      size: _toggleIconSize,
                      color: colors.oceanAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
