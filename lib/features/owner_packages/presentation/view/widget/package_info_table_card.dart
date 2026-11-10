import 'package:flutter/material.dart';

import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'package_info_row.dart';

typedef PackageInfoLine = (String label, String value);

class PackageInfoTableCard extends StatelessWidget {
  const PackageInfoTableCard({
    super.key,
    required this.lines,
    this.totalLine,
    this.isCompact = false,
  });

  final List<PackageInfoLine> lines;
  final PackageInfoLine? totalLine;
  final bool isCompact;

  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _compactRadius = BorderRadius.all(Radius.circular(12));
  static const _borderWidth = 1.6;
  static const _rowPadding = EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 9);
  static const _compactRowPadding = EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 10);
  static const _rowMinHeight = 43.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final totalLine = this.totalLine;
    final rowPadding = isCompact ? _compactRowPadding : _rowPadding;
    final rowMinHeight = isCompact ? 0.0 : _rowMinHeight;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: isCompact ? _compactRadius : _radius,
        border: Border.all(color: colors.subtleBorder, width: _borderWidth),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (index, (label, value)) in lines.indexed)
            PackageInfoRow(
              label: label,
              value: value,
              showDivider: totalLine != null || index < lines.length - 1,
              padding: rowPadding,
              minHeight: rowMinHeight,
            ),
          if (totalLine != null)
            PackageInfoRow(
              label: totalLine.$1,
              value: totalLine.$2,
              isHighlighted: true,
              isEmphasized: !isCompact,
              padding: rowPadding,
              minHeight: rowMinHeight,
            ),
        ],
      ),
    );
  }
}
