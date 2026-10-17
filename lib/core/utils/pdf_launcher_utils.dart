import 'package:flutter_hr_erb/core/utils/common_methods.dart';
import 'package:flutter_hr_erb/core/utils/url_launcher_methods.dart';

class PdfLauncherUtils {
  /// Open PDF from URL in browser
  static Future<void> openPdfFromUrl(String? url, {String? errorMessage}) async {
    if (url != null && url.isNotEmpty) {
      try {
        await UrlLauncherMethods.launchInBrowser(url);
      } catch (e) {
        CommonMethods.showError(message: e.toString());
      }
    } else {
      CommonMethods.showError(message: errorMessage ?? 'PDF not available');
    }
  }

  /// Open catalog PDF
  static Future<void> openCatalog(String? catalogUrl) async {
    await openPdfFromUrl(catalogUrl, errorMessage: 'Catalog not available');
  }

  /// Open inventory PDF
  static Future<void> openInventory(String? inventoryUrl) async {
    await openPdfFromUrl(inventoryUrl, errorMessage: 'Inventory not available');
  }

  /// Open terms and conditions PDF
  static Future<void> openTermsAndConditions(String? termsUrl) async {
    await openPdfFromUrl(termsUrl, errorMessage: 'Terms and conditions not available');
  }
}
