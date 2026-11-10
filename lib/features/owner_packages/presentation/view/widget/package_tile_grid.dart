import 'package:flutter/material.dart';

import '../../../../../core/theme/app_sizes.dart';

class PackageTileGrid extends StatelessWidget {
  const PackageTileGrid({super.key, required this.children});

  final List<Widget> children;

  static const _columns = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.s8,
      children: [
        for (var start = 0; start < children.length; start += _columns)
          Row(
            spacing: AppSpacing.s8,
            children: [
              for (var index = start; index < start + _columns; index++)
                Expanded(
                  child: index < children.length ? children[index] : const SizedBox.shrink(),
                ),
            ],
          ),
      ],
    );
  }
}
