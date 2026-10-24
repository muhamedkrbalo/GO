# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

"GO" is a Flutter vacation-rentals app. The Dart package name is `flutter_hr_erb`, so imports look like `package:flutter_hr_erb/...`.

## Commands

```bash
flutter pub get
flutter run
flutter analyze                          # strict lint set in analysis_options.yaml
flutter test                             # all tests
flutter test test/auth_flow_test.dart    # single file
flutter test --plain-name "name"         # single test by name
```

## Architecture

**Startup.** `main.dart` → `ServiceInitialize.initialize()` (EasyLocalization, GetIt, Hive box `app`, HydratedBloc storage) → `runApp(GO)` (`app.dart`, a `MaterialApp.router`).

**Auth and navigation (`core/auth/auth_session.dart`, `core/routes/app_routers.dart`).**
- `AuthSession` is a `ValueNotifier<AuthStatus>` (`unknown` / `authenticated` / `unauthenticated`), and it is the router's `refreshListenable`. All auth navigation goes through the single `_authRedirect`: `unknown` → splash, `unauthenticated` → onboarding on first launch (`HiveMethods.isFirstTime`) or welcome afterwards (login is also allowed), `authenticated` → home.
- Screens never navigate because of auth. Call `AuthSession.signIn` / `signOut` and the router redirects.
- `restore()` is started (not awaited) during init. While it runs the status stays `unknown`, which keeps the splash on screen. `minSplashDuration` sets the minimum splash time.
- On a 401, `AppInterceptors` calls `signOut()`.
- Route paths and names live in `RoutePaths` / `RouteNames` (`routes_name.dart`).

**Feature layering (`lib/features/<feature>/`).**
- The chain is `presentation/controller` (Cubit + `part` state with `CubitStatus`) → `data/repository` (an abstract interface plus an `Impl`) → `ApiConsumer`.
- There is no domain/use-case layer. `core/common/use_case` is intentionally commented out.
- Each feature has `data/{model,repository}` and `presentation/{controller,view/screen,view/widget}`.

**Network (`core/network/`).**
- `ApiConsumer` (implemented by `DioConsumer`) returns decoded JSON maps.
- Repositories wrap calls in `handleDioRequest(request: ...)`, which returns `Either<Failure, T>` (dartz). It maps Dio errors to the localized `NetworkFailure` / `ServerFailure` (`core/error/failures.dart`).
- `AppInterceptors` adds the `Accept-Language` header (from Hive) and the Bearer token (from `SecureStorageService`).
- `AppConfig.baseUrl` is still an empty TODO.

**DI (`core/services/service_locator.dart`, GetIt `sl`).**
- App-wide services and app-lifetime Cubits use `registerLazySingleton`. Feature Cubits use `registerFactory`.
- Dependencies are passed through constructors. Never call `sl` inside a class.
- Each feature gets its own `_init<Feature>()`.

**UI conventions.**
- Use the theme tokens in `core/theme/` instead of hardcoded values:
  - `AppColors`: raw palette.
  - `context.customColors`: light/dark-aware colors (`theme/extensions/`).
  - `AppTextStyles`: colorless, Manrope-based (`xxxlBold` display titles use Gelasio). Add color via the theme or `.copyWith`.
  - `AppSpacing` / `AppPadding` / `AppRadius`: `app_sizes.dart`.
- Dialogs, sheets, toasts and loading go through the `UiContextExtension` on `BuildContext` (`core/extension/context_ui_extension.dart`). They are presentation-only; repositories never show UI.
- Reuse the shared widgets in `core/custom_widgets/` (buttons, form fields, images, loading, app bar, …).

**Assets.** `core/images/app_images.dart` (`AppImages`) is generated from the `flutter_assets` section of `pubspec.yaml`. Constant names follow the `assets<Folder><FileName>` pattern. flutter_svg does not render SVG `<filter>` elements, so an SVG exported from Figma with a shadow can render blank. Use a PNG in that case.

**Localization.** Uses easy_localization, with JSON in `i18n/` (`ar`, `en`; the fallback is `ar`). Keys are constants in `AppLocaleKey`, used as `AppLocaleKey.x.tr()`. The current language is stored in Hive (`HiveMethods.getLang`), not by easy_localization.

## Tests

`test/auth_flow_test.dart` shows the pattern for router and auth tests:
- a fake `SecureStorageService`,
- `Hive.init` on a temp dir,
- registering `AuthSession` in `sl` before touching `AppRouters`.

## Rules

Detailed working rules live in `.claude/rules/` and are loaded automatically:
- `workflow.md`: scope, verification (`flutter analyze` must be clean) and git conventions.
- `dart-flutter.md`: new-feature checklist, Cubit/state, widget, theme and navigation rules.
- `localization.md`: every string needs an `AppLocaleKey` plus `en.json` and `ar.json` entries.
- `testing.md`: how Cubit and router tests are written.
