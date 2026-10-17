import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cache/hive/hive_methods.dart';
import '../custom_widgets/custom_loading/custom_loading.dart';
import '../custom_widgets/custom_toast/custom_toast.dart';
import '../locale/app_locale_key.dart';
import '../theme/app_colors.dart';
import '../theme/extensions/theme_extensions.dart';
import 'context_extension.dart';

/// UI helpers (dialogs, sheets, toasts, loading, language).
///
/// They live on [BuildContext] on purpose: they are for the presentation layer
/// only. Repositories and services must not show UI — return a `Failure` and
/// let the screen react to the Cubit state.
extension UiContextExtension on BuildContext {
  //! Dialogs & bottom sheets

  Future<T?> showAppDialog<T>(Widget dialog, {bool willPop = true}) {
    return showDialog<T>(
      context: this,
      barrierDismissible: willPop,
      builder: (_) => PopScope(canPop: willPop, child: dialog),
    );
  }

  Future<T?> showAppBottomSheet<T>(
    Widget bottomSheet, {
    bool willPop = true,
    bool isScrollControlled = false,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      backgroundColor: Colors.transparent,
      elevation: 0,
      isScrollControlled: isScrollControlled,
      isDismissible: willPop,
      enableDrag: enableDrag,
      builder: (_) => PopScope(canPop: willPop, child: bottomSheet),
    );
  }

  Future<void> showAlertDialog({String? title, required String message}) {
    return showCupertinoDialog<void>(
      context: this,
      builder: (context) => CupertinoAlertDialog(
        title: title != null ? Text(title, style: context._dialogTitleStyle()) : null,
        content: Text(message, style: context._dialogMessageStyle()),
        actions: [
          CupertinoDialogAction(
            child: Text(
              AppLocaleKey.ok.tr(),
              style: context._dialogTitleStyle().copyWith(color: Colors.red),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  /// Yes/No dialog. [onConfirm] runs when the user taps "yes".
  Future<void> showChooseDialog({
    String? title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    return showCupertinoDialog<void>(
      context: this,
      builder: (context) {
        final actionStyle = context._dialogTitleStyle().copyWith(color: context.customColors.textPrimary);
        return CupertinoAlertDialog(
          title: title != null ? Text(title, style: context._dialogTitleStyle()) : null,
          content: Text(message, style: context._dialogMessageStyle()),
          actions: [
            CupertinoDialogAction(
              child: Text(AppLocaleKey.no.tr(), style: actionStyle),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              onPressed: onConfirm,
              child: Text(AppLocaleKey.yes.tr(), style: actionStyle),
            ),
          ],
        );
      },
    );
  }

  //! Toasts

  void showToast({
    required String message,
    String? title,
    ToastType type = ToastType.success,
    Color? backgroundColor,
    Color? textColor,
    int seconds = 3,
  }) {
    BotToast.showCustomText(
      duration: Duration(seconds: seconds),
      toastBuilder: (_) => CustomToast(
        type: type,
        title: title,
        message: message,
        backgroundColor: backgroundColor,
        textColor: textColor,
      ),
    );
  }

  void showErrorToast({
    required String message,
    String? title,
    Color? backgroundColor,
    Color? textColor,
    int seconds = 3,
  }) {
    showToast(
      message: message,
      title: title,
      type: ToastType.error,
      backgroundColor: backgroundColor,
      textColor: textColor,
      seconds: seconds,
    );
  }

  //! Loading overlay

  void showLoading({
    double size = 60,
    double radius = 30,
    double loadingSize = 30,
    Color? backgroundColor,
    Color? loadingColor,
  }) {
    FocusManager.instance.primaryFocus?.unfocus();
    final background = backgroundColor ?? Theme.of(this).scaffoldBackgroundColor;
    BotToast.showCustomLoading(
      toastBuilder: (_) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: CustomLoading(
            color: loadingColor ?? AppColors.primary,
            size: loadingSize,
          ),
        ),
      ),
    );
  }

  void hideLoading() => BotToast.closeAllLoading();

  //! Language

  /// The only way to change the app language: persists it to Hive (read by
  /// startup and the API interceptor) and updates the UI.
  Future<void> setAppLanguage(Locale locale) {
    HiveMethods.updateLang(locale);
    return setLocale(locale);
  }

  /// Action sheet to pick Arabic/English. [onChanged] runs after the change.
  Future<void> showLanguagePicker({VoidCallback? onChanged}) {
    Widget option(BuildContext context, Locale locale, String label, String fontFamily) {
      return CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          context.setAppLanguage(locale);
          onChanged?.call();
          Navigator.pop(context);
        },
        child: Text(
          label,
          style: TextStyle(
            fontFamily: fontFamily,
            color: context.locale == locale ? AppColors.primary : context.customColors.textPrimary,
          ),
        ),
      );
    }

    return showCupertinoModalPopup<void>(
      context: this,
      builder: (context) => CupertinoActionSheet(
        title: Text(AppLocaleKey.language.tr(), style: context._dialogTitleStyle()),
        actions: [
          option(context, const Locale('ar'), 'العربية', context.fontFamilyAr()),
          option(context, const Locale('en'), 'English', context.fontFamilyEn()),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(AppLocaleKey.cancel.tr(), style: context._dialogTitleStyle()),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  TextStyle _dialogTitleStyle() => TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily(),
      );

  TextStyle _dialogMessageStyle() => TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily(),
      );
}
