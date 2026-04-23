# Test Target Notes

Apply these instructions only when working inside `swift-agents-skillsTests`.
## Swift Testing

- Use `import Testing`.
- Prefer `@Test` for test functions and `@Suite` when grouping related tests.
- Use `#expect(...)` and `#require(...)` instead of `XCTAssert*`.
- Mark tests `async` when the code under test uses Swift concurrency.
- Mark tests `throws` when validating throwing code paths.
- Use `@MainActor` for tests that touch SwiftUI or main-thread-only state.

## Test Design

- Keep each test focused on one behavior or scenario.
- Build dependencies through injection so they can be replaced with test doubles.
- Avoid shared mutable state between tests.

## Coverage

- Test success and failure paths.
- Test nil, empty, and boundary values where applicable.
- Use parameterized tests when the same assertion applies to multiple inputs.

## Maintenance

- Keep test names descriptive and behavior-oriented.
- Prefer small helpers over duplicated setup.
- If a test is expected to fail temporarily, mark it explicitly with the appropriate Swift Testing trait instead of leaving it flaky.

