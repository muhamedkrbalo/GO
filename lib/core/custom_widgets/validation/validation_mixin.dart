import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../locale/app_locale_key.dart';

mixin ValidationMixin<T extends StatefulWidget> on State<T> {
  String? validateName(String? value) {
    final RegExp nameRegExp = RegExp(r'^[\u0600-\u06FFa-zA-Z\s]+$');
    if (value == null || value.trim().isEmpty) {
      return tr(AppLocaleKey.validateName);
    } else if (!nameRegExp.hasMatch(value)) {
      return tr(AppLocaleKey.validateName);
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.trim().isEmpty) {
      return tr(AppLocaleKey.validateEmail);
    } else if (!_emailValidationStructure(value.trim())) {
      return tr(AppLocaleKey.validateEmailStructure);
    }
    return null;
  }

  bool _emailValidationStructure(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  String? validatePhone(String? value) {
    final phone = value?.trim() ?? '';
    if (phone.length < 7 || phone.length > 15 || int.tryParse(phone) == null) {
      return tr(AppLocaleKey.validatePhone);
    }
    return null;
  }

  String? validatePhoneSa(String? value) {
    if (value == null || value.isEmpty) {
      return tr(AppLocaleKey.validatePhone);
    }
    if (!value.validateSaudiPhoneNumber()) {
      return tr(AppLocaleKey.validatePhone);
    } else {
      return null;
    }
  }
  /*
  String? validatePhone(String? value, Country? country) {
    if (value!.trim().isEmpty) {
      return tr(AppLocaleKey.validatePhone);
    } else if (value.startsWith('0') &&
        (country != null &&
            (value.trim().length != (country.example.trim().length + 1)))) {
      return tr(
        AppLocaleKey.validatePhoneContainTenNumbers,
        args: [
          "${country.example.trim().length + 1}",
        ],
      );
    } else if (!value.startsWith('0') &&
        (country != null &&
            (value.trim().length != country.example.trim().length))) {
      return tr(
        AppLocaleKey.validatePhoneContainTenNumbers,
        args: [
          country.example.trim().length.toString(),
        ],
      );
    } else {
      return null;
    }
  }
  */

  String? validatePassword(String? value) {
    if (value!.trim().length < 8) {
      return tr(AppLocaleKey.validatePassword);
    }
    // else if (!validatePasswordStructure(value)) {
    //   return tr(AppLocaleKey.passwordStructureValidation);
    // }
    return null;
  }

  String _password = '';
  String? validateNewPassword(String? value) {
    _password = value!;
    if (value.trim().length < 8) {
      return tr(AppLocaleKey.validatePassword);
    } else if (!validatePasswordStructure(value)) {
      return tr(AppLocaleKey.passwordStructureValidation);
    }
    return null;
  }

  bool validatePasswordStructure(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  String? validateConfirmPassword(String? value) {
    if (value!.trim().length < 8) {
      return tr(AppLocaleKey.validatePassword);
    } else if (_password != value) {
      return tr(AppLocaleKey.validateConfirmPassword);
    }
    return null;
  }

  String? validateEmptyField(String? value) {
    if (value!.trim().isEmpty) {
      return tr(AppLocaleKey.validateEmpty);
    }
    return null;
  }

  /// Percentage for POA split: integer 1–99, optional `%` suffix.
  String? validatePoaSharePercent(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(AppLocaleKey.validateEmpty);
    }
    final raw = value.replaceAll('%', '').trim();
    final p = int.tryParse(raw);
    if (p == null || p <= 0 || p >= 100) {
      return tr(AppLocaleKey.validatePoaSharePercentRange);
    }
    return null;
  }

  String? validateEmptyDropDown(dynamic value) {
    if (value == null) {
      return tr(AppLocaleKey.validateEmpty);
    }
    return null;
  }

  String? validateEmptyMultiSelect(List<dynamic>? value) {
    if (value == null) {
      return tr(AppLocaleKey.validateEmpty);
    } else if (value.isEmpty) {
      return tr(AppLocaleKey.validateEmpty);
    }
    return null;
  }

  String? validateEgyptNationalId(String? value) {
    if (value == null || value.isEmpty) {
      return "من فضلك أدخل الرقم القومي";
    }

    value = value.trim();

    // لازم 14 رقم
    if (value.length != 14) {
      return "الرقم القومي يجب أن يكون 14 رقم";
    }

    // تحقق كلهم أرقام
    if (!RegExp(r'^\d{14}$').hasMatch(value)) {
      return "الرقم القومي يجب أن يحتوي على أرقام فقط";
    }

    // أول رقم (القرن)
    int century = int.parse(value[0]);
    if (century < 1 || century > 3) {
      return "الرقم القومي غير صالح";
    }

    // استخراج تاريخ الميلاد
    int year = int.parse(value.substring(1, 3));
    int month = int.parse(value.substring(3, 5));
    int day = int.parse(value.substring(5, 7));

    // إضافة القرن
    if (century == 2) {
      year += 1900;
    } else if (century == 3) {
      year += 2000;
    } else {
      year += 1800;
    }

    // تحقق الشهر
    if (month < 1 || month > 12) {
      return "تاريخ الميلاد غير صالح";
    }

    // تحقق اليوم
    if (day < 1 || day > 31) {
      return "تاريخ الميلاد غير صالح";
    }

    // تحقق التاريخ فعليًا
    try {
      DateTime date = DateTime(year, month, day);
      if (date.year != year || date.month != month || date.day != day) {
        return "تاريخ الميلاد غير صالح";
      }
    } catch (e) {
      return "تاريخ الميلاد غير صالح";
    }

    return null; // الرقم القومي صحيح
  }

  String? validateNationalIdSaudi(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter the ID or Iqama number";
    }

    // إزالة الفراغات
    value = value.trim();

    // تحقق من الطول
    if (value.length != 10) {
      return "ID/Iqama number must be 10 digits";
    }

    // تحقق من أن كل الأرقام أرقام فعلية
    final isNumeric = RegExp(r'^\d{10}$').hasMatch(value);
    if (!isNumeric) {
      return "ID/Iqama number must contain only digits";
    }

    // تحقق من الرقم الأول
    final firstDigit = value[0];
    if (firstDigit == '1' || firstDigit == '2') {
      return null; // صحيح: National ID
    } else if (firstDigit == '2' || firstDigit == '3' || firstDigit == '4') {
      return null; // صحيح: Iqama Number
    } else {
      return AppLocaleKey.invalidNationalId.tr();
    }
  }

  // String? validateNationalIdSaudi(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return tr(AppLocaleKey.invalidNationalId);
  //   }

  //   final v = value.trim();
  //   // Must be exactly 10 digits
  //   if (!RegExp(r'^\d{10}$').hasMatch(v)) {
  //     return tr(AppLocaleKey.invalidNationalId);
  //   }

  //   // Must start with 1 (citizen) or 2 (resident)
  //   if (!(v.startsWith('1') || v.startsWith('2'))) {
  //     return tr(AppLocaleKey.invalidNationalId);
  //   }

  //   // Validate using Luhn algorithm
  //   if (!_validateSaudiIdLuhn(v)) {
  //     return tr(AppLocaleKey.invalidNationalId);
  //   }

  //   return null;
  // }

  bool _validateSaudiIdLuhn(String id) {
    int sum = 0;
    for (int i = 0; i < id.length; i++) {
      int digit = int.parse(id[i]);
      // Double every even index from the left (0, 2, 4, ...)
      if (i % 2 == 0) {
        int doubled = digit * 2;
        sum += (doubled > 9) ? (doubled - 9) : doubled;
      } else {
        sum += digit;
      }
    }
    return sum % 10 == 0;
  }
}

bool hasMatch(String? s, String p) {
  return (s == null) ? false : RegExp(p).hasMatch(s);
}

extension StringExtension on String? {
  bool validateSaudiPhoneNumber() => hasMatch(this, r'^5[0-9]{8}$');
}
