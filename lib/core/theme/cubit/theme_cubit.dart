import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

/// Holds the selected [ThemeMode] and persists it across app restarts.
class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  static const _jsonKey = 'themeMode';

  void updateTheme(ThemeMode newMode) => emit(newMode);

  /// Switches between light and dark based on what is currently shown.
  void toggleTheme(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    emit(isDark ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    return ThemeMode.values.asNameMap()[json[_jsonKey]] ?? ThemeMode.system;
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) => {_jsonKey: state.name};
}
