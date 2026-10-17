import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/custom_widgets/custom_toast/custom_toast.dart';
import '../network/connection_checker.dart';
import '../cache/hive/hive_methods.dart';
import '../custom_widgets/custom_select/custom_select_item.dart';
import '../extension/context_extension.dart';
import '../routes/app_routers.dart';
import 'package:easy_localization/easy_localization.dart';
import '../locale/app_locale_key.dart';
import '../services/service_locator.dart';
import 'package:flutter_hr_erb/core/theme/app_colors.dart';
import 'package:flutter_hr_erb/core/theme/extensions/theme_extensions.dart';

class CommonMethods {
  static void showAlertDialog({String? title, required String message}) {
    showCupertinoDialog(
      context: AppRouters.navigatorKey.currentContext!,
      builder: (context) => CupertinoAlertDialog(
        title: title != null
            ? Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: context.fontFamily(),
                ),
              )
            : null,
        content: Text(
          message,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: context.fontFamily(),
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              AppLocaleKey.ok.tr(),
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: context.fontFamily(),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }

  static void showChooseDialog(
    BuildContext context, {
    String? title,
    required String message,
    required VoidCallback onPressed,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: title != null
            ? Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: context.fontFamily(),
                ),
              )
            : null,
        content: Text(
          message,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: context.fontFamily(),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              AppLocaleKey.no.tr(),
              style: TextStyle(
                color: context.customColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: context.fontFamily(),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            onPressed: onPressed,
            child: Text(
              AppLocaleKey.yes.tr(),
              style: TextStyle(
                color: context.customColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: context.fontFamily(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void showToast({
    required String message,
    String? title,
    ToastType type = ToastType.success,
    Color? backgroundColor,
    Color? textColor,
    int seconds = 3,
  }) {
    BotToast.showCustomText(
      duration: Duration(seconds: seconds),
      toastBuilder: (cancelFunc) => CustomToast(
        type: type,
        title: title,
        message: message,
        backgroundColor: backgroundColor,
        textColor: textColor,
      ),
    );
  }

  static void showError({
    required String message,
    String? title,
    ToastType type = ToastType.error,
    Color? backgroundColor,
    Color? textColor,
    int seconds = 3,
  }) {
    BotToast.showCustomText(
      duration: Duration(seconds: seconds),
      toastBuilder: (context) => CustomToast(
        type: type,
        title: title,
        message: message,
        backgroundColor: backgroundColor,
        textColor: textColor,
      ),
    );
  }
  // static void showToast({
  //   required String message,
  //   String? title,
  //   //  String? icon,
  //   ToastType type = ToastType.success,
  //   Color? backgroundColor,
  //   Color? textColor,
  //   int seconds = 3,
  // }) {
  //   BotToast.showCustomText(
  //     duration: Duration(seconds: seconds),
  //     toastBuilder: (cancelFunc) => CustomToast(
  //       type: type,
  //       title: title,
  //       message: message,
  //       backgroundColor: backgroundColor,
  //       //icon: icon,
  //       textColor: textColor,
  //     ),
  //   );
  // }

  // static void showError({
  //   required String message,
  //   String? title,
  //   String? icon,
  //   Color? backgroundColor,
  //   Color? textColor,
  //   int seconds = 3,
  // }) {
  //   //  BotToast.showText(text: message,backgroundColor: backgroundColor );

  //   BotToast.showCustomText(
  //     duration: Duration(seconds: seconds),
  //     toastBuilder: (context) => CustomToast(
  //       title: title,
  //       message: message,
  //       backgroundColor: backgroundColor,
  //       //icon: icon,
  //       textColor: textColor,
  //     ),
  //   );
  // }

  // static Future<bool> hasConnection() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult.contains(ConnectivityResult.mobile)) {
  //     return true;
  //   } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  static List<CustomSelectItem> dropdownMenuItems =
      [
            ...List.generate(
              20,
              (index) => {
                'id': index,
                'value': AppRouters.navigatorKey.currentContext!.apiTr(
                  ar: 'العنصر ${index + 1}',
                  en: 'Item ${index + 1}',
                ),
              },
            ),
          ]
          .map(
            (e) => CustomSelectItem(
              value: int.tryParse(e['id'].toString()),
              name: e['value']?.toString() ?? "",
            ),
          )
          .toList();

  static void changeLanguage(BuildContext context, {required VoidCallback onTap}) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          AppLocaleKey.language.tr(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: context.fontFamily(),
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              setLanguage(context, const Locale('ar'));
              onTap.call();
              // ElectronicEngineer.setMyAppState(context);
              Navigator.pop(context);
            },
            child: Text(
              'العربية',
              style: TextStyle(
                fontFamily: context.fontFamilyAr(),
                color: context.locale == const Locale('ar')
                    ? AppColors.primary
                    : context.customColors.textPrimary,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              setLanguage(context, const Locale('en'));
              onTap.call();
              // ElectronicEngineer.setMyAppState(context);
              Navigator.pop(context);
            },
            child: Text(
              'English',
              style: TextStyle(
                fontFamily: context.fontFamilyEn(),
                color: context.locale == const Locale('en')
                    ? AppColors.primary
                    : context.customColors.textPrimary,
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            AppLocaleKey.cancel.tr(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: context.fontFamily(),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  /// The only way to change the app language: persists it to Hive (read by
  /// startup and the API interceptor) and updates the UI.
  static Future<void> setLanguage(BuildContext context, Locale locale) {
    HiveMethods.updateLang(locale);
    return context.setLocale(locale);
  }

  static Future<bool> hasConnection() async {
    return await sl<ConnectionChecker>().isConnected;
  }

  static bool endScroll(ScrollEndNotification t, VoidCallback onEnd) {
    if (t.metrics.pixels > 0 && t.metrics.atEdge) {
      onEnd.call();
    }
    return true;
  }
}
