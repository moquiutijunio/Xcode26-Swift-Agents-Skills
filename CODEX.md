# Global Code Instructions
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

## Communication and Scope of Actions
To avoid unexpected changes to the project, follow these communication rules:

- Do not alter, create, or remove files/code unless the user explicitly requests it (e.g., "do", "edit", "add", "remove", "refactor").
- Questions, comments, or discussions without an explicit request for changes must not result in any code modifications.
- When there is ambiguity, ask for clarification and confirm whether the requested action involves editing code before proceeding.
- Upon receiving a change request, summarize in one sentence what will be done, briefly outline the plan in a few bullets, and only then apply the changes.
- If the user asks to only explain, research, or review, limit the response to explanation/research/review with no edits.
- Never guess requirements or proactively implement anything without a clear instruction from the user.
- If a change could have broad impact, highlight potential effects and confirm the desired scope when necessary before executing.
