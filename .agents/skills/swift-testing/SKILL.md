# Swift Testing

## Overview

This skill provides expert guidance on Swift Testing, covering the modern Swift Testing framework, test doubles (mocks, stubs, spies), fixtures, integration testing, snapshot testing, and migration from XCTest. Use this skill to help developers write reliable, maintainable.

## Agent Behavior Contract (Follow These Rules)

1. Use Swift Testing framework (`@Test`, `#expect`, `#require`, `@Suite`) for all new tests, not XCTest.
2. Always structure tests with clear Arrange-Act-Assert phases.
3. Use proper test double terminology per Martin Fowler's taxonomy (Dummy, Fake, Stub, Spy, SpyingStub, Mock).
4. Use `#expect` for soft assertions (continue on failure) and `#require` for hard assertions (stop on failure).

## Quick Decision Tree

When a developer needs testing guidance, follow this decision tree:

1. **Starting fresh with Swift Testing?**
   - Read `references/test-organization.md` for suites, tags, traits
   - Read `references/async-testing.md` for async test patterns

2. **Migrating from XCTest?**
   - Read `references/migration-xctest.md` for migration guide

## Core Syntax

### Basic Test

```swift
import Testing

@Test func basicTest() {
    #expect(1 + 1 == 2)
}
```

### Test with Description

```swift
@Test("Adding items increases cart count")
func addItem() {
    let cart = Cart()
    cart.add(item)
    #expect(cart.count == 1)
}
```

### Async Test

```swift
@Test func asyncOperation() async throws {
    let result = try await service.fetch()
    #expect(result.isValid)
}
```

## Arrange-Act-Assert Pattern

Structure every test with clear phases:

```swift
@Test func calculateTotal() {
    // Given
    let cart = ShoppingCart()
    cart.add(Item(price: 10))
    cart.add(Item(price: 20))

    // When
    let total = cart.calculateTotal()

    // Then
    #expect(total == 30)
}
```

## Assertions

### #expect - Soft Assertion

Continues test execution after failure:

```swift
@Test func multipleExpectations() {
    let user = User(name: "Alice", age: 30)
    #expect(user.name == "Alice")  // If fails, test continues
    #expect(user.age == 30)        // This still runs
}
```

### #require - Hard Assertion

Stops test execution on failure:

```swift
@Test func requireExample() throws {
    let user = try #require(fetchUser())  // Stops if nil
    #expect(user.name == "Alice")
}
```

### Error Testing

```swift
@Test func throwsError() {
    #expect(throws: ValidationError.self) {
        try validate(invalidInput)
    }
}

@Test func throwsSpecificError() {
    #expect(throws: ValidationError.emptyField) {
        try validate("")
    }
}
```

## Reference Files

Load these files as needed for specific topics:

- **`references/test-organization.md`** - Suites, tags, traits, parallel execution
- **`references/async-testing.md`** - Async patterns, confirmation, timeouts, cancellation
- **`references/migration-xctest.md`** - Complete XCTest to Swift Testing migration guide
