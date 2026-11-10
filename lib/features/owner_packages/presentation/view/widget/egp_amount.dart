import 'package:easy_localization/easy_localization.dart';

import '../../../../../core/locale/app_locale_key.dart';

final _amountFormat = NumberFormat('#,##0.00', 'en');

String formatEgpAmount(double amount) =>
    AppLocaleKey.egpAmount.tr(args: [_amountFormat.format(amount)]);
