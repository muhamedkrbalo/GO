import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import 'package_option_tile.dart';
import 'package_tile_grid.dart';

enum _SubscriptionAction {
  usageAndLimits(AppLocaleKey.usageAndLimits),
  upgrade(AppLocaleKey.upgrade),
  downgrade(AppLocaleKey.downgrade),
  renew(AppLocaleKey.renew),
  cancel(AppLocaleKey.cancel),
  viewHistory(AppLocaleKey.viewHistory),
  expiryStates(AppLocaleKey.expiryStates);

  const _SubscriptionAction(this.labelKey);

  final String labelKey;
}

class SubscriptionActionsGrid extends StatelessWidget {
  const SubscriptionActionsGrid({super.key});

  VoidCallback? _handlerFor(BuildContext context, _SubscriptionAction action) {
    return switch (action) {
      _SubscriptionAction.upgrade ||
      _SubscriptionAction.downgrade => () => context.pushNamed(RouteNames.ownerPackages),
      _SubscriptionAction.usageAndLimits ||
      _SubscriptionAction.renew ||
      _SubscriptionAction.cancel ||
      _SubscriptionAction.viewHistory ||
      _SubscriptionAction.expiryStates => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return PackageTileGrid(
      children: [
        for (final action in _SubscriptionAction.values)
          PackageOptionTile(label: action.labelKey.tr(), onTap: _handlerFor(context, action)),
      ],
    );
  }
}
