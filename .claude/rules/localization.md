---
paths:
  - "lib/**/*.dart"
  - "i18n/**"
---

# Localization rules

- Every new user-facing string needs **all three** of these, in the same change:
  1. a constant in `lib/core/locale/app_locale_key.dart` (`static const String fooBar = 'fooBar';`),
  2. an entry in `i18n/en.json`,
  3. an entry in `i18n/ar.json` (the fallback locale, so it must never be missing).
- Keys are `camelCase` and describe the meaning, not the screen (`resendCode`, not `verifyScreenButton2`). Reuse an existing key when the text is the same.
- Use `AppLocaleKey.x.tr()`, with `tr(args: [...])` for placeholders (`{}` in the JSON). Never pass a raw string literal to `.tr()`.
- Write Arabic as natural Modern Standard Arabic. If you are unsure of a translation, flag it to the user instead of guessing silently.
- Read the current language from `HiveMethods.getLang`, not from easy_localization.
- Keep both JSON files valid, and keep keys in the same order in both.
