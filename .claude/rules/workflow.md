# Working rules for AI assistants

These rules apply to every task in this repo. CLAUDE.md describes the architecture; these rules describe how to work inside it.

## Before writing code
- Read the nearest existing example first and copy its shape. The `auth` feature is the reference implementation: `verify_code_cubit.dart`, `auth_repository.dart`, `verify_code_screen.dart`.
- Search `core/custom_widgets/`, `core/extension/` and `core/theme/` before creating a widget, extension or token. Do not duplicate one that already exists.
- If the request is ambiguous (which screen, what API shape, what copy), ask. Do not invent backend fields or endpoints.

## Scope
- Change only what the task needs. Do not reformat, rename or "clean up" unrelated files in the same change.
- Do not add packages to `pubspec.yaml` without asking. Check first whether an existing dependency already covers the need (`dio`, `dartz`, `gap`, `flutter_svg`, `cached_network_image`, `pinput`, …).
- Do not edit generated files by hand (`core/images/app_images.dart`, anything under `build/`, `.dart_tool/`).
- Do not add comments to code. This includes `//`, `///` doc comments, TODOs and commented-out code. Explain anything that needs explaining in the reply to the user, not in the code.
- Do not touch platform folders (`android/`, `ios/`, …) unless the task is explicitly about them.

## After writing code
1. `flutter analyze` must report **no issues**. Fix lints; never silence them with `// ignore:` unless the user agrees.
2. `dart format` the files you changed.
3. Run `flutter test` when you touch a Cubit, a repository, routing or auth.
4. Report honestly. If something is untested or left as a TODO, say so.

## Git
- Never commit or push unless asked. Work on a feature branch, never directly on `main`.
- Commit messages use Conventional Commits with a scope: `feat(auth): …`, `fix(home): …`, `refactor(core): …`.
- Never commit secrets, API keys, `google-services.json` changes or real user data.
