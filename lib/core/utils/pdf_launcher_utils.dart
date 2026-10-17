import 'package:flutter/widgets.dart';
import 'package:flutter_hr_erb/core/extension/context_ui_extension.dart';
import 'package:flutter_hr_erb/core/utils/url_launcher_methods.dart';

class PdfLauncherUtils {
  /// Open PDF from URL in browser
  static Future<void> openPdfFromUrl(BuildContext context, String? url, {String? errorMessage}) async {
    if (url != null && url.isNotEmpty) {
      try {
        await UrlLauncherMethods.launchInBrowser(url);
      } catch (e) {
        if (context.mounted) context.showErrorToast(message: e.toString());
      }
    } else {
      context.showErrorToast(message: errorMessage ?? 'PDF not available');
    }
  }

  /// Open catalog PDF
  static Future<void> openCatalog(BuildContext context, String? catalogUrl) async {
    await openPdfFromUrl(context, catalogUrl, errorMessage: 'Catalog not available');
  }

  /// Open inventory PDF
  static Future<void> openInventory(BuildContext context, String? inventoryUrl) async {
    await openPdfFromUrl(context, inventoryUrl, errorMessage: 'Inventory not available');
  }

  /// Open terms and conditions PDF
  static Future<void> openTermsAndConditions(BuildContext context, String? termsUrl) async {
    await openPdfFromUrl(context, termsUrl, errorMessage: 'Terms and conditions not available');
  }
}
