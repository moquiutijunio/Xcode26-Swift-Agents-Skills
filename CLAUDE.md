#  Global Code Instructions
## Overview
- ios 26 SwiftUI app targeting iPhone
- Minimum deployment: iOS 26
- Swift 6 with strict concurrency
- Uses SwiftUI thoughout - no UIKit unless absolutely necessary

## Architeture
- MVVM with @Observable ViewModels (NOT ObservableObject)
- Views own their ViewModel as a @State property
- ViewModels handle all business logic - Views are declaritive only
- Navigation uses NavigationStack with NavagtionPath - Never NavigationView
- Dependency injection through the SwiftUI enviroment

## Testing
- Use Swift Testing framework - NOT XCTest
- Test functions us @Test attribute
- Use #expect() for assertions - NOT XCTAssertEqual
- Run with RunAllTests or RunSomeTests MCP Tools

