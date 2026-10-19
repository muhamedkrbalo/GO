---
paths:
  - "lib/**/*.dart"
---

# Dart and Flutter code rules

## Structure (new feature checklist)
For a feature `foo`, create under `lib/features/foo/`:
1. `data/model/`: plain immutable models with `const` constructors, `fromJson`/`toJson` when they cross the API, and `Equatable` when compared.
2. `data/repository/foo_repository.dart`: an `abstract interface class FooRepository` and a `FooRepositoryImpl(this._apiConsumer)`. Every method returns `Future<Either<Failure, T>>` and wraps its call in `handleDioRequest`. Use `Unit`/`unit` for "no value". Endpoints go in `core/network/end_points.dart`.
3. `presentation/controller/foo_cubit.dart` and `foo_state.dart` (as a `part`).
4. `presentation/view/screen/` for route-level screens and `presentation/view/widget/` for that feature's pieces.
5. Register it in `service_locator.dart` in a new `_initFoo()`: the repository as `registerLazySingleton` and the Cubit as `registerFactory` (or `registerFactoryParam` when it needs route args).
6. Add the route in `RoutePaths`/`RouteNames` and `app_routers.dart`. Provide the Cubit there with `BlocProvider(create: (_) => sl<FooCubit>())`, not inside the screen.

## Cubits and state
- State classes are immutable, extend `Equatable`, have `const` constructors with defaults, a `copyWith`, and list **every** field in `props`.
- Use `CubitStatus` for simple loading flows. Use a feature-specific status enum only when it needs more states (see `VerifyCodeStatus`).
- Put derived values on the state as getters (`canVerify`, `isLocked`). Do not compute them in widgets.
- After every `await` in a Cubit, add `if (isClosed) return;` before `emit`.
- Cancel timers and subscriptions in `close()`.
- Cubits never import Flutter UI, never navigate and never show toasts or dialogs.

## Widgets
- Screens stay thin. Extract any meaningful section into its own widget class in `view/widget/`. Do not use `_buildX()` helper methods that return widgets.
- Rebuild narrowly with `BlocSelector` or `BlocBuilder(buildWhen:)`. Use `BlocListener(listenWhen:)` for side effects (toast, navigation).
- Read the Cubit with `context.read<T>()` in callbacks and `context.watch`/`select` only in `build`.
- Use `const` constructors and `super.key` everywhere possible.
- After an `await` in a widget, check `context.mounted` before using `context`.
- Support RTL: use `EdgeInsetsDirectional`, `AlignmentDirectional` and `start`/`end`, never `left`/`right`. Force `TextDirection.ltr` only for phone numbers, codes and emails.

## Theme and styling (no hardcoded values)
- Colors come from `context.customColors` (light/dark aware). Use `AppColors` only inside theme definitions.
- Text styles come from `AppTextStyles.*`, with color added through `.copyWith`.
- Spacing comes from `AppSpacing.gapV*`/`gapH*`, padding from `AppPadding.*`, radii from `AppRadius.*`. If a needed size is missing, add it to `app_sizes.dart` instead of writing a literal.
- Images and icons come from `AppImages`. Never write an asset path string.

## Strings
- No user-facing hardcoded strings. Use `AppLocaleKey.x.tr()` (see the localization rules).

## Navigation and auth
- Navigate with `context.pushNamed(RouteNames.x)` / `context.goNamed`. Pass typed args objects through `extra`, and guard them with a route-level `redirect`.
- Never navigate because of an auth change. Call `AuthSession.signIn`/`signOut` and let `_authRedirect` decide.
- Never use `AppRouters.navigatorKey.currentContext`. Pass a `BuildContext`.

## Data and services
- Never call `sl` inside a class. Inject through the constructor.
- Tokens and secrets go in `SecureStorageService`. Use Hive only for non-sensitive preferences.
- Repositories return `Either`. They never throw to the UI and never show UI.

## Style
- Use relative imports inside `lib/` (matching the existing code). Tests use `package:flutter_hr_erb/...`.
- Use single quotes and trailing commas, and order directives (dart, package, relative).
- No `print`. Use `debugPrint` or `log` from `dart:developer`, and remove it before finishing.
- Name files in `snake_case` and match the main class (`verify_code_cubit.dart` → `VerifyCodeCubit`).
- Do not write comments of any kind: no `//`, no `///` doc comments, no commented-out code. Use clear names for classes, methods and variables instead. Leave existing comments as they are unless the user asks to remove them.
