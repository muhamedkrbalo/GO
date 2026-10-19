---
paths:
  - "test/**/*.dart"
  - "lib/features/**/controller/**"
  - "lib/features/**/repository/**"
---

# Testing rules

- Every new or changed Cubit gets unit tests in `test/<name>_test.dart`. Cover the success path, the failure path, and guard conditions (for example `canVerify == false` does nothing).
- Fake dependencies with small hand-written classes that implement the interface (`class _FakeAuthRepository implements AuthRepository`). Do not add mocking packages without asking.
- Create the Cubit in `setUp` and close it in `tearDown`.
- For timers, use `fakeAsync` instead of real delays.
- For router or auth tests, follow `test/auth_flow_test.dart`: a fake `SecureStorageService`, `Hive.init` on a temp dir, and `AuthSession` registered in `sl` before `AppRouters` is touched. Reset `sl` between tests.
- Tests use `package:flutter_hr_erb/...` imports.
- A test must fail if the behavior breaks. Do not write tests that only assert a mock was called.
- Run `flutter test` before saying the work is done, and report any failures verbatim.
